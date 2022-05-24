import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_kortobaa/widget/toast_and_snackbar.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../core/shared/route/magic_router.dart';
import '../core/utils/colors.dart';
import '../core/utils/my_enums.dart';
import '../services/cubit/app_cubit/app_cubit.dart';
import 'custom_buttons.dart';
import 'dialog_select_image.dart';

// ignore: must_be_immutable
class CustomDialogCreateNewPost extends StatelessWidget {
  CustomDialogCreateNewPost({Key? key}) : super(key: key);

  TextEditingController? controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(5),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.65,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Theme.of(context).dialogBackgroundColor),
          padding: const EdgeInsets.all(8.0),
          child: buildContentCreatePost(),
        ),
      ),
    );
  }

  BlocConsumer<AppCubit, AppState> buildContentCreatePost() {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is CreatePostSuccessState) {
          ToastAndSnackBar.toastSuccess(message: 'Success'.tr());
          MagicRouter.pop();
        }
        if (state is CreatePostErrorState) {
          ToastAndSnackBar.toastError(message: 'SomethingWentWrong'.tr());
          MagicRouter.pop();
        }
      },
      builder: (context, state) => LayoutBuilder(
        builder: (context, constraints) => Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ///Select Image Post
            buildSelectImagePost(context, constraints),

            /// Enter text post
            buildTextField(context),
            buildButtonsRow(context)
          ],
        ),
      ),
    );
  }

  Row buildButtonsRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomTextButton(
          text: 'Discard'.tr(),
          color: MyColors.colorOrange,
          onPressed: () {
            AppCubit.get(context).deleteImage(EnumSelectImage.IMGPOS.name);
            controller!.clear();
            MagicRouter.pop();
          },
        ),
        CustomButtonArgonAnimation(
          width: 100,
          text: 'Post'.tr(),
          color: MyColors.colorOrange,
          onTap: (start, stop, state) async {
            start();
            FocusScope.of(context).unfocus();

            await Future.sync(
                () => AppCubit.get(context).createPost(text: controller!.text));
            stop();
          },
        ),
      ],
    );
  }

  TextField buildTextField(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          label: Text('WriteCommentAboutThis'.tr()),
          labelStyle: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: MyColors.colorPrimary.withOpacity(0.4)),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 3,
              color: MyColors.colorOrange,
            ),
          ),
          disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 3,
              color: MyColors.colorOrange,
            ),
          ),
          border: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 3,
              color: MyColors.colorOrange,
            ),
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 3,
              color: MyColors.colorOrange,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 3,
              color: MyColors.colorOrange,
            ),
          ),
          helperStyle: Theme.of(context)
              .textTheme
              .caption!
              .copyWith(color: MyColors.colorPrimary.withOpacity(0.5))),
      maxLines: 3,
      maxLength: 120,
    );
  }

  GestureDetector buildSelectImagePost(
      BuildContext context, BoxConstraints constraints) {
    return GestureDetector(
      onTap: () => alertDialogImagePicker(context,
          imageType: EnumSelectImage.IMGPOS.name),
      child: SizedBox(
        height: constraints.maxHeight * 0.4,
        width: double.infinity,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 0.0,
          color: MyColors.colorPrimary.withOpacity(0.2),
          child: AppCubit.get(context).postImageFile != null
              ? Image.file(
                  AppCubit.get(context).postImageFile!,
                  fit: BoxFit.cover,
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt,
                      size: 70,
                      color: MyColors.colorPrimary.withOpacity(0.4),
                    ),
                    Text(
                      'UploadImage'.tr(),
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          color: MyColors.colorPrimary.withOpacity(0.5)),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
