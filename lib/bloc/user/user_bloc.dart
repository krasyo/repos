import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repos_github/api/api_user.dart';
import 'package:repos_github/bloc/user/user.dart';
import 'package:repos_github/models/user.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  @override
  UserState get initialState => UserInitial();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if(event is LoadUser)
      try {
        final User user = await apiUser.getUser(event.username);
        yield UserLoaded(user: user);
      } catch(_) {
        yield UserLoadedFailure();
      }
  }
}