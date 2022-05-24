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

class UpdateUserLoadingState extends AppState {}
class UpdateUserSuccessState extends AppState {}
class UpdateUserErrorState extends AppState {
  final String error;
  UpdateUserErrorState(this.error);
}

class GetImageSuccessState extends AppState {}

class NoGetImageState extends AppState {}

class DeleteImageState extends AppState {}

class CreatePostLoadingState extends AppState {}
class CreatePostSuccessState extends AppState {}
class CreatePostErrorState extends AppState {}

class GetPostLoadingState extends AppState {}
class GetPostSuccessState extends AppState {}
class GetPostErrorState extends AppState {}

class LikePostSuccessState extends AppState {}
class LikePostErrorState extends AppState {
  final String? error;
  LikePostErrorState(this.error);
}

class SavePostsInSavedHaveSuccessState extends AppState {}
class SavePostsInSavedHaveErrorState extends AppState {
  final String? error;
  SavePostsInSavedHaveErrorState(this.error);
}

class DeletePostsInSavedHaveSuccessState extends AppState {}
class DeletePostsInSavedHaveErrorState extends AppState {
  final String? error;
  DeletePostsInSavedHaveErrorState(this.error);
}

class GetPostsInSavedHaveSuccessState extends AppState {}
class GetPostsInSavedHaveErrorState extends AppState {
  final String? error;
  GetPostsInSavedHaveErrorState(this.error);
}

class SavePostsInFavoritesHaveSuccessState extends AppState {}
class SavePostsInFavoritesHaveErrorState extends AppState {
  final String? error;
  SavePostsInFavoritesHaveErrorState(this.error);
}

class DeletePostsInFavoritesHaveSuccessState extends AppState {}
class DeletePostsInFavoritesHaveErrorState extends AppState {
  final String? error;
  DeletePostsInFavoritesHaveErrorState(this.error);
}

class GetPostsInFavoritesHaveSuccessState extends AppState {}
class GetPostsInFavoritesHaveErrorState extends AppState {
  final String? error;
  GetPostsInFavoritesHaveErrorState(this.error);
}



