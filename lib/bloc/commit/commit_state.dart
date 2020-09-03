import 'package:equatable/equatable.dart';
import 'package:repos_github/api/models/error.dart';
import 'package:repos_github/models/commit.dart';

abstract class CommitState extends Equatable {
  const CommitState();

  @override
  List<Object> get props => [];
}

class CommitsLoading extends CommitState {}

class CommitsLoaded extends CommitState {
  final List<Commit> commits;
  final bool hasReached;

  const CommitsLoaded({ this.commits = const <Commit>[], this.hasReached = false });

  CommitsLoaded copyWith({ List<Commit> commits, bool hasReached }) {
    return CommitsLoaded(
        commits: commits ?? this.commits,
        hasReached: hasReached ?? this.hasReached
    );
  }

  @override
  List<Object> get props => [commits, hasReached];
}

class CommitsLoadedFailure extends CommitState {
  final Error error;

  const CommitsLoadedFailure({ this.error });

  @override
  List<Object> get props => [error];
}