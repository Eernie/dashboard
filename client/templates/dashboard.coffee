
Template.dashboard.helpers {
  pullRequestsReady: ->
    return Router.current().pullRequest.ready()
  pullRequests: ->
    return PullRequests.findError()
  buildsReady: ->
    return Router.current().build.ready()
  builds: ->
    return Builds.find({}, {sort: {order: 1, _id: 1}}).fetch()
}
