part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}


class PassVisibilityState extends AuthState{}
class PassConfirmVisibilityState extends AuthState{}

class LoginLoadingState extends AuthState {}
class LoginSuccessState extends AuthState {
  final String uId;

  LoginSuccessState(this.uId);

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
  final String uId;

  CreateUserSuccessState(this.uId);
}
class CreateUserErrorState extends AuthState {
  final String? error;
  CreateUserErrorState(this.error);
}
