using LifeMgmtService as service from '../../srv/service';


annotate service.Tasks with @(UI: {
    SelectionFields     : [
        Title,
        PriorityLevel_code,
        Status_code,
        Tags.name
    ],
    LineItem            : [
        {Value: Title},
        {Value: Description},
        {Value: AssignedTo},
        {Value: PriorityLevel_code},
        {Value: Status_code},
        {Value: StartDate},
        {Value: DueDate},
        {Value: CompletionDate},
        {Value: EstimatedDuration},
        {Value: ActualDuration},
        {Value: TaskType},
        {Value: Tags.name},
        {Value: CommentsNotes},
    ],
    HeaderInfo          : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : '{i18n>task}',
        TypeNamePlural: '{i18n>Tasks}',
        Title         : {Value: Title, },
        Description   : {Value: Description, },
    },
    HeaderFacets        : [{
        $Type : 'UI.ReferenceFacet',
        Target: '@UI.FieldGroup#UserLogs',
    }, ],
    FieldGroup #UserLogs: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {Value: createdAt},
            {Value: createdBy},
            {Value: modifiedAt},
            {Value: modifiedBy}
        ],
    },
});


//////////////////////////////////////////////////////////
// Object report page for Tasks

annotate service.Tasks with @(
    UI.FieldGroup #GeneratedGroup: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {Value: Title, },
            {Value: Description, },
            {Value: AssignedTo, },
            {Value: PriorityLevel_code, },
            {Value: Status_code, },
            {Value: StartDate, },
            {Value: DueDate, },
            {Value: CompletionDate, },
            {Value: EstimatedDuration, },
            {Value: ActualDuration, },
            {Value: TaskType, },
            {Value: Tags.name}
        ],
    },
    UI.FieldGroup #Comment       : {
        $Type: 'UI.FieldGroupType',
        Data : [{
            $Type: 'UI.DataField',
            Value: CommentsNotes,
        }, ],
    },
    UI.Facets                    : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneratedFacet1',
            Label : 'Task',
            Target: '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.FieldGroup#Comment',
            Label : 'Comments',
            ID    : 'CommentsFacet',
        },
    ]
);
