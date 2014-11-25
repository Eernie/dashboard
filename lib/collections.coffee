@PullRequests = new Mongo.Collection('pullRequests')
PullRequests.findError = ->
  PullRequests.find({createdDate: {$lte: moment().subtract(4, 'days').unix()*1000}}).fetch()