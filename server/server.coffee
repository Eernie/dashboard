Meteor.publish "pullrequests", ->
  PullRequests.find({})

Meteor.publish "repositories", ->
  Repos.find({})

Meteor.publish "remotes", ->
  Remotes.find({})