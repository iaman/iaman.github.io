// Generated by CoffeeScript 1.3.3
(function() {
  var Mustaches,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.Github = {};

  Mustaches = {
    repoList: '{{# models }}\n{{# shouldOpenClear }}<section>{{/ shouldOpenClear }}\n  <div class="repo grid-1" id="{{ repoId }}"><div class="card{{# isFork }} red {{/ isFork }}"><hgroup><h3>{{ repoName }}</h3></hgroup>{{# isFork }}<section class="slice"><div class="alerts-error"><div class="alert">This repo is a fork</div></div></section>{{/ isFork}}<div class="card-contents">{{# repoDescription }}<div class="repo-deets">{{ repoDescription }}</div>{{/ repoDescription }}<a href="{{ repoLink }}" class="button grid-4">Peep this</a></div></div></div>\n{{# shouldCloseClear }}</section>{{/ shouldCloseClear }}\n{{/ models }}'
  };

  Github.Repo = (function(_super) {

    __extends(Repo, _super);

    function Repo() {
      return Repo.__super__.constructor.apply(this, arguments);
    }

    Repo.prototype.initialize = function() {
      this.repoId = "repo_" + (this.get("name"));
      this.repoName = this.get("name");
      this.repoDescription = this.get("description");
      this.repoLink = this.get("html_url");
      return this.isFork = this.get("fork");
    };

    Repo.prototype.shouldCloseClear = function() {
      return (this.collection.models.indexOf(this) + 1) % 4 === 0;
    };

    Repo.prototype.shouldOpenClear = function() {
      return this.collection.models.indexOf(this) % 4 === 0;
    };

    return Repo;

  })(Backbone.Model);

  Github.User = (function(_super) {

    __extends(User, _super);

    function User() {
      return User.__super__.constructor.apply(this, arguments);
    }

    return User;

  })(Backbone.Model);

  Github.RepoList = (function(_super) {

    __extends(RepoList, _super);

    function RepoList() {
      return RepoList.__super__.constructor.apply(this, arguments);
    }

    RepoList.prototype.model = Github.Repo;

    RepoList.prototype.url = "https://api.github.com/users/" + window.userId + "/repos?sort=updated";

    return RepoList;

  })(Backbone.Collection);

  Github.RepoListView = (function(_super) {

    __extends(RepoListView, _super);

    function RepoListView() {
      return RepoListView.__super__.constructor.apply(this, arguments);
    }

    RepoListView.prototype.template = Mustaches["repoList"];

    RepoListView.prototype.initialize = function() {
      var _ref;
      return (_ref = this.$el) != null ? _ref : this.$el = $(this.el);
    };

    RepoListView.prototype.render = function() {
      return this.$el.html(Mustache.to_html(this.template, this.collection));
    };

    return RepoListView;

  })(Backbone.View);

  $(function() {
    window.GithubRepos = new Github.RepoList;
    return GithubRepos.fetch({
      success: function() {
        window.GithubReposView = new Github.RepoListView({
          collection: GithubRepos,
          el: "#repos"
        });
        return GithubReposView.render();
      }
    });
  });

}).call(this);
