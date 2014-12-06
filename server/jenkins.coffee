class @Jenkins
  @tick: ->
    remote = Remotes.findOne(type: "JENKINS")
    if(remote == null || remote == undefined )
      console.log "There is no user for Jenkins configured"
      return
    if remote.lastChecked != null && remote.lastChecked != undefined
      remote.lastChecked.setSeconds(remote.lastChecked.getSeconds() + remote.refreshRateInSeconds)
      return if remote.lastChecked > new Date()

    Meteor.call('getJobs') if Jobs.find({}).fetch().length == 0
    return if Jobs.find({}).length == 0

    for job in Jobs.find({monitor:true}).fetch()
      build = Jenkins.httpGet(job.url+"lastBuild/api/json",remote)
      build._id = job.name
      switch build.result
        when "SUCCESS"
          build.order = 3
          build.style = "success"
        when "UNSTABLE"
          build.order = 2
          build.style = "warning"
        when "FAILURE"
          build.order = 1
          build.style = "danger"
      build.percentage = (build.duration / build.estimatedDuration) *100
      Builds.update(job.name, build, {upsert:true})


  @httpGet: (url,remote)->
    auth = remote.username + ":" + remote.password
    body = Meteor.http.get url, auth:auth
    return JSON.parse(body.content)

Meteor.methods
  getJobs: ->
    remote = Remotes.findOne(type: "JENKINS")
    if(remote == null || remote == undefined )
      console.log "There is no user for Jenkins configured"
      return
    url = remote.url + "/api/json"

    content = Jenkins.httpGet(url,remote)

    Jobs.remove({})
    for job in content.jobs
      Jobs.insert
        _id: job.name
        name: job.name
        url: job.url
        monitor: false

Meteor.setInterval Jenkins.tick, 1000
