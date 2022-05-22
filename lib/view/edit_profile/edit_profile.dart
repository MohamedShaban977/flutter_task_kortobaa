import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_kortobaa/core/utils/my_enums.dart';
import 'package:flutter_task_kortobaa/services/cubit/app_cubit/app_cubit.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../core/utils/colors.dart';
import '../../core/utils/validation.dart';
import '../../widget/custom_buttons.dart';
import '../../widget/custom_text_field.dart';
import '../../widget/dialog_select_image.dart';

class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);

  String? _email, _firstName, _lastName;
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
          return Form(
            key: _formKey,
            child: ListView(
              children: [
                buildTop(context),
                /// Email
                CustomTextField(
                  onSaved: (value) => _email = value!,
                  validator: (value) => Validation.validEmail(value!),
                  label: 'Email'.tr(),
                  initialValue: _cubit.model.email,
                ),

                /// First Name
                CustomTextField(
                  onSaved: (value) => _firstName = value!,
                  validator: (value) => Validation.validFirstName(value!),
                  label: 'FirstName'.tr(),
                  initialValue: _cubit.model.firstName,
                ),

                /// Last Name
                CustomTextField(
                  onSaved: (value) => _lastName = value!,
                  validator: (value) => Validation.validListName(value!),
                  label: 'LastName'.tr(),
                  initialValue: _cubit.model.lastName,
                ),

                /// Edit button
                CustomButtonArgonAnimation(
                    text: 'Save'.tr(),
                    color: MyColors.colorOrange,
                    width: deviseSize.width,
                    onTap: EditProfileFun),
                const SizedBox(height: 15.0),
              ],
            ),
          );
        },
      ),
    );
  }
  Stack buildTop(context) => Stack(
    alignment: Alignment.center,
    clipBehavior: Clip.none,
    children: [
      Container(
          margin: EdgeInsets.only(bottom: deviseSize.height * 0.15 / 2),
          child: buildCoverImage(context)),
      Positioned(
          top: (deviseSize.height * 0.2) - (deviseSize.height * 0.15) / 2,
          child: buildProfileImage(context)),
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
            Positioned(
              top: 5,
              // right: ,
              child: RawMaterialButton(
                onPressed: () => alertDialogImagePicker(context,
                    imageType: EnumSelectImage.IMGCOV.name),
                elevation: 0.0,
                fillColor: MyColors.colorPrimary.withOpacity(0.5),
                padding: const EdgeInsets.all(8.0),
                shape: const CircleBorder(),
                child: const Icon(
                  Icons.edit,
                  color: Colors.white70,
                ),
              ),
            ),
            if (_cubit.coverImageFile != null)
              Positioned(
                bottom: 5,
                right: 60,
                child: RawMaterialButton(
                  onPressed: () =>
                      _cubit.deleteImage(EnumSelectImage.IMGCOV.name),
                  elevation: 0.0,
                  fillColor: MyColors.colorPrimary.withOpacity(0.5),
                  padding: const EdgeInsets.all(8.0),
                  shape: const CircleBorder(),
                  child: Icon(
                    Icons.delete,
                    color: Colors.red.withOpacity(0.7),
                  ),
                ),
              ),
          ],
        ),
      );

  Widget buildProfileImage(context) =>
      Stack(alignment: Alignment.center, clipBehavior: Clip.none, children: [
        PhysicalModel(
          color: Colors.black,
          elevation: 8.0,
          shape: BoxShape.circle,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: CircleAvatar(
            radius: (deviseSize.height * 0.15) / 2,
            backgroundColor: MyColors.colorDrawre.withOpacity(0.5),
            backgroundImage: handleShowImageProfile(),
          ),
        ),
        Positioned(
          bottom: 5,

          left: (deviseSize.width * 0.2),
          child: RawMaterialButton(
            onPressed: () => _cubit.imageProfileFile != null
                ? _cubit.deleteImage(EnumSelectImage.IMGPRO.name)
                : alertDialogImagePicker(context,
                    imageType: EnumSelectImage.IMGPRO.name),
            elevation: 0.0,
            fillColor: MyColors.colorDrawre.withOpacity(0.7),
            padding: const EdgeInsets.all(8.0),
            shape: const CircleBorder(),
            child: _cubit.imageProfileFile != null
                ? Icon(
                    Icons.delete,
                    color: Colors.red.withOpacity(0.7),
                  )
                : const Icon(
                    Icons.camera_alt,
                    color: Colors.white70,
                  ),
          ),
        ),
      ]);

  handleShowCoverImage() {
    if (_cubit.coverImageFile != null) {
      return Image.file(
        _cubit.coverImageFile!,
        fit: BoxFit.cover,
        height: deviseSize.height * 0.2,
        width: deviseSize.width,
      );
    } else if (_cubit.model.imageCover != null) {
      return CachedNetworkImage(
        imageUrl: _cubit.model.imageCover!,
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
    } else if (_cubit.model.image != null) {
      return CachedNetworkImageProvider(_cubit.model.image!);
    } else {
      return Container();
    }
  }

  EditProfileFun(start, stop, state) {}
}
