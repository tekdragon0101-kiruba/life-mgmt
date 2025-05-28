using {com.gofarward as db} from '../db/schema';

service LifeMgmtService {
    @odata.draft.enabled
    entity Tasks             as projection on db.Tasks;

    @odata.draft.enabled
    entity LearningResources as projection on db.LearningResources;

    entity TaskTags          as projection on db.TagLabelTasks;
    entity ResourceTags      as projection on db.TagLabelResources;
    entity Status            as projection on db.Status;
}

annotate LifeMgmtService with @path: '/life-mgmt';
annotate LifeMgmtService with @requires: 'authenticated-user';
