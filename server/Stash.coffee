class Stash
  tick = ->
    remote = Remotes.findOne( type: "STASH")
    if(remote == null || remote == undefined )
      console.log "There is no user for Stash configured"
      return

    repos = Repos.find({}).fetch();
    if(repos.length == 0)
      fetchRepos()
      repos = Repos.find({}).fetch();
      if(repos.length == 0)
        return
    getPullRequests()

  getPullRequests = ->
    remote = Remotes.findOne( type: "STASH")
    repos = Repos.find(monitor: true).fetch()
    if(repos.length = 0)
      console.log "There are no repos that should be monitored"

    values = []
    for repo in repos
      values.concat getPullRequestsForRepo(remote,repo)

    PullRequests.remove({})
    for value in values
      value._id = value.id.toString()
      PullRequests.insert(value)

  getPullRequestsForRepo = (remote,repo) ->
    size = 25
    notDone = true
    loops = 0
    values = []
    content = null
    while(notDone)
      url = remote.url + "/projects/" + repo.project + "/repos/"+ repo.slug +"/pull-requests?state=OPEN&order=OLDEST&limit="+size
      if(content != null && loops>0)
        url = url + "&start=" + content.nextPageStart

      auth = remote.username + ":" + remote.password
      prs = Meteor.http.get url, {auth: auth, timeout: 5000}
      content = JSON.parse(prs.content)

      values = values.concat(content.values)
      notDone = !content.isLastPage
      loops++
    return values

  fetchRepos = ->
    remote = Remotes.findOne( type: "STASH")
    url = remote.url + "/projects"
    auth = remote.username + ":" + remote.password

    request = Meteor.http.get url, auth: auth
    body = request.content
    projects = body.values

    repoObjects = []
    for project in projects
      url = remote.url + "/projects/" + project.key.toLowerCase() + "/repos"

      request = Meteor.http.get url, auth: auth
      body = request.content
      repos = body.values
      for repo in repos
        repoObjects.push
          _id: project.key + "|" + repo.name
          slug: repo.slug
          name: repo.name
          project: project.key

    Repos.insert repoObjects
