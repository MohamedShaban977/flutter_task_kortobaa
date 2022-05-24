import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_kortobaa/core/helper/local/cache_helper.dart';
import 'package:flutter_task_kortobaa/core/shared/route/magic_router.dart';
import 'package:flutter_task_kortobaa/core/utils/constants.dart';
import 'package:flutter_task_kortobaa/services/cubit/app_cubit/app_cubit.dart';
import 'package:flutter_task_kortobaa/services/cubit/auth_cubit/auth_cubit.dart';
import 'package:flutter_task_kortobaa/view/layout_app/layout_app.dart';
import 'package:flutter_task_kortobaa/widget/toast_and_snackbar.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/validation.dart';
import '../../../widget/custom_buttons.dart';
import '../../../widget/custom_text_field.dart';

// ignore: must_be_immutable
class RegisterView extends StatelessWidget {
  RegisterView({Key? key}) : super(key: key);

  late String? _email, _password, _firstName, _lastName;
  Size? deviseSize;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AuthCubit _cubit;

  @override
  Widget build(BuildContext context) {
    deviseSize = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => AuthCubit(),
      child: buildBlocConsumer(),
    );
  }

  BlocConsumer<AuthCubit, AuthState> buildBlocConsumer() {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: initListener,
      builder: (context, state) {
        _cubit = AuthCubit.get(context);
        return buildScreen(context);
      },
    );
  }

  initListener(context, state) {
    if (state is RegisterErrorState) {
      ToastAndSnackBar.toastError(message: state.error!);
    }
    if (state is CreateUserErrorState) {
      ToastAndSnackBar.toastError(message: state.error!);
    }

    if (state is CreateUserSuccessState) {
      AppCubit.get(context).userModel = state.response;
      CacheHelper.saveData(key: Shared_Uid, value: state.response.uId)
          .then((value) => MagicRouter.navigateAndPopAll(LayoutApp()))
          .catchError((error) => print(error.toString()));
    }
  }

  GestureDetector buildScreen(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Register'.tr(),
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.apply(color: MyColors.colorPrimary, fontWeightDelta: 800),
          ),
          iconTheme: const IconThemeData(color: MyColors.colorPrimary),
          actionsIconTheme: const IconThemeData(color: MyColors.colorPrimary),
          toolbarHeight: 100,
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: deviseSize!.height * 0.02),

                  /// Email
                  CustomTextField(
                    onSaved: (value) => _email = value!,
                    validator: (value) => Validation.validEmail(value!),
                    label: 'Email'.tr(),
                  ),

                  /// Password
                  CustomTextField(
                    onSaved: (value) => _password = value!,
                    validator: (value) => Validation.isValidPassword(value!),
                    label: 'Password'.tr(),
                    textInputAction: TextInputAction.done,
                    obscureText: _cubit.isPassword,
                    icon: IconButton(
                      icon: Icon(
                        _cubit.suffix,
                        color: Theme.of(context).focusColor,
                      ),
                      onPressed: () => _cubit.changePassVisibility(),
                    ),
                  ),

                  /// Confirm Password
                  CustomTextField(
                    onSaved: (value) => null,
                    validator: (value) => Validation.isValidConfirmPassword(
                        confirmPassword: value!, password: _password!),
                    label: 'ConfirmPassword'.tr(),
                    obscureText: _cubit.isConfirmPassword,
                    textInputAction: TextInputAction.done,
                    icon: IconButton(
                      icon: Icon(
                        _cubit.suffixConfirmPassword,
                        color: Theme.of(context).focusColor,
                      ),
                      onPressed: () => _cubit.changePassConfirmVisibility(),
                    ),
                  ),

                  /// First Name
                  CustomTextField(
                    onSaved: (value) => _firstName = value!,
                    validator: (value) => Validation.validFirstName(value!),
                    label: 'FirstName'.tr(),
                  ),

                  /// Last Name
                  CustomTextField(
                    onSaved: (value) => _lastName = value!,
                    validator: (value) => Validation.validListName(value!),
                    label: 'LastName'.tr(),
                  ),

                  /// login button
                  CustomButtonArgonAnimation(
                      text: 'Register'.tr(),
                      color: MyColors.colorOrange,
                      width: deviseSize!.width,
                      onTap: registerFun),
                  const SizedBox(height: 15.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  registerFun(startLoading, stopLoading, state) async {
    _formKey.currentState!.save();
    if (state == ButtonState.Idle) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        startLoading();
        await Future.sync(() => _cubit.registerUser(
            email: _email!,
            password: _password!,
            firstName: _firstName!,
            lastName: _lastName!));
        stopLoading();

        // Future.delayed(const Duration(seconds: 2), () => stopLoading());
      }
    }
  }
}
