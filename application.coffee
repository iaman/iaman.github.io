window.Github = {};

class Github.Repo extends Backbone.Model

class Github.User extends Backbone.Model

class Github.RepoList extends Backbone.Collection
  model: Github.Repo
  url: "https://api.github.com/users/#{window.userId}/repos?sort=updated"

class Github.RepoListView extends Backbone.View
