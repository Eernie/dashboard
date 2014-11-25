Router.map ->
  @route "dashboard",
    onBeforeAction: ->
      @pullRequests = Meteor.subscribe "pullrequests"
      @next()

    data: ->
      PullRequests.findError()
    action: ->
      @render()
  @route "home",
    path: "/"
    action: ->
      Router.go("dashboard")

  return
