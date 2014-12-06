Router.map ->
  @route "dashboard",
    onBeforeAction: ->
      @pullRequest = Meteor.subscribe "pullrequests"
      @build = Meteor.subscribe "builds"
      @next()
  @route "config",
    onBeforeAction: ->
      @repos = Meteor.subscribe "repositories"
      @remote = Meteor.subscribe "remotes"
      @job = Meteor.subscribe "jobs"
      @next()
  @route "home",
    path: "/"
    action: ->
      Router.go("dashboard")

  return
