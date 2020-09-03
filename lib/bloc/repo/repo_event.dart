import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class RepoEvent extends Equatable {
  const RepoEvent();

  @override
  List<Object> get props => [];
}

class LoadRepos extends RepoEvent {
  final String username;
  final int pageNumber;

  const LoadRepos({ @required this.username, this.pageNumber = 0 });

  @override
  List<Object> get props => [username, pageNumber];
}