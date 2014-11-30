Template.config.helpers
  repositories: ->
    return Repos.find({}).fetch()
  remotes: ->
    return Remotes.find({}).fetch()
  jobs: ->
    return Jobs.find({}).fetch()


Template.config.events
  "click .removeRemote": (event, template)->
    id = event.currentTarget.id
    Remotes.remove({_id: id})

  "click #repos .monitor": () ->
    that = this
    Repos.update that._id, {$set: {monitor: !that.monitor}}
  
  "click #jobs .monitor": ->
    Jobs.update this._id, {$set: {monitor: !this.monitor}}
  
  "click #jobsReload": ->
    Meteor.call('getJobs')
