import 'package:flutter/material.dart';
import 'package:flutter_task_kortobaa/services/cubit/app_cubit/app_cubit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../core/utils/colors.dart';

class DialogSelectImage extends StatelessWidget {
  final Function onGalleryClicked, onCameraClicked;

  DialogSelectImage({
    required this.onGalleryClicked,
    required this.onCameraClicked,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('ChoosePictureFrom'.tr()),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: () {
              onGalleryClicked();
            },
            child: const CircleAvatar(
              radius: 30,
              backgroundColor: MyColors.colorOrange,
              child: Icon(
                Icons.image_rounded,
                color: Colors.white,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              onCameraClicked();
            },
            child: const CircleAvatar(
              radius: 30,
              backgroundColor: MyColors.colorOrange,
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void alertDialogImagePicker(context, {required String imageType}) {
  showDialog(
    context: context,
    builder: (context) => DialogSelectImage(
      onCameraClicked: () {
        AppCubit.get(context)
            .getImage(context, imageType: imageType, src: ImageSource.camera);
        Navigator.pop(context);
      },
      onGalleryClicked: () {
        AppCubit.get(context)
            .getImage(context, imageType: imageType, src: ImageSource.gallery);
        Navigator.pop(context);
      },
    ),
  );
}
