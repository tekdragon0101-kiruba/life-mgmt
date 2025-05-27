using {LifeMgmtService as service} from './service';

//////////////////////////////////////////////////////////
// List report page for Resources


//////////////////////////////////////////////////////////
// Object report page for Resources

//////////////////////////////////////////////////////////
// List report page for Tasks

// annotate service.Tasks with @(UI: {
//     SelectionFields     : [
//         Title,
//         PriorityLevel_code,
//         Status_code,
//         Tags.name
//     ],
//     LineItem            : [
//         {Value: TaskID},
//         {Value: Title},
//         {Value: Description},
//         {Value: AssignedTo},
//         {Value: PriorityLevel_code},
//         {Value: Status_code},
//         {Value: StartDate},
//         {Value: DueDate},
//         {Value: CompletionDate},
//         {Value: EstimatedDuration},
//         {Value: ActualDuration},
//         {Value: TaskType},
//         {Value: Tags.name},
//         {Value: CommentsNotes},
//         {Value: Dependencies_TaskID},
//         {Value: parentTask_TaskID}
//     ],
//     HeaderInfo          : {
//         $Type         : 'UI.HeaderInfoType',
//         TypeName      : '{i18n>task}',
//         TypeNamePlural: '{i18n>Tasks}',
//     },
//     HeaderFacets        : [{
//         $Type : 'UI.ReferenceFacet',
//         Target: '@UI.FieldGroup#UserLogs',
//     }, ],
//     Facets #Group       : [{
//         $Type : 'UI.ReferenceFacet',
//         Target: '@UI.FieldGroup#Tasks',
//     }, ],
//     FieldGroup #UserLogs: {
//         $Type: 'UI.FieldGroupType',
//         Data : [
//             {Value: createdAt},
//             {Value: createdBy},
//             {Value: modifiedAt},
//             {Value: modifiedBy}
//         ],
//     },
//     FieldGroup #Tasks   : {
//         $Type: 'UI.FieldGroupType',
//         Data : [
//             {Value: TaskID},
//             {Value: Title},
//             {Value: Description},
//             {Value: AssignedTo},
//             {Value: PriorityLevel_code},
//             {Value: Status_code},
//             {Value: StartDate},
//             {Value: DueDate},
//             {Value: CompletionDate},
//             {Value: EstimatedDuration},
//             {Value: ActualDuration},
//             {Value: TaskType},
//             {Value: Tags.name},
//             {Value: CommentsNotes},
//             {Value: Dependencies_TaskID},
//             {Value: parentTask_TaskID}
//         ],
//     },
// });


//////////////////////////////////////////////////////////
// Object report page for Tasks


//////////////////////////////////////////////////////////
// Value Help for Resources


//////////////////////////////////////////////////////////
// Value Help for Tasks
