const cds = require('@sap/cds')

module.exports = class LifeMgmtService extends cds.ApplicationService { init() {

  const { Tasks, LearningResources, TaskTags, ResourceTags } = cds.entities('LifeMgmtService')

  this.before (['CREATE', 'UPDATE'], Tasks, async (req) => {
    console.log('Before CREATE/UPDATE Tasks', req.data)
  })
  this.after ('READ', Tasks, async (tasks, req) => {
    console.log('After READ Tasks', tasks)
  })
  this.before (['CREATE', 'UPDATE'], LearningResources, async (req) => {
    console.log('Before CREATE/UPDATE LearningResources', req.data)
  })
  this.after ('READ', LearningResources, async (learningResources, req) => {
    console.log('After READ LearningResources', learningResources)
  })
  this.before (['CREATE', 'UPDATE'], TaskTags, async (req) => {
    console.log('Before CREATE/UPDATE TaskTags', req.data)
  })
  this.after ('READ', TaskTags, async (taskTags, req) => {
    console.log('After READ TaskTags', taskTags)
  })
  this.before (['CREATE', 'UPDATE'], ResourceTags, async (req) => {
    console.log('Before CREATE/UPDATE ResourceTags', req.data)
  })
  this.after ('READ', ResourceTags, async (resourceTags, req) => {
    console.log('After READ ResourceTags', resourceTags)
  })


  return super.init()
}}
