const cds = require('@sap/cds')
const fs = require('fs');

module.exports = class LifeMgmtService extends cds.ApplicationService {
  async init() {

    const { Tasks, LearningResources, TaskTags, ResourceTags, Status, Format, Categories } = cds.entities('LifeMgmtService');
    this.rewardService = await cds.connect.to('RewardsMgmtService');

    this.on('READ', Categories, async (req) => {
      const { Categories } = this.rewardService.entities;
      const result = await this.rewardService.run(req.query);
      // console.log("after result", result);
      return result;
    })

    this.before(['CREATE', 'UPDATE'], Tasks, async (req) => {
      console.log('Before CREATE/UPDATE Tasks', req.data)
    })
    this.after('READ', Tasks, async (tasks, req) => {
      console.log('After READ Tasks', tasks)
    })
    this.before(['CREATE', 'UPDATE'], LearningResources, async (req) => {
      console.log('Before CREATE/UPDATE LearningResources', req.data)
    })
    this.after('READ', LearningResources, async (learningResources, req) => {
      console.log('After READ LearningResources', learningResources)
    })
    this.before(['CREATE', 'UPDATE'], TaskTags, async (req) => {
      console.log('Before CREATE/UPDATE TaskTags', req.data)
    })
    this.after('READ', TaskTags, async (taskTags, req) => {
      console.log('After READ TaskTags', taskTags)
    })
    this.before(['CREATE', 'UPDATE'], ResourceTags, async (req) => {
      console.log('Before CREATE/UPDATE ResourceTags', req.data)
    })
    this.after('READ', ResourceTags, async (resourceTags, req) => {
      console.log('After READ ResourceTags', resourceTags)
    })
    this.before(['CREATE', 'UPDATE'], Status, async (req) => {
      console.log('Before CREATE/UPDATE Status', req.data)
    })
    this.after('READ', Status, async (status, req) => {
      console.log('After READ Status', status)
    })

    this.on('createFormat', async (req) => {
      console.log('On createFormat', req.data, req.params);
      const name = req.data.name[0].toUpperCase() + req.data.name.slice(1, req.data.name.length).toLowerCase();
      await INSERT.into(Format).entries({ name: name });
      req.notify("Format created Successfully");
    })
    this.on('editFormat', async (req) => {
      console.log('On editFormat', req.data, req.params);
      const name = req.data.newName[0].toUpperCase() + req.data.newName.slice(1, req.data.newName.length).toLowerCase();
      await INSERT.into(Format).entries({ name: name });
      await DELETE.from(Format).where({ name: req.data.name });
      await UPDATE(LearningResources.drafts).set({ Format_name: name }).where(req.params[0]);
      req.notify("Format updated Successfully");
    })
    this.on('deleteFormat', async (req) => {
      console.log('On deleteFormat', req.data);
      await DELETE.from(Format).where(req.data);
      req.notify(`Format ${req.data.name} deleted`);
    })

    return super.init()
  }
}
