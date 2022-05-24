import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_kortobaa/core/utils/constants.dart';
import 'package:flutter_task_kortobaa/core/utils/my_enums.dart';
import 'package:flutter_task_kortobaa/services/model/post_model.dart';
import 'package:flutter_task_kortobaa/services/model/user_model.dart';
import 'package:flutter_task_kortobaa/widget/toast_and_snackbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:meta/meta.dart';

import '../../../core/helper/local/hive_helper.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late UserModel userModel;

  getUserData() {
    emit(GetUserLoadingState());
    _firestore.collection(Coll_Users).doc(uId).get().then((value) {
      print(value.data());
      userModel = UserModel.fromJson(value.data()!);
      emit(GetUserSuccessState());
    }).catchError((error) {
      print('$error');
      emit(GetUserErrorState('$error'));
    });
  }

  List<PostModel> posts = [];
  bool loadingPost = true, gettingMorePosts = false, morePostsAvailable = true;
  int _limit = 3;
  late DocumentSnapshot _lastDocument;

  getPost() async {
    await _firestore
        .collection(Coll_Posts)
        .orderBy('dateTime', descending: true)
        .limit(_limit)
        .get()
        .then((value) {
      for (var element in value.docs) {
        posts.add(PostModel.fromJson(element.data()));
        print(element.data()['dateTime']);
      }
      _lastDocument = value.docs.last;
      emit(GetPostSuccessState());
    }).catchError((error) {
      print(error.toString());

      emit(GetPostErrorState());
    });

    loadingPost = false;
  }

  getMorePosts() async {
    if (!morePostsAvailable) {
      return;
    }
    if (gettingMorePosts) {
      return;
    }
    gettingMorePosts = true;
    await _firestore
        .collection(Coll_Posts)
        .startAfterDocument(_lastDocument)
        .orderBy('dateTime', descending: true)
        .limit(_limit)
        .get()
        .then((value) {
      for (var element in value.docs) {
        posts.add(PostModel.fromJson(element.data()));
      }
      if (value.docs.length < _limit) {
        morePostsAvailable = false;
      }
      _lastDocument = value.docs.last;
      emit(GetPostSuccessState());
    }).catchError((error) {
      emit(GetPostErrorState());
    });

    gettingMorePosts = false;
  }

  onRefreshGetPost() {
    loadingPost = true;
    gettingMorePosts = false;
    morePostsAvailable = true;
    _limit = 3;
    posts.clear();
    getPost();
  }

  /// Choose Image
  File? imageProfileFile, coverImageFile, postImageFile;
  String? imageProfilePathName, coverImagePathName, postImagePathName;
  String? imageProfileUrl, coverImageUrl, postImageUrl;

  getImage(
    context, {
    required String imageType,
    required ImageSource src,
  }) async {
    try {
      final imagePicked = await ImagePicker().pickImage(source: src);

      if (imagePicked == null) {
        emit(NoGetImageState());
        return;
      }
      switch (imageType) {
        case 'IMGPRO':
          {
            imageProfileFile = File(imagePicked.path);
            imageProfilePathName = imageProfileFile!.path.split('/').last;
            emit(GetImageSuccessState());
          }
          break;
        case 'IMGCOV':
          {
            coverImageFile = File(imagePicked.path);
            coverImagePathName = coverImageFile!.path.split('/').last;
            emit(GetImageSuccessState());
          }
          break;
        case 'IMGPOS':
          {
            postImageFile = File(imagePicked.path);
            postImagePathName = postImageFile!.path.split('/').last;
            emit(GetImageSuccessState());
          }
      }
    } on PlatformException catch (e) {
      print('error Choose image because $e');
      emit(NoGetImageState());
    }
  }

  deleteImage(String imageType) {
    if (imageType == EnumSelectImage.IMGPRO.name) {
      imageProfileFile = null;
      imageProfilePathName = null;
      imageProfileUrl = null;
      emit(DeleteImageState());
      return;
    } else if (imageType == EnumSelectImage.IMGCOV.name) {
      coverImageFile = null;
      coverImagePathName = null;
      coverImageUrl = null;
      emit(DeleteImageState());
      return;
    } else if (imageType == EnumSelectImage.IMGPOS.name) {
      postImageFile = null;
      postImagePathName = null;
      postImageUrl = null;
      emit(DeleteImageState());
      return;
    }
  }

  uploadImageProfile() async {
    await FirebaseStorage.instance
        .ref()
        .child('$Coll_Users/$imageProfilePathName')
        .putFile(imageProfileFile!)
        .then((p0) async => await _getDownloadURLImage(p0,
            userType: EnumSelectImage.IMGPRO.name))
        .catchError((error) {
      print(error);
    });
  }

  uploadCoverImage() async {
    await FirebaseStorage.instance
        .ref()
        .child('$Coll_Users/$coverImagePathName')
        .putFile(coverImageFile!)
        .then((p0) async => await _getDownloadURLImage(p0,
            userType: EnumSelectImage.IMGCOV.name))
        .catchError((error) {
      print(error);
    });
  }

  uploadPostImage() async {
    final FirebaseStorage _storage = FirebaseStorage.instance;
    await _storage
        .ref()
        .child('$Coll_Posts/$postImagePathName')
        .putFile(postImageFile!)
        .then((p0) async => await _getDownloadURLImage(p0,
            userType: EnumSelectImage.IMGPOS.name))
        .catchError((error) {
      print(error);
    });
  }

  _getDownloadURLImage(p0, {required String userType}) async {
    await p0.ref.getDownloadURL().then((value) {
      _handleUserTypeInGetImageURL(userType, value);
      print(value);
    }).catchError((error) {
      print(error);
    });
  }

  _handleUserTypeInGetImageURL(String userType, String value) {
    if (userType == EnumSelectImage.IMGPRO.name) {
      imageProfileUrl = value;
    } else if (userType == EnumSelectImage.IMGCOV.name) {
      coverImageUrl = value;
    } else if (userType == EnumSelectImage.IMGPOS.name) {
      postImageUrl = value;
    }
  }

  updateUserData({
    required String? firstName,
    required String? lastName,
  }) async {
    emit(UpdateUserLoadingState());
    if (imageProfileFile != null) {
      await uploadImageProfile();
    }
    if (coverImageFile != null) {
      await uploadCoverImage();
    }

    final modal = UserModel(
      lastName: lastName ?? userModel.lastName,
      firstName: firstName ?? userModel.firstName,
      email: userModel.email,
      uId: userModel.uId,
      image: imageProfileUrl ?? userModel.image,
      imageCover: coverImageUrl ?? userModel.imageCover,
    );

    await _firestore
        .collection(Coll_Users)
        .doc(userModel.uId)
        .update(modal.toJson())
        .then((value) async {
      await getUserData();
      emit(UpdateUserSuccessState());
    }).catchError((error) {
      print(error);
      emit(UpdateUserErrorState(error));
    });
  }

  createPost({required String text}) async {
    emit(CreatePostLoadingState());
    if (postImageFile != null) {
      await uploadPostImage();
    }
    PostModel postModel = PostModel(
      uId: userModel.uId,
      name: '${userModel.firstName} ${userModel.lastName}',
      imageUser: userModel.image,
      dateTime: Timestamp.now(),
      text: text,
      imagePost: postImageUrl ?? '',
    );

    await _firestore
        .collection(Coll_Posts)
        .add(postModel.toJson())
        .then((value) async {
      await _firestore
          .collection(Coll_Posts)
          .doc(value.id)
          .update(PostModel(
              uId: userModel.uId,
              name: '${userModel.firstName} ${userModel.lastName}',
              imageUser: userModel.image,
              dateTime: Timestamp.now(),
              text: text,
              imagePost: postImageUrl ?? '',
              idPost: value.id,
              likes: Likes(
                likesUserId: [],
                isLike: false,
              )).toJson())
          .then((value) async {
        posts.clear();
        getPost();
        deleteImage(EnumSelectImage.IMGPOS.name);
      });

      emit(CreatePostSuccessState());
    }).catchError((error) {
      emit(CreatePostErrorState());
    });
  }

  // late List<PostModel> posts = [];
  //
  // getAllPosts() async {
  //   emit(GetPostLoadingState());
  //   await _firestore.collection(Coll_Posts).get().then((value) async {
  //     for (var element in value.docs) {
  //       posts.add(PostModel.fromJson(element.data()));
  //       emit(GetPostSuccessState());
  //     }
  //     print(value..docs[0].id);
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(GetPostErrorState());
  //   });
  // }

  updateLikePost({required PostModel postPosition}) async {
    if (postPosition.likes!.likesUserId!.contains(userModel.uId)) {
      postPosition.likes!.likesUserId!.remove(userModel.uId);
    } else {
      postPosition.likes!.likesUserId!.add(userModel.uId!);
    }

    if (postPosition.likes!.isLike!) {
      postPosition.likes!.isLike = false;
    } else {
      postPosition.likes!.isLike = true;
    }

    PostModel postModel = PostModel(
        uId: postPosition.uId,
        name: postPosition.name,
        imageUser: postPosition.imageUser,
        dateTime: postPosition.dateTime,
        text: postPosition.text,
        idPost: postPosition.idPost,
        imagePost: postPosition.imagePost,
        likes: Likes(
            isLike: postPosition.likes!.isLike,
            likesUserId: postPosition.likes!.likesUserId));

    await _firestore
        .collection(Coll_Posts)
        .doc(postPosition.idPost)
        .update(postModel.toJson())
        .then((value) async {
      emit(LikePostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(LikePostErrorState(error));
    });
  }

  savedPostInSavedHive(int index) async {
    await HiveHelper.cacheSavedPostById(
      posts[index].idPost!,
      posts[index],
    ).then((value) {
      emit(SavePostsInSavedHaveSuccessState());
      ToastAndSnackBar.toastSuccess(message: 'SavedSuc'.tr());
    }).catchError((error) {
      emit(SavePostsInSavedHaveErrorState(error));
    });
  }

  deletePostInSavedHive(int index) async {
    await HiveHelper.deleteSavedPostById(postsSavedHave[index].idPost!)
        .then((value) {
      emit(DeletePostsInSavedHaveSuccessState());
      ToastAndSnackBar.toastSuccess(message: 'UnSaved'.tr());
    }).catchError((error) {
      emit(DeletePostsInSavedHaveErrorState(error));
    });
    getPostsSavedInHave();
  }

  savedOrDeletePostInHave(int index) async {
    if (HiveHelper.savedPostsDB.containsKey(posts[index].idPost)) {
      await deletePostInSavedHive(index);
    } else {
      await savedPostInSavedHive(index);
    }
    getPostsSavedInHave();
  }

  List<PostModel> postsSavedHave = [];

  getPostsSavedInHave() async {
    postsSavedHave = await HiveHelper.getPostsSaved();
  }

  savePostInFavoritesHive(PostModel postModel) async {
    await HiveHelper.cacheFavoritesPostById(
      postModel.idPost!,
      postModel,
    ).then((value) {
      emit(SavePostsInFavoritesHaveSuccessState());
      ToastAndSnackBar.toastSuccess(message: 'SavedSuc'.tr());
    }).catchError((error) {
      emit(SavePostsInFavoritesHaveErrorState(error));
    });
  }

  deletePostInFavoritesHive(PostModel postModel) async {
    await HiveHelper.deleteFavoritesPostById(postModel.idPost!).then((value) {
      emit(DeletePostsInFavoritesHaveSuccessState());
      ToastAndSnackBar.toastSuccess(message: 'UnSaved'.tr());
    }).catchError((error) {
      emit(DeletePostsInFavoritesHaveErrorState(error));
    });
    getPostsFavoritesInHave();
  }

  favoritesOrDeletePostInHave(PostModel postModel) async {
    if (HiveHelper.favoritesPostsDB.containsKey(postModel.idPost)) {
      await deletePostInFavoritesHive(postModel);
    } else {
      await savePostInFavoritesHive(postModel);
    }
    getPostsFavoritesInHave();
  }

  List<PostModel> postsFavoritesHave = [];

  getPostsFavoritesInHave() async {
    postsFavoritesHave = await HiveHelper.getPostsFavorites();
  }
// Future<void> likePost(String postId) async {
//   Map<String, dynamic> likeMap = {'like': true};
//
//   await _firestore
//       .collection(Coll_Posts)
//       .doc(postId)
//       .collection(Coll_Likes)
//       .doc(userModel.uId)
//       .set(likeMap)
//       .then((value) {
//     emit(LikePostSuccessState());
//   }).catchError((error) {
//     emit(LikePostErrorState(error));
//   });
// }
//
// Future<void> disLikePost(String postId) async {
//   Map<String, dynamic> likeMap = {'like': false};
//
//   await _firestore
//       .collection(Coll_Posts)
//       .doc(postId)
//       .collection(Coll_Likes)
//       .doc(userModel.uId)
//       .set(likeMap)
//       .then((value) {
//     emit(LikePostSuccessState());
//   }).catchError((error) {
//     emit(LikePostErrorState(error));
//   });
// }
}
