using {com.gofarward as db} from '../db/schema';

service LifeMgmtService {
    entity Tasks             as projection on db.Tasks;
    @odata.draft.enabled
    entity LearningResources as projection on db.LearningResources;
    entity Tags              as projection on db.TagLabels;
}
