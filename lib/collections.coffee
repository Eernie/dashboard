@PullRequests = new Mongo.Collection('pullRequests')
PullRequests.findError = ->
  PullRequests.find({createdDate: {$lte: moment().subtract(1, 'days').unix()*1000}}).fetch()

@Remotes = new Mongo.Collection('remotes')
@Remotes.attachSchema new SimpleSchema
  username:
    type: String
  password:
    type: String
  type:
    type: String
    allowedValues: ['STASH']
    index: true
    unique: true
