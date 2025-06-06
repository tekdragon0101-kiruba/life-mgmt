using {LifeMgmtService as service} from './service';

annotate service.Tasks with {
    CommentsNotes @UI.Placeholder: 'e.g. What you will learn if you complete this...'
};

annotate service.LearningResources with {
    AccessLink  @Common: {
        Text           : Title,
        TextArrangement: #TextOnly,
    } 
};

annotate service.LearningResources with {
    Time   @Common: {ValueListWithFixedValues, };
    Format @Common: {ValueListWithFixedValues, };
};
