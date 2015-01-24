@PullRequests = new Mongo.Collection('pullRequests')
PullRequests.findError = ->
  PullRequests.find({open: true,createdDate: {$lte: moment().subtract(5, 'days').unix()*1000}}).fetch()

@Remotes = new Mongo.Collection('remotes')
@Remotes.attachSchema new SimpleSchema
  username:
    type: String
  password:
    type: String
    autoform:
      type: "password"

  url:
    type: String,
    index: true
    unique: true
  refreshRateInSeconds:
    type: Number
  type:
    type: String
    allowedValues: ['STASH','JENKINS']
    index: true
    unique: true
  lastChecked:
    type: Date
    optional: true
    autoform:
      type: "hidden"

@Repos = new Mongo.Collection('repositories')
@Repos.attachSchema new SimpleSchema
  _id:
    type: String
  name:
    type: String
  slug:
    type: String
  project:
    type: String
  monitor:
    type: Boolean

@Jobs = new Mongo.Collection('jobs')
@Jobs.findError = ->
  return Jobs.find({monitor:true, order:1}, {sort: {order: 1, _id: 1}}).fetch()
@Jobs.attachSchema new SimpleSchema
  name:
    type: String
  url:
    type: String
  monitor:
    type: Boolean
  order:
    type: Number
    optional: true
  style:
    type: String
    optional: true
  percentage:
    type: Number
    optional: true
