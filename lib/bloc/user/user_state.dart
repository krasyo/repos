import 'package:equatable/equatable.dart';
import 'package:repos_github/models/user.dart';
import 'package:flutter/material.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoaded extends UserState {
  final User user;

  const UserLoaded({ @required this.user });

  @override
  List<Object> get props => [user];
}

class UserLoadedFailure extends UserState {}