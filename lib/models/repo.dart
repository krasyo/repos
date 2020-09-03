class Repo {
  _Repo _repo;

  Repo.fromJson(Map<String, dynamic> json) {
    _repo = _Repo(json);
  }

  _Repo get repo => _repo;
}

class _Repo {
  String _name;
  String _description;
  int _amountStars;
  int _amountForks;
  String _author;
  String _authorAvatar;

  _Repo(repo) {
    _name = repo['name'];
    _description = repo['description'];
    _amountStars = repo['stargazers_count'];
    _amountForks = repo['forks_count'];
    _author = repo['owner']['login'];
    _authorAvatar = repo['owner']['avatar_url'];
  }

  String get name => _name;

  String get description => _description;

  int get amountStars => _amountStars;

  int get amountForks => _amountForks;

  String get author => _author;

  String get authorAvatar => _authorAvatar;
}