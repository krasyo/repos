import 'package:repos_github/models/user.dart';

import 'api_base.dart';

class ApiUser extends ApiBase {
  static final ApiUser _instance = ApiUser._internal();

  factory ApiUser() {
    return _instance;
  }

  ApiUser._internal();

  Future<User> getUser(String username) async {
    final path = 'users/$username';
    final response = await request(TypeRequest.get, path) as Map;
    return User.fromJson(response);
  }
}

final apiUser = ApiUser();