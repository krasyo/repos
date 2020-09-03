import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class CommitEvent extends Equatable {
  const CommitEvent();

  @override
  List<Object> get props => [];
}

class LoadCommits extends CommitEvent {
  final String username;
  final String repoName;
  final int pageNumber;

  const LoadCommits({ @required this.username, @required this.repoName, this.pageNumber = 0 });

  @override
  List<Object> get props => [username, repoName, pageNumber];
}