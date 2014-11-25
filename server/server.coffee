getPullRequests = ->
  remote = Remotes.findOne( type: "STASH")
  if(remote == null || remote == undefined )
    console.log "There is no user for Stash configured"
    return
  size = 25
  notDone = true
  loops = 0
  values = []
  content = null
  while(notDone)
    url = "https://stash.topicus.nl/rest/api/1.0/projects/fin/repos/retailbanking/pull-requests?state=OPEN&order=OLDEST&limit="+size
    if(content != null && loops>0)
      url = url + "&start=" + content.nextPageStart

    auth = remote.username + ":" + remote.password
    console.log auth
    prs = Meteor.http.call "GET", url, {auth: auth}
    content = JSON.parse(prs.content)

    values = values.concat(content.values)
    notDone = !content.isLastPage
    loops++

  PullRequests.remove({})
  for value in values
    value._id = value.id.toString()
    PullRequests.insert(value)

Meteor.startup ->
  Meteor.setInterval(getPullRequests, 10000)
  getPullRequests()

  Meteor.publish "pullrequests", ->
    PullRequests.find({})

  Meteor.publish "remotes", ->
    Remotes.find({})
