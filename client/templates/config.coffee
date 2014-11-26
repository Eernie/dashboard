Template.config.helpers


Template.config.events
  "click .removeRemote": (event, template)->
    id = event.currentTarget.id
    Remotes.remove({_id: id})
