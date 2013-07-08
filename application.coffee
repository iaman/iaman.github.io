window.Github = {};

Mustaches =
  repoList: '''
      {{# models }}
      {{# shouldOpenClear }}<section>{{/ shouldOpenClear }}
        <div class="repo grid-1" id="{{ repoId }}"><div class="card{{# isFork }} red {{/ isFork }}"><hgroup><h3>{{ repoName }}</h3></hgroup>{{# isFork }}<section class="slice"><div class="alerts-error"><div class="alert">This repo is a fork</div></div></section>{{/ isFork}}<div class="card-contents">{{# repoDescription }}<div class="repo-deets">{{ repoDescription }}</div>{{/ repoDescription }}<a href="{{ repoLink }}" class="button grid-4">Peep this</a><a href="{{ forkLink }}" class="button green grid-4">Fork this</a></div></div></div>
      {{# shouldCloseClear }}</section>{{/ shouldCloseClear }}
      {{/ models }}
    '''

class Github.Repo extends Backbone.Model
  initialize: ->
    @repoId = "repo_#{@get("name")}"
    @repoName = @get("name")
    @repoDescription = @get("description")
    @repoLink = @get("html_url")
    @forkLink = @get("forks_url")
    @isFork = @get("fork")

  shouldCloseClear: ->
    (@collection.models.indexOf(this) + 1) % 4 is 0

  shouldOpenClear: ->
    @collection.models.indexOf(this) % 4 is 0

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