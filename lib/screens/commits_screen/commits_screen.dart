import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repos_github/bloc/commit/commit.dart';
import 'package:repos_github/screens/commits_screen/commit_item.dart';
import 'package:repos_github/widgets/custom_appbar.dart';
import 'package:repos_github/widgets/loading_indicator.dart';

class CommitsScreen extends StatefulWidget {
  final String username;
  final String repoName;

  const CommitsScreen({
    Key key,
    @required this.username,
    @required this.repoName
  }) : super(key: key);

  @override
  _CommitsScreenState createState() => _CommitsScreenState();
}

class _CommitsScreenState extends State<CommitsScreen> {
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
      child: BlocBuilder<CommitBloc, CommitState>(
          builder: (context, state) {
            if(state is CommitsLoaded) {
              return Scaffold(
                appBar: CustomAppbar(titleString: 'Список коммитов'),
                body: Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 15.0),
                        child: Text(widget.repoName),
                      ),
                    ),
                    Expanded(
                        child: ListView.separated(
                            controller: _scrollController,
                            itemBuilder: (context, index) {
                              return index >= state.commits.length
                                  ? LoadingIndicator()
                                  : CommitItem(model: state.commits[index]);
                            },
                            separatorBuilder: (context, index) {
                              return Divider();
                            },
                            itemCount: state.hasReached
                                ? state.commits.length
                                : state.commits.length + 1
                        )
                    )
                  ],
                ),
              );
            }

            if(state is CommitsLoading)
              return Scaffold(
                body: LoadingIndicator(),
              );

            if(state is CommitsLoadedFailure) {
              String titleError;
              if(state.error.code == 403)
                titleError = 'Превышен лимит запросов, попробуйте позже';
              else
                titleError = 'Не удается подключиться к коммитам, либо этот репозиторий пуст';
              return Scaffold(
                appBar: CustomAppbar(),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Align(
                        child: Text(titleError, textAlign: TextAlign.center),
                      ),
                    ),
                    FlatButton(
                        onPressed: () =>
                            BlocProvider.of<CommitBloc>(context).add(LoadCommits(username: widget.username, repoName: widget.repoName)) ,
                        child: Text('Попробовать ещё раз')
                    )
                  ],
                ),
              );
            }

            return Container();
          }
      )
    );
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
      BlocProvider.of<CommitBloc>(context).add(
          LoadCommits(username: widget.username, repoName: widget.repoName, pageNumber: ++_pageNumber == 1 ? ++_pageNumber : _pageNumber)
      );
  }
}
