stash = Stash()
Meteor.setInterval(stash.tick, 10000)
stash.tick()

Meteor.publish "pullrequests", ->
  PullRequests.find({})

Meteor.publish "remotes", ->
  Remotes.find({})
