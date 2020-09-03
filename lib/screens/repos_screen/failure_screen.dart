import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repos_github/bloc/repo/repo.dart';

class FailureScreen extends StatelessWidget {
  final String username;
  final ReposLoadedFailure state;
  final BuildContext context;

  const FailureScreen({
    Key key,
    @required this.username,
    @required this.state,
    @required this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Align(
            child: Text(title, textAlign: TextAlign.center),
          ),
        ),
        button
      ],
    );
  }

  String get title {
    switch (state.error.code) {
      case 404: return 'Упс, кажется $username не зарегистрирован на Github';
      case 403: return 'Превышен лимит запросов, попробуйте позже';
      default: return 'Не удается подключиться к репозиториям';
    }
  }

  FlatButton get button => state.error.code == 404
      ? FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Вернуться назад')
        )
      : FlatButton(
            onPressed: () => BlocProvider.of<RepoBloc>(context).add(LoadRepos(username: username)) ,
            child: Text('Попробовать ещё раз')
        );
}
