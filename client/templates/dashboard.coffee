
Template.dashboard.helpers {
  pullRequestsReady: ->
    return Router.current().pullRequest.ready()
  pullRequests: ->
    return PullRequests.findError()
  buildsReady: ->
    return Router.current().job.ready()
  builds: ->
    return Jobs.findError()
  overallStatus: ->
    amountFailedJobs = Jobs.findError().length
    amountPullRequests = PullRequests.findError().length
    if(amountFailedJobs > 0 || amountPullRequests > 4)
      return "danger"
    else if(amountPullRequests >= 2)
      return "warning"
    else
      return "success"
}
