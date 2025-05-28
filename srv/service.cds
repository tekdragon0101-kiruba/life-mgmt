using {com.goforward as db} from '../db/schema';

service LifeMgmtService {
    aspect inFormat {
        name : String(50) @mandatory;
    };

    @odata.draft.enabled
    entity Tasks             as projection on db.Tasks
        actions {
            action createCategory();
        };

            @odata.draft.enabled
    entity LearningResources as
        projection on db.LearningResources {
            *,
            concat(
                Duration, ' ', Time.unit
            ) as TimeDuration : String(20)
        }
        actions {

            @Common.SideEffects: {
                $Type           : 'Common.SideEffectsType',
                TargetProperties: ['/LifeMgmtService.EntityContainer/LearningResources/Format', ],
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
                TargetProperties: ['/LifeMgmtService.EntityContainer/LearningResources/Format', ],
                TargetEntities  : ['/LifeMgmtService.EntityContainer/Format']
            }
            action deleteFormat(name : inFormat  : name  @title: '{i18n>formatName}'  @Common: {
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

}

annotate LifeMgmtService with @path: '/life-mgmt';
annotate LifeMgmtService with @requires: 'authenticated-user';
