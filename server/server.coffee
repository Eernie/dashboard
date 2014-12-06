Meteor.publish "pullrequests", ->
  PullRequests.find({})

Meteor.publish "repositories", ->
  Repos.find({})

Meteor.publish "remotes", ->
  Remotes.find({})

Meteor.publish "jobs", ->
  Jobs.find({})

Meteor.publish "builds", ->
  Builds.find({})
