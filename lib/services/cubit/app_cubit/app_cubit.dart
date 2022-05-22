import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_kortobaa/core/utils/constants.dart';
import 'package:flutter_task_kortobaa/core/utils/my_enums.dart';
import 'package:flutter_task_kortobaa/services/model/user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  late UserModel model;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  getUserData() {
    emit(GetUserLoadingState());
    _firestore.collection(Coll_Users).doc(uId).get().then((value) {
      print(value.data());
      model = UserModel.fromJson(value.data()!);
      emit(GetUserSuccessState());
    }).catchError((error) {
      print('$error');
      emit(GetUserErrorState('$error'));
    });
  }

  /// Choose Image
  File? imageProfileFile, coverImageFile, postImageFile;
  String? imageProfilePathName, coverImagePathName, postImagePathName;

  Future<void> getImage(context,
      {required String imageType, required ImageSource src}) async {
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
      emit(DeleteImageState());
      return;
    } else if (imageType == EnumSelectImage.IMGCOV.name) {
      coverImageFile = null;
      coverImagePathName = null;
      emit(DeleteImageState());
      return;
    } else if (imageType == EnumSelectImage.IMGPOS.name) {
      postImageFile = null;
      postImagePathName = null;
      emit(DeleteImageState());
      return;
    }
  }

  uploadImageProfile() {
    final FirebaseStorage _storage = FirebaseStorage.instance;

    _storage
        .ref()
        .child('$Coll_Users/$imageProfilePathName')
        .putFile(imageProfileFile!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        print(value);
      }).catchError((error) {
        print(error);
      });
    }).catchError((error) {
      print(error);
    });
  }
}
