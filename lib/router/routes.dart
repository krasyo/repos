import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repos_github/bloc/commit/commit.dart';
import 'package:repos_github/bloc/repo/repo.dart';
import 'package:repos_github/bloc/user/user.dart';
import 'package:repos_github/router/settings_arguments.dart';
import 'package:repos_github/screens/commits_screen/commits_screen.dart';
import 'package:repos_github/screens/home_screen.dart';
import 'package:repos_github/screens/repos_screen/repos_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {
      case '/': return MaterialPageRoute(builder: (context) => HomeScreen());
      case '/repos': {
        final args = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<UserBloc>(
                create: (context) => UserBloc()..add(LoadUser(username: args))
              ),
              BlocProvider<RepoBloc>(
                create: (context) => RepoBloc()..add(LoadRepos(username: args)),
              )
            ],
            child: ReposScreen(username: args)
          )
        );
      }
      case '/commits': {
        final args = settings.arguments as SettingsArguments;
        return MaterialPageRoute(
          builder: (context) => BlocProvider<CommitBloc>(
            create: (context) => CommitBloc()..add(
              LoadCommits(username: args.username, repoName: args.repoName)
            ),
            child: CommitsScreen(username: args.username, repoName: args.repoName),
          )
        );
      }
    }

    return throw "not found screen";
  }
}