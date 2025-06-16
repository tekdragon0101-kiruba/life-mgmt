namespace com.goforward;

using {
    cuid,
    managed
} from '@sap/cds/common';


entity LearningResources : managed {
    key ResourceID      : UUID;
        Title           : String(255)                     @mandatory;
        Category        : String(100);
        Subject         : String(1000)                    @UI.MultiLineText;
        AuthorSource    : String(255)                     @mandatory;
        PublicationDate : Date;
        AccessLink      : String(500)                     @mandatory;
        Format          : Association to Format           @assert.target; // Medium (e.g., PDF, online course, book)
        Time            : Association to TimeUnits        @mandatory  @assert.target: true;
        Duration        : Integer                         @mandatory;
        Description     : String                          @UI.MultiLineText;
        DifficultyLevel : Association to DifficultyLevel  @mandatory  @assert.target: true;
        Tags            : Composition of many TagLabelResources
                              on Tags.resource = $self; // Searchable terms
        task            : Association to Tasks
                              on task.resource = $self;
}

entity Tasks : managed {
    key TaskID            : UUID; // Unique identifier
        Title             : String(255)             @mandatory; // Brief name of the task
        Description       : String(1000)            @UI.MultiLineText; // Detailed task explanation
        AssignedTo        : String(255)             @readonly   @cds.on.insert: $user; // Person or team responsible
        PriorityLevel     : Association to Priority @mandatory; // Low, Medium, High, Critical
        Status            : Association to Status; // Not Started, In Progress, Completed, On Hold, Overdue
        StartDate         : DateTime default $now   @mandatory; // When the task begins
        DueDate           : DateTime                @mandatory; // Deadline for completion
        CompletionDate    : DateTime; // Date when finished
        EstimatedDuration : Integer; // Expected time (in hours or days)
        ActualDuration    : Integer; // Time actually spent
        TaskType          : Association to Types    @mandatory  @assert.target: true; // Categorization (Development, Research, Review)
        Tags              : Composition of many TagLabelTasks
                                on Tags.task = $self;
        CommentsNotes     : String(5000)            @UI.MultiLineText;
        resource          : Association to LearningResources;
        goal              : Association to Goals    @mandatory  @assert.target: true;
};

entity Goals : cuid {
    Title       : String(255); // Goal name
    relatedTo   : Association to Types;
    Description : String(1000) @UI.MultiLineText;// Detailed explanation
    TargetDate  : Date; // When the goal should be achieved
    Progress    : Decimal(5, 2); // Percentage completion
    Status      : Association to Status; // Not Started, In Progress, Achieved
}


/* Value Help Entities */

@cds.odata.valuelist
@cds.autoexpose
entity Format {
    key name : String(50) @title: '{i18n>formatName}';
}

@cds.odata.valuelist
@cds.autoexpose
entity TimeUnits {
    key unit : String(10) @title: '{i18n>unit}' enum {
            Hours;
            Minutes;
            Seconds;
            Days;
            Weeks;
            Months;
            Years;
        } default #Hours;
}


@cds.odata.valuelist
@cds.autoexpose
entity DifficultyLevel {
    key levelName : String(20) enum {
            Beginner;
            Intermediate;
            Expert;
            Advanced
        } default #Beginner;
}

@cds.odata.valuelist
@cds.autoexpose
entity Types {
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

@assert.unique: {name: [
    ID,
    name
], }
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
