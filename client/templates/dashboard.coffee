
Template.dashboard.helpers {
  pullRequestsReady: ->
    return Router.current().pullRequest.ready()
  pullRequests: ->
    return PullRequests.findError()
}