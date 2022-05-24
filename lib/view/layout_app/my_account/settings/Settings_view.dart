import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_kortobaa/core/shared/route/magic_router.dart';
import 'package:flutter_task_kortobaa/core/shared/translation/Translation.dart';
import 'package:flutter_task_kortobaa/core/utils/colors.dart';
import 'package:flutter_task_kortobaa/core/utils/style.dart';
import 'package:flutter_task_kortobaa/services/cubit/auth_cubit/auth_cubit.dart';
import 'package:flutter_task_kortobaa/view/authentication/login/login_view.dart';
import 'package:flutter_task_kortobaa/widget/toast_and_snackbar.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'.tr()),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20.0),

          /// change Lang
          buildButtonElevated(
            context,
            text: 'buttonLang'.tr(),
            onPressed: () => TranslateLang.changeLang(context),
          ),
          const SizedBox(height: 20.0),

          BlocProvider(
            create: (context) => AuthCubit(),
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is LogoutSuccessState) {

                  MagicRouter.navigateAndPopAll(LoginView());
                }
                if (state is LogoutErrorState) {
                  ToastAndSnackBar.toastError(message: state.error!);
                }
              },
              builder: (context, state) {
                return ConditionalBuilder(
                  condition: state is! LogoutLoadingState,
                  fallback: (context)=>const CircularProgressIndicator(color: MyColors.colorOrange) ,
                  builder: (context)=> buildButtonElevated(
                    context,
                    text: 'Logout'.tr(),
                    onPressed: () => AuthCubit.get(context).logout(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Padding buildButtonElevated(context,
      {required String text, required Function()? onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 60.0,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: MyColors.colorDrawre,
                  fontWeight: FontWeight.w600,
                ),
          ),
          style: ButtonStyle(
            textStyle:
                MaterialStateProperty.all(Theme.of(context).textTheme.button),
            padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 20)),
            backgroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              // side: BorderSide(color: Colors.red)
            )),
          ),
        ),
      ),
    );
  }
}
