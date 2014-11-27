Router.map ->
  @route "dashboard",
    onBeforeAction: ->
      @pullRequest = Meteor.subscribe "pullrequests"
      @next()
  @route "config",
    onBeforeAction: ->
      @repos = Meteor.subscribe "repositories"
      @remote = Meteor.subscribe "remotes"
      @next()
  @route "home",
    path: "/"
    action: ->
      Router.go("dashboard")

  return
