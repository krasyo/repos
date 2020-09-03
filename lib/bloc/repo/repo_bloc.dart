import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repos_github/api/api_repos.dart';
import 'package:repos_github/api/models/error.dart';
import 'package:repos_github/bloc/repo/repo.dart';
import 'package:repos_github/models/repo.dart';

class RepoBloc extends Bloc<RepoEvent, RepoState> {

  @override
  RepoState get initialState => ReposLoading();

  @override
  Stream<RepoState> mapEventToState(RepoEvent event) async* {
    if(event is LoadRepos) {
      try {
        yield await _mapReposToState(state, event);
      } catch (error) {
        yield ReposLoadedFailure(error: error is SocketException ? Error(code: 503) : error);
      }
    }
  }

  Future<RepoState> _mapReposToState(RepoState state, LoadRepos event) async {
    if(state is ReposLoaded && state.hasReached) return state;

    final List<Repo> repos = await apiRepos.getRepos(username: event.username, pageNumber: event.pageNumber);
    if(state is ReposLoaded && !state.hasReached)
      return repos.isEmpty
        ? state.copyWith(hasReached: true)
        : state.copyWith(repos: List.of(state.repos)..addAll(repos), hasReached: false);

    return ReposLoaded(repos: repos, hasReached: repos.length != 20);
  }
}