class @Jenkins 
  @tick: ->
    remote = Remotes.findOne(type: "JENKINS")
    if(remote == null || remote == undefined )
      console.log "There is no user for Jenkins configured"
      return
    if remote.lastChecked != null && remote.lastChecked != undefined
      remote.lastChecked.setSeconds(remote.lastChecked.getSeconds() + remote.refreshRateInSeconds)
      return if remote.lastChecked > new Date()
    
    jobs = Jobs.find({}).fetch()
    Meteor.call('getJobs') if Jobs.find({}).fetch().length == 0
    return if Jobs.find({}).length == 0
    
    
    
Meteor.setInterval Jenkins.tick, 1000

Meteor.methods
  getJobs: ->
    remote = Remotes.findOne(type: "JENKINS")
    if(remote == null || remote == undefined )
      console.log "There is no user for Jenkins configured"
      return
    url = remote.url + "/json"
    
    auth = remote.username + ":" + remote.password
    body = Meteor.http.get url
    content = JSON.parse(body.content)
    
    Jobs.remove({})
    for job in content.jobs
      Jobs.insert
        name: job.name
        monitor: false
    