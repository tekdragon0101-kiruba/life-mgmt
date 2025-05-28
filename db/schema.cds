namespace com.gofarward;

using {
    cuid,
    managed
} from '@sap/cds/common';


entity LearningResources : managed {
    key ResourceID      : UUID; // Unique identifier
        Title           : String(255); // Name of the learning material
        Category        : String(100); // Type (e.g., book, video, article, course)
        Subject         : String(1000)                   @UI.MultiLineText; // Topic or field covered
        AuthorSource    : String(255); // Creator or provider
        PublicationDate : Date; // Date when it was published
        AccessLink      : String(500); // URL or location where it can be found
        Format          : String(50); // Medium (e.g., PDF, online course, book)
        Duration        : Integer;
        Description     : String                         @UI.MultiLineText; // Short summary explaining the resource
        DifficultyLevel : Association to DifficultyLevel @mandatory;
        Status          : String(20) default 'Not Started'; // Completed, In Progress, Not Started
        Tags            : Composition of many TagLabelResources
                              on Tags.resource = $self; // Searchable terms
}

entity Tasks : managed {
    key TaskID            : UUID; // Unique identifier
        Title             : String(255)              @mandatory; // Brief name of the task
        Description       : String(1000)             @UI.MultiLineText; // Detailed task explanation
        AssignedTo        : String(255)              @readonly  @cds.on.insert: $user; // Person or team responsible
        PriorityLevel     : Association to Priority  @mandatory; // Low, Medium, High, Critical
        Status            : String(20) default 'Not Started'; // Not Started, In Progress, Completed, On Hold, Overdue
        StartDate         : DateTime default $now    @mandatory; // When the task begins
        DueDate           : DateTime                 @mandatory; // Deadline for completion
        CompletionDate    : DateTime; // Date when finished
        EstimatedDuration : Integer; // Expected time (in hours or days)
        ActualDuration    : Integer; // Time actually spent
        TaskType          : Association to TaskTypes @mandatory; // Categorization (Development, Research, Review)
        Tags              : Composition of many TagLabelTasks
                                on Tags.task = $self;
        CommentsNotes     : String(1000)             @UI.MultiLineText;
// parentTask        : Association to Tasks;
// subtasks          : Composition of many Tasks
//                         on subtasks.parentTask = $self;
}


/* Value Help Entities */

@cds.odata.valuelist
@cds.autoexpose
entity DifficultyLevel {
    key levelName : String(20);
}

@cds.odata.valuelist
@cds.autoexpose
entity TaskTypes {
    key name  : String(50);
        descr : String(500);
}


@assert.unique: {name: [
    ID,
    name
], }
entity TagLabelTasks : cuid {
    name : String(255);
    task : Association to Tasks;
}

entity TagLabelResources : cuid {
    name     : String(255);
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
            On_hold = 'H';
            Overdue = 'O';
        } default #Not_started;
        descr : String(20);
}
