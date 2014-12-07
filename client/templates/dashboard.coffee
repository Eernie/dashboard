
Template.dashboard.helpers {
  pullRequestsReady: ->
    return Router.current().pullRequest.ready()
  pullRequests: ->
    return PullRequests.findError()
  buildsReady: ->
    return Router.current().job.ready()
  builds: ->
    return Jobs.find({monitor:true}, {sort: {order: 1, _id: 1}}).fetch()
}
