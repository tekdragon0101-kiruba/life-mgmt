using {com.gofarward as db} from '../db/schema';

service LifeMgmtService {
    @odata.draft.enabled
    entity Tasks             as projection on db.Tasks;

    @odata.draft.enabled
    entity LearningResources as projection on db.LearningResources;

    @odata.draft.enabled: false
    entity Tags              as projection on db.TagLabels;
}

annotate LifeMgmtService with @path: '/life-mgmt';
annotate LifeMgmtService with @requires: 'authenticated-user';
