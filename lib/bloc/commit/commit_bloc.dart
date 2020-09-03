import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repos_github/api/api_repos.dart';
import 'package:repos_github/bloc/commit/commit.dart';
import 'package:repos_github/models/commit.dart';

class CommitBloc extends Bloc<CommitEvent, CommitState> {

  @override
  CommitState get initialState => CommitsLoading();

  @override
  Stream<CommitState> mapEventToState(CommitEvent event) async* {
    if(event is LoadCommits) {
      try {
        yield await _mapCommitsToState(state, event);
      } catch (error) {
        yield CommitsLoadedFailure(error: error);
      }
    }
  }

  Future<CommitState> _mapCommitsToState(CommitState state, LoadCommits event) async {
    if(state is CommitsLoaded && state.hasReached) return state;

    final List<Commit> commits = await apiRepos.getCommits(username: event.username, repoName: event.repoName, pageNumber: event.pageNumber);
    if(state is CommitsLoaded && !state.hasReached)
      return commits.isEmpty
        ? state.copyWith(hasReached: true)
        : state.copyWith(commits: List.of(state.commits)..addAll(commits), hasReached: false);

    return CommitsLoaded(commits: commits, hasReached: commits.length != 20);
  }
}