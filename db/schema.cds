namespace com.gofarward;

using {
    cuid,
    managed
} from '@sap/cds/common';


entity LearningResources : managed {
    ResourceID      : UUID; // Unique identifier
    Title           : String(255); // Name of the learning material
    Category        : String(100); // Type (e.g., book, video, article, course)
    Subject         : String(1000) @UI.MultiLineText; // Topic or field covered
    AuthorSource    : String(255); // Creator or provider
    PublicationDate : Date; // Date when it was published
    AccessLink      : String(500)  @Core.IsURL; // URL or location where it can be found
    Format          : String(50); // Medium (e.g., PDF, online course, book)
    Duration        : Integer; // Estimated time (in minutes)
    Description     : String       @UI.MultiLineText; // Short summary explaining the resource
    DifficultyLevel : String(20); // Beginner, Intermediate, Advanced
    Status          : String(20); // Completed, In Progress, Not Started
    Tags            : Composition of many TagLabels
                          on Tags.resource = $self; // Searchable terms
    AddedDate       : Timestamp; // When the resource was added
}

entity Tasks : managed {
    TaskID            : Decimal(3, 2); // Unique identifier
    Title             : String(255); // Brief name of the task
    Description       : String(1000) @UI.MultiLineText; // Detailed task explanation
    AssignedTo        : String(255); // Person or team responsible
    PriorityLevel     : Association to Priority; // Low, Medium, High, Critical
    Status            : Association to Status; // Not Started, In Progress, Completed, On Hold
    StartDate         : Date; // When the task begins
    DueDate           : Date; // Deadline for completion
    CompletionDate    : Date; // Date when finished
    EstimatedDuration : Integer; // Expected time (in hours or days)
    ActualDuration    : Integer; // Time actually spent
    TaskType          : String(100); // Categorization (Development, Research, Review)
    Tags              : Composition of many TagLabels
                            on Tags.task = $self;
    CommentsNotes     : String(1000);
    parentTask        : Association to Tasks;
    subtasks          : Composition of many Tasks
                            on subtasks.parentTask = $self;
}


/* Value Help Entities */

@assert.unique: {name: [
    ID,
    name
], }
entity TagLabels : cuid {
    name     : String(255);
    task     : Association to Tasks;
    resource : Association to LearningResources;
}

@cds.odata.valuelist
@cds.autoexpose
entity Priority {
    key code  : String(1) @assert.range enum {
            Low = 'L';
            Medium = 'M';
            High = 'H';
            Critical = 'C';
        } default #Medium;
        descr : String(10);
}

@cds.odata.valuelist
@cds.autoexpose
entity Status {
    key code  : String(1) @assert.range enum {
            In_progress = 'I';
            Completed = 'C';
            Not_started = 'N';
            On_hold = 'H'
        } default #Not_started;
        descr : String(20);
}
