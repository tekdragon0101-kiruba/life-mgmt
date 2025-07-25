using {com.goforward as db} from '../db/schema';
using {RewardsMgmtService as external} from './external/RewardsMgmtService';


service LifeMgmtService {
    aspect inFormat {
        name : String(50) @mandatory;
    };

            @odata.draft.enabled
    entity Tasks             as projection on db.Tasks
        actions {
            @Common                         : {SideEffects #createTaskFromResource: {
                $Type         : 'Common.SideEffectsType',
                TargetEntities: ['/LifeMgmtService.EntityContainer/Tasks'],
                // TargetProperties: ['/LifeMgmtService.EntityContainer/Tasks/Tags/name']
            }, }
            @cds.odata.bindingparameter.name: '_it'
            action createTaskFromResources(
                                           @Common: {
                                               ValueList: {
                                                   $Type         : 'Common.ValueListType',
                                                   CollectionPath: 'LearningResources',
                                                   Parameters    : [
                                                       {
                                                           $Type            : 'Common.ValueListParameterInOut',
                                                           LocalDataProperty: resourceID,
                                                           ValueListProperty: 'ResourceID',
                                                       },
                                                       {
                                                           $Type            : 'Common.ValueListParameterDisplayOnly',
                                                           ValueListProperty: 'Title',
                                                       },
                                                       {
                                                           $Type            : 'Common.ValueListParameterDisplayOnly',
                                                           ValueListProperty: 'Subject',
                                                       },
                                                   ],
                                               },
                                               Label    : '{i18n>Resources}',

                                           }
                                           resourceID : String(36));
        };

            @odata.draft.enabled
    entity LearningResources as
        projection on db.LearningResources {
            *,
            Duration || ' ' || Time.unit as TimeDuration : String,
            case
                when
                    task.TaskID is null
                then
                    'Unassigned'
                else
                    'Assigned To Task'
            end                          as Status       : String(30)
        }
        actions {

            @Common.SideEffects: {
                $Type           : 'Common.SideEffectsType',
                TargetProperties: ['/LifeMgmtService.EntityContainer/LearningResources/Format_name', ],
                TargetEntities  : ['/LifeMgmtService.EntityContainer/Format']
            }
            action createFormat(name : inFormat  : name @title: '{i18n>formatName}' );

            @Common.SideEffects             : {
                $Type           : 'Common.SideEffectsType',
                TargetProperties: ['_it/Format_name'],
                TargetEntities  : ['/LifeMgmtService.EntityContainer/Format']
            }
            @cds.odata.bindingparameter.name: '_it'
            action editFormat(
                              @UI.ParameterDefaultValue: _it.Format_name
                              name : inFormat    : name  @title: '{i18n>formatName}'  @Common: {
                ValueList: {

                    $Type         : 'Common.ValueListType',
                    CollectionPath: 'Format',
                    Parameters    : [{
                        $Type            : 'Common.ValueListParameterInOut',
                        LocalDataProperty: name,
                        ValueListProperty: 'name',
                    }, ],
                },
                ValueListWithFixedValues,
            },
                              newName : inFormat : name @title: '{i18n>newFormatName}' );

            @Common.SideEffects             : {
                $Type           : 'Common.SideEffectsType',
                TargetProperties: ['/LifeMgmtService.EntityContainer/LearningResources/Format_name', ],
                TargetEntities  : ['/LifeMgmtService.EntityContainer/Format']
            }
            @cds.odata.bindingparameter.name: '_it'
            action deleteFormat( @UI.ParameterDefaultValue: _it.Format_name
                                 name : inFormat : name  @title: '{i18n>formatName}'  @Common: {
                ValueList: {
                    $Type         : 'Common.ValueListType',
                    CollectionPath: 'Format',
                    Parameters    : [{
                        $Type            : 'Common.ValueListParameterInOut',
                        LocalDataProperty: name,
                        ValueListProperty: 'name',
                    }, ],
                },
                ValueListWithFixedValues,
            }  );
        };

    entity TaskTags          as projection on db.TagLabelTasks;
    entity ResourceTags      as projection on db.TagLabelResources;
    entity Status            as projection on db.Status;

    @odata.draft.enabled
    entity Goals             as projection on db.Goals;

    entity Categories        as
        projection on external.Categories {
            ID,
            Name,
            Description
        };
    
}

annotate LifeMgmtService with @protocol: [{
    kind: 'odata',
    path: '/life-mgmt'
} /* ,{kind: 'rest', path:'/rest/life-mgmt'} */];

annotate LifeMgmtService with @requires: 'authenticated-user';

annotate LifeMgmtService.Categories with {
    ID           @Common.Label: 'ID'                    @UI.HiddenFilter;
    Name         @Common.Label: 'Category Name';
    Description  @Common.Label: 'Category Description'  @UI.HiddenFilter;
};
