
Template.dashboard.helpers {
  pullRequestsReady: ->
    return Router.current().pullRequests.ready()
}