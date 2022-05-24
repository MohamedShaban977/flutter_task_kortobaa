import 'dart:io';

import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_kortobaa/core/utils/my_enums.dart';
import 'package:flutter_task_kortobaa/core/utils/style.dart';
import 'package:flutter_task_kortobaa/services/cubit/app_cubit/app_cubit.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/validation.dart';
import '../../../../widget/custom_buttons.dart';
import '../../../../widget/custom_text_field.dart';
import '../../../../widget/dialog_select_image.dart';


class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);

  String? _firstName, _lastName;
  late Size deviseSize;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late AppCubit _cubit;

  @override
  Widget build(BuildContext context) {
    deviseSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('EditProfile'.tr()),
      ),
      body: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          _cubit = AppCubit.get(context);
          return ModalProgressHUD(
            inAsyncCall: state is UpdateUserLoadingState,
            progressIndicator: loading(context),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  buildTop(context),

                  /// First Name
                  CustomTextField(
                    onSaved: (value) => _firstName = value!,
                    validator: (value) => Validation.validFirstName(value!),
                    label: 'FirstName'.tr(),
                    initialValue: _cubit.userModel.firstName,
                  ),

                  /// Last Name
                  CustomTextField(
                    onSaved: (value) => _lastName = value!,
                    validator: (value) => Validation.validListName(value!),
                    label: 'LastName'.tr(),
                    initialValue: _cubit.userModel.lastName,
                  ),

                  /// Edit button
                  CustomButtonArgonAnimation(
                    text: 'Save'.tr(),
                    color: MyColors.colorOrange,
                    width: deviseSize.width,
                    onTap: editProfileFun,
                  ),
                  const SizedBox(height: 15.0),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Column buildTop(context) => Column(
        children: [
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Container(
                  margin: EdgeInsets.only(bottom: deviseSize.height * 0.15 / 2),
                  child: buildCoverImage(context)),
              Positioned(
                  top: (deviseSize.height * 0.2) -
                      (deviseSize.height * 0.15) / 2,
                  child: buildProfileImage(context)),
            ],
          ),
          const SizedBox(height: 30.0),
          Text('${_cubit.userModel.email}',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: MyColors.colorPrimary.withOpacity(0.6))),
        ],
      );

  Card buildCoverImage(context) => Card(
        color: MyColors.colorDrawre.withOpacity(0.6),
        elevation: 5.0,
        margin: const EdgeInsets.all(8.0),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Stack(
          children: [
            handleShowCoverImage(),
            buildButtonChooseImageOrDeleted(context,
                imageType: EnumSelectImage.IMGCOV.name,
                file: _cubit.coverImageFile),
          ],
        ),
      );

  Widget buildProfileImage(context) =>
      Stack(alignment: Alignment.center, clipBehavior: Clip.none, children: [
        buildCircleImageProfile(),
        buildButtonChooseImageOrDeleted(context,
            imageType: EnumSelectImage.IMGPRO.name,
            file: _cubit.imageProfileFile),
      ]);

  Positioned buildButtonChooseImageOrDeleted(
    context, {
    required String imageType,
    required File? file,
  }) =>
      Positioned(
        bottom: imageType == EnumSelectImage.IMGPRO.name ? 5 : null,
        top: imageType == EnumSelectImage.IMGCOV.name ? 5 : null,
        left: imageType == EnumSelectImage.IMGPRO.name
            ? (deviseSize.width * 0.15)
            : null,
        child: RawMaterialButton(
          onPressed: () => file != null
              ? _cubit.deleteImage(imageType) // EnumSelectImage.IMGPRO.name
              : alertDialogImagePicker(context, imageType: imageType),
          elevation: 0.0,
          fillColor: MyColors.colorDrawre.withOpacity(0.7),
          padding: const EdgeInsets.all(8.0),
          shape: const CircleBorder(),
          child: file != null
              ? Icon(
                  Icons.delete,
                  color: Colors.red.withOpacity(0.7),
                )
              : const Icon(
                  Icons.camera_alt,
                  color: Colors.white70,
                ),
        ),
      );

  PhysicalModel buildCircleImageProfile() => PhysicalModel(
        color: Colors.black,
        elevation: 8.0,
        shape: BoxShape.circle,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: CircleAvatar(
          radius: (deviseSize.height * 0.15) / 2,
          backgroundColor: MyColors.colorDrawre.withOpacity(0.5),
          backgroundImage: handleShowImageProfile(),
        ),
      );

  handleShowCoverImage() {
    if (_cubit.coverImageFile != null) {
      return Image.file(
        _cubit.coverImageFile!,
        fit: BoxFit.cover,
        height: deviseSize.height * 0.2,
        width: deviseSize.width,
      );
    } else if (_cubit.userModel.imageCover != null) {
      return CachedNetworkImage(
        imageUrl: _cubit.userModel.imageCover!,
        fit: BoxFit.cover,
        height: deviseSize.height * 0.2,
        width: deviseSize.width,
      );
    } else {
      return Container();
    }
  }

  handleShowImageProfile() {
    if (_cubit.imageProfileFile != null) {
      return FileImage(_cubit.imageProfileFile!);
    } else if (_cubit.userModel.image != null) {
      return CachedNetworkImageProvider(_cubit.userModel.image!);
    } else {
      return Container();
    }
  }

  editProfileFun(startLoading, stopLoading, ButtonState state) async {
    if (state == ButtonState.Idle) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        startLoading();
        await Future.sync(() => _cubit.updateUserData(
              firstName: _firstName,
              lastName: _lastName,
            ));
        _cubit.deleteImage(EnumSelectImage.IMGPRO.name);
        _cubit.deleteImage(EnumSelectImage.IMGCOV.name);
        stopLoading();
      }
    }
  }
}
