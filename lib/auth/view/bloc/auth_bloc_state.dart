part of 'auth_bloc_bloc.dart';

@immutable
abstract class AuthBlocState {}

class AuthBlocInitial extends AuthBlocState {}

class LoadingAuthState extends AuthBlocState {}

class LoadedAuthState extends AuthBlocState {
  final String username;
  final String email;
  LoadedAuthState({required this.username, required this.email});
}

class FailureLoginState extends AuthBlocState {}
