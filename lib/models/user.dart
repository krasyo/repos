class User {
  _User _user;

  User.fromJson(Map<String, dynamic> json) {
    _user = _User(json);
  }

  _User get user => _user;
}

class _User {
  String _username;
  String _avatar;

  _User(user) {
    _username = user['login'];
    _avatar = user['avatar_url'];
  }

  String get username => _username;

  String get avatar => _avatar;
}