import 'package:flutter_task_kortobaa/services/model/post_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveHelper {
  static late Box<dynamic> savedPostsDB;
  static late Box<dynamic> favoritesPostsDB;
  static const _SAVED_POST_DB = 'Saved_Posts';
  static const _FAVORITES_POSTS_DB = 'FAVORITES_POSTS';

  static Future<void> init() async {
    var appDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDirectory.path);
    savedPostsDB = await Hive.openBox(_SAVED_POST_DB);
    favoritesPostsDB = await Hive.openBox(_FAVORITES_POSTS_DB);
  }

  static Future<PostModel> getPostById(int id) async {
    late PostModel postModel;
    if (savedPostsDB.containsKey(id)) {
      final jsonNewsModel = await savedPostsDB.get(id);
      postModel = PostModel.fromHive(jsonNewsModel);
    }
    return postModel;
  }

  static Future<List<PostModel>> getPostsSaved() async {
    late List<PostModel> postModel = [];
    postModel = savedPostsDB.values.map((e) => PostModel.fromHive(e)).toList();

    return postModel;
  }

  static Future<void> cacheSavedPostById(String id, PostModel postModel) async {
    final jsonNewsModel = postModel.toJson();
    await savedPostsDB.put(id, jsonNewsModel);
  }

  static Future<void> deleteSavedPostById(String id) async {
    await savedPostsDB.delete(id);
  }

  static Future<List<PostModel>> getPostsFavorites() async {
    late List<PostModel> postModel = [];
    postModel =
        favoritesPostsDB.values.map((e) => PostModel.fromHive(e)).toList();

    return postModel;
  }

  static Future<void> cacheFavoritesPostById(
      String id, PostModel postModel) async {
    final jsonNewsModel = postModel.toJson();
    await favoritesPostsDB.put(id, jsonNewsModel);
  }

  static Future<void> deleteFavoritesPostById(String id) async {
    await favoritesPostsDB.delete(id);
  }
}
