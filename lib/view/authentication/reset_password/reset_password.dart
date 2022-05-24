import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_kortobaa/core/shared/route/magic_router.dart';
import 'package:flutter_task_kortobaa/core/utils/style.dart';
import 'package:flutter_task_kortobaa/services/cubit/auth_cubit/auth_cubit.dart';
import 'package:flutter_task_kortobaa/view/authentication/login/login_view.dart';
import 'package:flutter_task_kortobaa/widget/toast_and_snackbar.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/validation.dart';
import '../../../widget/custom_buttons.dart';
import '../../../widget/custom_text_field.dart';

// ignore: must_be_immutable
class ResetPassword extends StatelessWidget {
  ResetPassword({Key? key}) : super(key: key);

  late Size deviceSize;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _email;
  late AuthCubit _cubit;

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccessState) {
            ToastAndSnackBar.toastSuccess(message: 'CheckYourEmail'.tr());
            MagicRouter.navigateAndPopAll(LoginView());
          }
          if (state is ResetPasswordErrorState) {
            ToastAndSnackBar.toastError(message: state.error!);
          }
        },

        ///
        builder: (context, state) {
          _cubit = AuthCubit.get(context);

          return ModalProgressHUD(
            inAsyncCall: state is ResetPasswordLoadingState,
            progressIndicator: Center(child: loading(context)),
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                appBar: buildAppBar(context),
                body: SizedBox(
                  height: (deviceSize.height -
                      buildAppBar(context).preferredSize.height -
                      MediaQuery.of(context).padding.top),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: deviceSize.height * 0.15),
                        Card(
                          elevation: 10.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          margin: const EdgeInsets.all(20.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: deviceSize.height * 0.02),

                                /// Email
                                CustomTextField(
                                  onSaved: (value) => _email = value,
                                  validator: (value) =>
                                      Validation.validEmail(value!),
                                  label: 'Email'.tr(),
                                ),
                                SizedBox(height: deviceSize.height * 0.05),

                                /// send email
                                CustomButtonArgonAnimation(
                                  text: 'Send'.tr(),
                                  color: MyColors.colorOrange,
                                  width: deviceSize.width,
                                  onTap:
                                      (startLoading, stopLoading, stateBtn) =>
                                          resetPasswordFun(
                                              context,
                                              startLoading,
                                              stopLoading,
                                              stateBtn),
                                ),
                                SizedBox(height: deviceSize.height * 0.02),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'ResetPassword'.tr(),
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .headline6
            ?.apply(color: MyColors.colorPrimary, fontWeightDelta: 2),
      ),
      iconTheme: const IconThemeData(color: MyColors.colorPrimary),
      actionsIconTheme: const IconThemeData(color: MyColors.colorPrimary),
      toolbarHeight: MediaQuery.of(context).size.height * 0.1,
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: Colors.transparent,
    );
  }

  resetPasswordFun(context, startLoading, stopLoading, stateBtn) async {
    if (stateBtn == ButtonState.Idle) {
      FocusScope.of(context).unfocus();
      startLoading();
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        _cubit.resetPassword(_email!);
      }
      stopLoading();
    }
  }
}
