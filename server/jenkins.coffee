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

    Remotes.update(remote._id, {$set: {lastChecked: new Date()}})
    for job in Jobs.find({monitor:true}).fetch()
      build = Jenkins.httpGet(job.url+"/lastBuild/api/json",remote)
      if !build.building
        switch build.result
          when "SUCCESS"
            order = 3
            style = "success"
          when "UNSTABLE"
            order = 2
            style = "warning"
          when "FAILURE"
            order = 1
            style = "danger"
      duration = Date.now() - build.timestamp
      percentage = if build.building then parseInt((duration / build.estimatedDuration) * 100) else 100
      Jobs.update(job._id, {$set:{order: order, style: style, percentage: percentage}})

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
        url: remote.url + "/job/" + job.name
        monitor: false

Meteor.setInterval Jenkins.tick, 1000
