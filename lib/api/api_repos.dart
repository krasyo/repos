import 'package:repos_github/api/api_base.dart';
import 'package:repos_github/models/commit.dart';
import 'package:repos_github/models/repo.dart';

class ApiRepos extends ApiBase {
  static final ApiRepos _instance = ApiRepos._internal();

  factory ApiRepos() {
    return _instance;
  }

  ApiRepos._internal();

  Future<List<Repo>> getRepos({ String username, pageNumber = 0 }) async {
    final path = 'users/$username/repos?page=$pageNumber&per_page=20';
    final List<Repo> repos = [];
    final response = await request(TypeRequest.get, path) as List;
    for(Map r in response)
      repos.add(Repo.fromJson(r));
    return repos;
  }

  Future<List<Commit>> getCommits({ String username, String repoName, pageNumber = 0 }) async {
    final path = 'repos/$username/$repoName/commits?page=$pageNumber&per_page=20';
    final List<Commit> commits = [];
    final response = await request(TypeRequest.get, path) as List;
    for(Map r in response)
      commits.add(Commit.fromJson(r));
    return commits;
  }
}

final apiRepos = ApiRepos();