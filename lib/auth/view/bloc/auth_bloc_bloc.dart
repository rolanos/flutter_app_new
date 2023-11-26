import 'package:bloc/bloc.dart';
import 'package:flutter_app_new/auth/data/repository/auth_repository_impl.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';
part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final AuthRepositoryImpl _repository = AuthRepositoryImpl();

  AuthBlocBloc() : super(AuthBlocInitial()) {
    on<GetAuthEvent>((event, emit) async {
      emit(LoadingAuthState());
      try {
        final response =
            await _repository.onGetAuthEvent(event.username, event.email);
        if (response.statusCode == 200) {
          final responseBody = response.body;
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.setString("username", event.username);
          await preferences.setString("email", event.email);
          emit(LoadedAuthState(
            username: event.username,
            email: event.email,
          ));
          logger.d(responseBody);
        } else {
          emit(FailureLoginState());
        }
      } catch (_) {
        emit(FailureLoginState());
      }
    });
  }
}
