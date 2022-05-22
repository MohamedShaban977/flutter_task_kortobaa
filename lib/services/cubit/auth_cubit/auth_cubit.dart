import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      emit(RegisterErrorState('$error'));
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
      image:Image_Static,
      imageCover: Image_Cover_Static,
    );
    await _firestore
        .collection(Coll_Users)
        .doc(uId)
        .set(model.toJson())
        .then((value) {
      emit(CreateUserSuccessState(uId));
    }).catchError((error) {
      print(error.toString());

      emit(CreateUserErrorState('$error'));
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
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState('$error'));
    });
  }
}