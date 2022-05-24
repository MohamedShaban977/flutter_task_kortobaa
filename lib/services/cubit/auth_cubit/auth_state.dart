part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}


class PassVisibilityState extends AuthState{}
class PassConfirmVisibilityState extends AuthState{}

class LoginLoadingState extends AuthState {}
class LoginSuccessState extends AuthState {
  final UserModel response;

  LoginSuccessState(this.response);
}
class LoginErrorState extends AuthState {
   final String? error;
  LoginErrorState(this.error);
}

class RegisterLoadingState extends AuthState {}
class RegisterSuccessState extends AuthState {}
class RegisterErrorState extends AuthState {
  final String? error;
  RegisterErrorState(this.error);
}

class CreateUserLoadingState extends AuthState {}
class CreateUserSuccessState extends AuthState {
  final UserModel response;
  CreateUserSuccessState(this.response);
}
class CreateUserErrorState extends AuthState {
  final String? error;
  CreateUserErrorState(this.error);
}


class LogoutLoadingState extends AuthState {}
class LogoutSuccessState extends AuthState {}
class  LogoutErrorState extends AuthState {
  final String? error;
  LogoutErrorState(this.error);
}
