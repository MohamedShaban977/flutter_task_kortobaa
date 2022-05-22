part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class GetUserLoadingState extends AppState {}
class GetUserSuccessState extends AppState {}
class GetUserErrorState extends AppState {
  final String error;

  GetUserErrorState(this.error);
}


class GetImageSuccessState extends AppState {}

class NoGetImageState extends AppState {}

class DeleteImageState extends AppState {}

