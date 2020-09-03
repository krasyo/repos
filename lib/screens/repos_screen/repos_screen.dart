import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repos_github/bloc/repo/repo.dart';
import 'package:repos_github/router/settings_arguments.dart';
import 'package:repos_github/screens/repos_screen/failure_screen.dart';
import 'package:repos_github/screens/repos_screen/user_info.dart';
import 'package:repos_github/widgets/custom_appbar.dart';
import 'package:repos_github/widgets/loading_indicator.dart';

class ReposScreen extends StatefulWidget {
  final String username;

  const ReposScreen({Key key, @required this.username}) : super(key: key);

  @override
  _ReposScreenState createState() => _ReposScreenState();
}

class _ReposScreenState extends State<ReposScreen> {
  int _pageNumber = 0;
  final _scrollController = ScrollController(initialScrollOffset: 0.0);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<RepoBloc, RepoState>(
          builder: (context, state) {
            if(state is ReposLoaded) {
              return Scaffold(
                appBar: CustomAppbar(titleString: 'Список репозиториев'),
                body: Column(
                  children: [
                    UserInfo(),
                    Expanded(
                        child: ListView.separated(
                            controller: _scrollController,
                            itemBuilder: (context, index) {
                              return index >= state.repos.length
                                ? LoadingIndicator()
                                : Column(
                                    children: [
                                      ListTile(
                                        title: Text(state.repos[index].repo.name),
                                        subtitle: state.repos[index].repo.description != null ? Text(state.repos[index].repo.description) : null,
                                        onTap: () => Navigator.pushNamed(
                                            context, '/commits',
                                            arguments: SettingsArguments(username: widget.username, repoName: state.repos[index].repo.name)
                                        ),
                                      ),
                                      _icons(state.repos[index].repo.amountStars, state.repos[index].repo.amountForks)
                                    ],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider();
                            },
                            itemCount: state.hasReached
                                ? state.repos.length
                                : state.repos.length + 1
                        )
                    )
                  ],
                ),
              );
            }

            if(state is ReposLoading)
              return Scaffold(
                body: LoadingIndicator(),
              );

            if(state is ReposLoadedFailure) {
              return Scaffold(
                appBar: CustomAppbar(),
                body: FailureScreen(username: widget.username, state: state, context: context),
              );
            }

            return Container();
          }
      )
    );
  }

  Widget _icons(amountStars, amountForks) {
    List<Widget> rowWidgets = [
      Padding(padding: EdgeInsets.only(left: 12.0))
    ];

    if(amountStars == 0 && amountForks == 0)
      return Container();

    if(amountStars != 0)
       rowWidgets.addAll([
           Icon(Icons.star_border, color: Theme.of(context).primaryColor),
           Text(amountStars.toString()),
           Padding(padding: EdgeInsets.only(right: 15.0)),
       ]);

    if(amountForks != 0)
      rowWidgets.addAll([
        Icon(Icons.share, color: Colors.grey),
        Text(amountForks.toString())
      ]);

    return Row(children: rowWidgets);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if(currentScroll >= maxScroll)
      BlocProvider.of<RepoBloc>(context).add(
        LoadRepos(username: widget.username, pageNumber: ++_pageNumber == 1 ? ++_pageNumber : _pageNumber)
      );
  }
}
