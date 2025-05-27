const cds = require('@sap/cds')

module.exports = class LifeMgmtService extends cds.ApplicationService {
  init() {

    const { Tasks, LearningResources, Tags } = cds.entities('LifeMgmtService');
    this.before('CREATE', [Tasks, Tasks.drafts], async (req) => {
      await this.sequenceGenerator(req, Tasks);
    });

    // this.before (['CREATE', 'UPDATE'], Tasks, async (req) => {
    //   console.log('Before CREATE/UPDATE Tasks', req.data)
    // })
    // this.after ('READ', Tasks, async (tasks, req) => {
    //   console.log('After READ Tasks', tasks)
    // })
    // this.before (['CREATE', 'UPDATE'], LearningResources, async (req) => {
    //   console.log('Before CREATE/UPDATE LearningResources', req.data)
    // })
    // this.after ('READ', LearningResources, async (learningResources, req) => {
    //   console.log('After READ LearningResources', learningResources)
    // })
    // this.before (['CREATE', 'UPDATE'], Tags, async (req) => {
    //   console.log('Before CREATE/UPDATE Tags', req.data)
    // })
    // this.after ('READ', Tags, async (tags, req) => {
    //   console.log('After READ Tags', tags)
    // })

    return super.init()
  }
  async sequenceGenerator(req, entity) {
    if (req.subject?.ref && String(req.subject?.ref[0]).search('drafts') !== -1) {
      const maxTask = await this.findMaxId(entity);
      // If no existing entries, start from 1, else increment
      req.data.TaskID = (maxTask?.maxId || 0) + 1;
      return;
    }
    if (!req.data.TaskID) {
      const maxTask = await this.findMaxId(entity);
      // If no existing entries, start from 1, else increment
      req.data.TaskID = (maxTask?.maxId || 0) + 1;
      return;
    }
    return;
  }
  async findMaxId(entity) {
    const maxTaskNo = await SELECT.one.from(entity).columns('max(TaskID) as maxId');
    const maxTaskNoDraft = await SELECT.one.from(entity.drafts).columns('max(TaskID) as maxId');
    const maxTask = (maxTaskNo.maxId > maxTaskNoDraft.maxId ? maxTaskNo : maxTaskNoDraft);
    return maxTask;
  }
}
