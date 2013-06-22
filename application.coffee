window.Github = {};

Mustaches =
  repoList: '''<ul>
      {{# models }}
        <li class="repo{{# isFork }} repo_forked{{/ isFork }}" id="{{ repoId }}"><a href="{{ repoLink }}">{{ repoName }}</a>{{# repoDescription }} : {{ repoDescription }}{{/ repoDescription }}</li>
      {{/ models }}
    </ul>'''

class Github.Repo extends Backbone.Model
  initialize: ->
    @repoId = "repo_#{@get("name")}"
    @repoName = @get("name")
    @repoDescription = @get("description")
    @repoLink = @get("html_url")
    @isFork = @get("fork")

class Github.User extends Backbone.Model

class Github.RepoList extends Backbone.Collection
  model: Github.Repo
  url: "https://api.github.com/users/#{window.userId}/repos?sort=updated"

class Github.RepoListView extends Backbone.View
  template: Mustaches["repoList"]

  initialize: ->
    @$el ?= $(@el)

  render: ->
    @$el.html(Mustache.to_html(@template, @collection))

$ ->
  window.GithubRepos = new Github.RepoList
  GithubRepos.fetch
    success: ->
      window.GithubReposView = new Github.RepoListView collection: GithubRepos, el: "#repos"
      GithubReposView.render()