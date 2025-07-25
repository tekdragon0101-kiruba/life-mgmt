using {LifeMgmtService as service} from './service';

annotate service.Tasks with {
    CommentsNotes @UI.Placeholder: 'e.g. What you will learn if you complete this...'
};

annotate service.LearningResources with {
    ResourceID  @UI.Hidden: true  @Common: {
        Text           : Title,
        TextArrangement: #TextOnly,
    }
};
