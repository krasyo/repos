import 'package:equatable/equatable.dart';
import 'package:repos_github/api/models/error.dart';
import 'package:repos_github/models/repo.dart';

abstract class RepoState extends Equatable {
  const RepoState();

  @override
  List<Object> get props => [];
}

class ReposLoading extends RepoState {}

class ReposLoaded extends RepoState {
  final List<Repo> repos;
  final bool hasReached;

  const ReposLoaded({ this.repos = const <Repo>[], this.hasReached = false });

  ReposLoaded copyWith({ List<Repo> repos, bool hasReached }) {
    return ReposLoaded(
      repos: repos ?? this.repos,
      hasReached: hasReached ?? this.hasReached
    );
  }

  @override
  List<Object> get props => [repos, hasReached];
}

class ReposLoadedFailure extends RepoState {
  final Error error;

  const ReposLoadedFailure({ this.error });

  @override
  List<Object> get props => [error];
}