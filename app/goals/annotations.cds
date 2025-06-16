using LifeMgmtService as service from '../../srv/service';

annotate service.Goals with @(
    UI.FieldGroup #GeneratedGroup: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: Title,
            },
            {
                $Type: 'UI.DataField',
                Value: Description,
            },
            {
                $Type: 'UI.DataField',
                Value: TargetDate,
            },
            {
                $Type: 'UI.DataField',
                Value: Progress,
            },
            {
                $Type: 'UI.DataField',
                Value: Status_code,
            },
        ],
    },
    UI.Facets                    : [{
        $Type : 'UI.ReferenceFacet',
        ID    : 'GeneratedFacet1',
        Label : 'General Information',
        Target: '@UI.FieldGroup#GeneratedGroup',
    }, ],
    UI.LineItem                  : [
        {
            $Type: 'UI.DataField',
            Value: Title,
        },
        {
            $Type: 'UI.DataField',
            Value: Description,
        },
        {
            $Type: 'UI.DataField',
            Value: TargetDate,
        },
        {
            $Type: 'UI.DataField',
            Value: Progress,
        },
        {
            $Type: 'UI.DataField',
            Value: Status_code,
        },
    ],
);
