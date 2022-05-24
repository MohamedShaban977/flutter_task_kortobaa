import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_kortobaa/core/helper/local/cache_helper.dart';
import 'package:flutter_task_kortobaa/core/shared/route/magic_router.dart';
import 'package:flutter_task_kortobaa/core/shared/translation/Translation.dart';
import 'package:flutter_task_kortobaa/core/utils/colors.dart';
import 'package:flutter_task_kortobaa/core/utils/constants.dart';
import 'package:flutter_task_kortobaa/core/utils/validation.dart';
import 'package:flutter_task_kortobaa/services/cubit/app_cubit/app_cubit.dart';
import 'package:flutter_task_kortobaa/services/cubit/auth_cubit/auth_cubit.dart';
import 'package:flutter_task_kortobaa/view/authentication/register/register_view.dart';
import 'package:flutter_task_kortobaa/view/layout_app/layout_app.dart';
import 'package:flutter_task_kortobaa/widget/custom_buttons.dart';
import 'package:flutter_task_kortobaa/widget/custom_text_field.dart';
import 'package:flutter_task_kortobaa/widget/toast_and_snackbar.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

// ignore: must_be_immutable
class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  late String? _email, _password;

  late AuthCubit _cubit;
  late Size deviseSize;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    deviseSize = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: initListener,
        builder: (context, state) {
          _cubit = AuthCubit.get(context);
          return buildScreen(context);
        },
      ),
    );
  }

  initListener(context, state) {
    if (state is LoginErrorState) {
      ToastAndSnackBar.toastError(message: state.error!);
    }

    if (state is LoginSuccessState) {

      CacheHelper.saveData(key: Shared_Uid, value: state.response.uId)
          .then((value) => MagicRouter.navigateAndPopAll(LayoutApp()))
          .catchError((error) {
        print(error.toString());
      });
      AppCubit.get(context).userModel = state.response;
    }
  }

  SafeArea buildScreen(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: deviseSize.height * 0.1),
                    Text(
                      'Login'.tr(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline6?.apply(
                          color: MyColors.colorPrimary, fontWeightDelta: 800),
                    ),
                    const SizedBox(height: 40.0),

                    /// Email
                    CustomTextField(
                      onSaved: (value) => _email = value,
                      validator: (value) => Validation.validEmail(value!),
                      label: 'Email'.tr(),
                    ),

                    /// Password
                    CustomTextField(
                      onSaved: (value) => _password = value,
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

                    /// forget Password
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CustomTextButton(
                        text: 'Forget'.tr(),
                        onPressed: () => null,
                      ),
                    ),

                    // const SizedBox(height: 20.0),

                    /// login button
                    CustomButtonArgonAnimation(
                        text: 'Login'.tr(),
                        color: MyColors.colorOrange,
                        width: deviseSize.width,
                        onTap: loginFun),

                    const SizedBox(height: 15.0),

                    /// Text Or and divider
                    buildTextOrAndDivider(context),

                    const SizedBox(height: 15.0),

                    /// Check Account
                    Text('CheckAccount'.tr(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle1),

                    const SizedBox(height: 15.0),

                    /// Register New Account
                    CustomOutlinedButton(
                      text: 'RegisterNewAccount'.tr(),
                      onPressed: () => MagicRouter.navigateTo(RegisterView()),
                      width: deviseSize.width,
                      colorText: MyColors.colorOrangeSecond,
                      iconData: Icons.person_add_alt,
                    ),

                    const SizedBox(height: 15.0),

                    /// set New Language
                    CustomTextButton(
                      text: 'buttonLang'.tr(),
                      onPressed: () => TranslateLang.changeLang(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  loginFun(startLoading, stopLoading, state) async {
    if (state == ButtonState.Idle) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        startLoading();
        await Future.sync(() => _cubit.loginUser(
              email: _email!,
              password: _password!,
            ));
        stopLoading();
        // Future.delayed(const Duration(seconds: 2), () => stopLoading());
      }
    }
  }

  Row buildTextOrAndDivider(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            height: 10,
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'OR'.tr(),
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        const Expanded(
          child: Divider(
            height: 10,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}

/// validation
