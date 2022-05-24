import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_kortobaa/core/helper/local/cache_helper.dart';
import 'package:flutter_task_kortobaa/core/utils/constants.dart';
import 'package:flutter_task_kortobaa/services/model/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.remove_red_eye,
      suffixConfirmPassword = Icons.remove_red_eye;
  bool isPassword = true;
  bool isConfirmPassword = true;

  void changePassVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.remove_red_eye : Icons.visibility_off_outlined;
    emit(PassVisibilityState());
  }

  void changePassConfirmVisibility() {
    isConfirmPassword = !isConfirmPassword;
    suffixConfirmPassword = isConfirmPassword
        ? Icons.remove_red_eye
        : Icons.visibility_off_outlined;
    emit(PassConfirmVisibilityState());
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> registerUser(
      {required String email,
      required String password,
      required String firstName,
      required String lastName}) async {
    emit(RegisterLoadingState());
    await _auth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) async {
      print(value.user!.email);
      print(value.user!.uid);
      await userCreate(
        uId: value.user!.uid,
        email: email,
        firstName: firstName,
        lastName: lastName,
      );
      emit(RegisterSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error.toString().split(']').last));
    });
  }

  Future<void> userCreate({
    required String email,
    required String firstName,
    required String lastName,
    required String uId,
  }) async {
    emit(CreateUserLoadingState());
    UserModel model = UserModel(
      email: email,
      uId: uId,
      firstName: firstName,
      lastName: lastName,
      image: Image_Static,
      imageCover: Image_Cover_Static,
    );
    await _firestore
        .collection(Coll_Users)
        .doc(uId)
        .set(model.toJson())
        .then((value) async {
      await _firestore.collection(Coll_Users).doc(uId).get().then((value) {
        final UserModel userModel = UserModel.fromJson(value.data()!);
        emit(CreateUserSuccessState(userModel));
      }).catchError((error) {});
    }).catchError((error) {
      print(error.toString());

      emit(CreateUserErrorState(error.toString().split(']').last));
    });
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    await _auth
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) async {
      print(value.user!.email);
      print(value.user!.uid);
      await _firestore
          .collection(Coll_Users)
          .doc(value.user!.uid)
          .get()
          .then((value) {
        final UserModel userModel = UserModel.fromJson(value.data()!);
        emit(LoginSuccessState(userModel));
      }).catchError((error) {});
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState(error.toString().split(']').last));
    });
  }

  Future<void> resetPassword(String email) async {
    emit(ResetPasswordLoadingState());
    await _auth.sendPasswordResetEmail(email: email).then((value) {
      emit(ResetPasswordSuccessState());
    }).catchError((error) {
      print(error.toString().split(']').last);
      print(error.toString());

      emit(ResetPasswordErrorState(error.toString().split(']').last));
    });
  }

  logout() async {
    emit(LogoutLoadingState());
    await _auth.signOut().then((value) {
      CacheHelper.removeData(key: Shared_Uid);
      emit(LogoutSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(LogoutErrorState(error));
    });
  }
}
