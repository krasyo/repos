class Commit {
  _Commit _commit;

  Commit.fromJson(Map<String, dynamic> json) {
    _commit = _Commit(json);
  }

  _Commit get commit => _commit;
}

class _Commit {
  String _message;
  String _date;
  String _hash;
  String _author;
  String _authorAvatar;

  _Commit(commit) {
    _message = commit['commit']['message'];
    _date = commit['commit']['author']['date'];
    _hash = commit['sha'];
    _author = commit['author'] != null ? commit['author']['login'] : commit['commit']['author']['name'];
    _authorAvatar = commit['author'] != null ? commit['author']['avatar_url'] : null;
  }

  String get message => _message;

  String get date => _date;

  String get hash => _hash;

  String get author => _author;

  String get authorAvatar => _authorAvatar;
}