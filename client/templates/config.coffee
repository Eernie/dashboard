Template.config.helpers
  repositories: ->
    return Repos.find({}).fetch()
  remotes: ->
    return Remotes.find({}).fetch()


Template.config.events
  "click .removeRemote": (event, template)->
    id = event.currentTarget.id
    Remotes.remove({_id: id})

  "click .monitor": () ->
    that = this
    Repos.update that._id, {$set: {monitor: !that.monitor}}
