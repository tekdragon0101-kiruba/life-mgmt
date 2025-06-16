using {com.goforward as db} from './schema';

annotate db.LearningResources with {
    ResourceID      @title: '{i18n>ResourceID}';
    Title           @title: '{i18n>Title}';
    Category        @title: '{i18n>Category}';
    Subject         @title: '{i18n>Subject}';
    AuthorSource    @title: '{i18n>AuthorSource}';
    PublicationDate @title: '{i18n>PublicationDate}';
    AccessLink      @title: '{i18n>AccessLink}';
    Format          @title: '{i18n>Format}';
    Duration        @title: '{i18n>Duration}';
    Description     @title: '{i18n>Description}';
    DifficultyLevel @title: '{i18n>DifficultyLevel}';
};

annotate db.Tasks with {
    TaskID            @title: '{i18n>TaskID}';
    Title             @title: '{i18n>Title}';
    Description       @title: '{i18n>Description}';
    AssignedTo        @title: '{i18n>AssignedTo}';
    PriorityLevel     @title: '{i18n>PriorityLevel}';
    Status            @title: '{i18n>Status}';
    StartDate         @title: '{i18n>StartDate}';
    DueDate           @title: '{i18n>DueDate}';
    CompletionDate    @title: '{i18n>CompletionDate}';
    EstimatedDuration @title: '{i18n>EstimatedDuration}';
    ActualDuration    @title: '{i18n>ActualDuration}';
    TaskType          @title: '{i18n>TaskType}';
    Tags              @title: '{i18n>Tags}';
    CommentsNotes     @title: '{i18n>CommentsNotes}';
};

annotate db.Goals with {
    ID          @title: '{i18n>ID}';
    Title       @title: '{i18n>Title}';
    Description @title: '{i18n>Description}';
    TargetDate  @title: '{i18n>TargetDate}';
    Progress    @title: '{i18n>Progress}';
    relatedTo @title : '{i18n>GoalRelatedTo}';
    Status      @title: '{i18n>Status}';
};


annotate db.Priority with {
    code  @title: '{i18n>code}';
    descr @title: '{i18n>descr}';
};

annotate db.Status with {
    code  @title: '{i18n>code}';
    descr @title: '{i18n>descr}';
};

annotate db.TagLabelTasks with {
    ID   @title: '{i18n>TagID}';
    name @title: '{i18n>Tagname}';
    task @title: '{i18n>task}';

};

annotate db.TagLabelResources with {
    ID       @title: '{i18n>TagID}';
    name     @title: '{i18n>Tagname}';
    resource @title: '{i18n>resource}';

};

annotate db.Types with {
    name  @title: '{i18n>TypeName}';
    descr @title: '{i18n>descr}'
};

annotate db.DifficultyLevel with {
    levelName @title: '{i18n>DifficultyLevel}'
};
