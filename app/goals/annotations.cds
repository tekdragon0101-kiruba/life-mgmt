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
                Value: relatedTo_name
            },
            {
                $Type: 'UI.DataField',
                Value: TargetDate,
            },
            {
                $Type : 'UI.DataFieldForAnnotation',
                Target: '@UI.DataPoint#progess',
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
            Value: relatedTo_name
        },
        {
            $Type: 'UI.DataField',
            Value: TargetDate,
        },
        {
            $Type : 'UI.DataFieldForAnnotation',
            Target: '@UI.DataPoint#progess',
        },
        {
            $Type: 'UI.DataField',
            Value: Status_code,
        },
    ],
    UI                           : {DataPoint #progess: {
        $Type        : 'UI.DataPointType',
        Value        : Progress,
        MinimumValue : 0,
        MaximumValue : 100,
        TargetValue  : 100,
        Visualization: #Progress,
    }, },
    UI                           : {HeaderInfo #Heading: {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : 'Goal',
        TypeNamePlural: 'Goals',
        Title         : {
            $Type: 'UI.DataField',
            Value: Title,
        },
        Description   : {
            $Type: 'UI.DataField',
            Value: Description,
        },
    }, },
);

annotate service.Goals with {
    Status    @Common: {
        Text                    : Status.descr,
        TextArrangement         : #TextOnly,
        ValueListWithFixedValues: true,
    };
    relatedTo @Common: {ValueListWithFixedValues: true, }
};
