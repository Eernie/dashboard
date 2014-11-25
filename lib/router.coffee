Router.map ->
  @route "dashboard",
    onBeforeAction: ->
      @pullRequests = Meteor.subscribe "pullrequests"
      @next()

    data: ->
      PullRequests.findError()
    action: ->
      @render()
  @route "config",
    onBeforeAction: ->
      @config = Meteor.subscribe "remotes"
      @next()
    data: ->
      Remotes.find({}).fetch()
  @route "home",
    path: "/"
    action: ->
      Router.go("dashboard")

  return
