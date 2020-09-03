import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repos_github/bloc/user/user.dart';
import 'package:repos_github/bloc/user/user_state.dart';

class UserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if(state is UserLoaded)
          return Column(
            children: [
              Center(
                child: Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(state.user.user.avatar),
                          fit: BoxFit.fill
                      )
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 15.0),
                child: Text(state.user.user.username, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
              )
            ],
          );

        return Container();
      }
    );
  }
}
