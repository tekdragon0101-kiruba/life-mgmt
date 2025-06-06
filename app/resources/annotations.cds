using LifeMgmtService as service from '../../srv/service';
using from '../../db/schema';


annotate service.LearningResources with @(
    UI                                : {
        SelectionFields     : [
            Title,
            Category,
            Status_code,
            Tags.name
        ],
        LineItem            : [
            {Value: Title},
            {Value: Category},
            {Value: Subject},
            {Value: AuthorSource},
            {Value: PublicationDate},
            {
                $Type: 'UI.DataFieldWithUrl',
                Value: AccessLink,
                Url  : AccessLink,
            },
            {Value: Format_name},
            {
                Value     : TimeDuration,
                Label     : 'Time Duration',
                @UI.Hidden: {$edmJson: {$Not: {$Path: 'IsActiveEntity'}}},
            },
            {Value: Description},
            {Value: DifficultyLevel_levelName},
            {Value: Status_code},
            {Value: Tags.name}
        ],
        HeaderInfo          : {
            $Type         : 'UI.HeaderInfoType',
            TypeName      : '{i18n>resource}',
            TypeNamePlural: '{i18n>resources}',
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

    },
    UI.Facets                         : [{
        $Type : 'UI.ReferenceFacet',
        Label : '{i18n>ResourceDetails}',
        ID    : 'i18nResourceDetails',
        Target: '@UI.FieldGroup#i18nResourceDetails',
    }, ],
    UI.FieldGroup #i18nResourceDetails: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {Value: Title},
            {Value: Category},
            {Value: Subject},
            {Value: AuthorSource},
            {Value: PublicationDate},
            {
                $Type: 'UI.DataFieldWithUrl',
                Value: AccessLink,
                Url  : AccessLink,
            },
            {Value: Format_name},

            {
                Value     : Time_unit,
                Label     : 'Time Unit',
                @UI.Hidden: IsActiveEntity,
            },
            {
                Value     : Duration,
                @UI.Hidden: IsActiveEntity,
            },
            {
                Value     : TimeDuration,
                Label     : 'Time Duration',
                @UI.Hidden: {$edmJson: {$Not: {$Path: 'IsActiveEntity'}}},
            },
            // {
            //     Value     : {$edmJson: {
            //         $Apply   : [
            //             Duration,
            //             ' ',
            //             Time_unit

            //         ],
            //         $Function: 'odata.concat',
            //     }, },
            //     @UI.Hidden: {$edmJson: {$Not: {$Path: 'IsActiveEntity'}}},
            //     Label     : 'Time Duration'
            // },
            {Value: Description},
            {Value: DifficultyLevel_levelName},
            {Value: Status_code},
            {Value: Tags.name},
            {
                $Type     : 'UI.DataFieldForAction',
                Action    : 'LifeMgmtService.createFormat',
                Label     : '{i18n>createFormat}',
                @UI.Hidden: IsActiveEntity,
            },
            {
                $Type     : 'UI.DataFieldForAction',
                Action    : 'LifeMgmtService.editFormat',
                Label     : '{i18n>editFormat}',
                @UI.Hidden: IsActiveEntity,
            },
            {
                $Type     : 'UI.DataFieldForAction',
                Action    : 'LifeMgmtService.deleteFormat',
                Label     : '{i18n>deleteFormat}',
                @UI.Hidden: IsActiveEntity,
            }
        ],
    },
);

annotate service.LearningResources with {
    DifficultyLevel @(
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'DifficultyLevel',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: DifficultyLevel_levelName,
                ValueListProperty: 'levelName',
            }, ],
            Label         : '{i18n>DifficultyLevel1}',
        },
        Common.ValueListWithFixedValues: true
    );
    Status          @(
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'Status',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: Status_code,
                    ValueListProperty: 'code',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'descr',
                },
            ],
            Label         : '{i18n>Status}',
        },
        Common.ValueListWithFixedValues: true,
        Common.Text                    : {
            $value                : Status.descr,
            ![@UI.TextArrangement]: #TextFirst,
        },
    );
    Category        @(
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'Categories',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: Category,
                    ValueListProperty: 'Name',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'Description',
                },
            ],
            Label         : '{i18n>Category}',
        },
        Common.ValueListWithFixedValues: false
    );
    AccessLink      @Common: {
        Text           : Title,
        TextArrangement: #TextOnly,
    };
    Time            @Common: {ValueListWithFixedValues, };
    Format          @Common: {ValueListWithFixedValues, };
};

annotate service.Categories with {
    Name @Common.Text: Description
};
