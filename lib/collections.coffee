@PullRequests = new Mongo.Collection('pullRequests')
PullRequests.findError = ->
  PullRequests.find({createdDate: {$lte: moment().subtract(5, 'days').unix()*1000}}).fetch()

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
    regEx: SimpleSchema.RegEx.Url
    index: true
    unique: true
  refreshRate:
    type: Number
  type:
    type: String
    allowedValues: ['STASH']
    index: true
    unique: true

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