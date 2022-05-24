import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_kortobaa/view/layout_app/my_account/settings/Settings_view.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../core/shared/route/magic_router.dart';
import '../../../core/utils/colors.dart';
import '../../../services/cubit/app_cubit/app_cubit.dart';
import '../favorite/my_favorites.dart';
import 'edit_profile/edit_profile.dart';

// ignore: must_be_immutable
class MyAccountView extends StatelessWidget {
  MyAccountView({Key? key}) : super(key: key);

  late Size deviseSize;
  late AppCubit _cubit;

  @override
  Widget build(BuildContext context) {
    deviseSize = MediaQuery.of(context).size;
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        _cubit = AppCubit.get(context);

        return ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            buildTop(),
            buildViewUserData(context),
            const SizedBox(height: 40.0),
            buildRowButtons(context),
          ],
        );
      },
    );
  }

  Stack buildTop() => Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Container(
              margin: EdgeInsets.only(bottom: deviseSize.height * 0.15 / 2),
              child: buildCoverImage()),
          Positioned(
              top: (deviseSize.height * 0.25) - (deviseSize.height * 0.15) / 2,
              child: buildProfileImage()),
        ],
      );

  Container buildCoverImage() => Container(
        color: MyColors.colorDrawre.withOpacity(0.6),
        child: CachedNetworkImage(
          imageUrl: _cubit.userModel.imageCover!,
          fit: BoxFit.cover,
          height: deviseSize.height * 0.25,
          width: deviseSize.width,
        ),
      );

  PhysicalModel buildProfileImage() => PhysicalModel(
        color: Colors.black,
        elevation: 8.0,
        shape: BoxShape.circle,
        clipBehavior: Clip.antiAlias,
        child: CircleAvatar(
          radius: (deviseSize.height * 0.15) / 2,
          backgroundColor: MyColors.colorDrawre.withOpacity(0.5),
          backgroundImage: CachedNetworkImageProvider(_cubit.userModel.image!,
              errorListener: () => CircleAvatar(
                    radius: (deviseSize.height * 0.15) / 2,
                    backgroundColor: MyColors.colorDrawre.withOpacity(0.5),
                  )),
        ),
      );

  Widget buildViewUserData(context) => Column(
        children: [
          const SizedBox(height: 30.0),
          Text('${_cubit.userModel.firstName} ${_cubit.userModel.lastName}',
              style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: MyColors.colorPrimary, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8.0),
          Text('${_cubit.userModel.email}',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: MyColors.colorPrimary.withOpacity(0.6))),
        ],
      );

  Widget buildRowButtons(context) => Row(
        // alignment: WrapAlignment.center,
        // crossAxisAlignment: WrapCrossAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // spacing: 50.0,
        children: [
          buildButton(context,
              text: 'EditProfile'.tr(),
              iconData: Icons.edit,
              onPressed: () => MagicRouter.navigateTo(EditProfile())),
          buildButton(context,
              text: 'Settings'.tr(),
              iconData: Icons.settings,
              onPressed: () => MagicRouter.navigateTo(const SettingsView())),
          buildButton(context,
              text: 'Favorites'.tr(),
              iconData: Icons.star,
              onPressed: () => MagicRouter.navigateTo(FavoriteView())),
        ],
      );

  Widget buildButton(
    context, {
    required String text,
    required IconData iconData,
    required Function()? onPressed,
  }) =>
      Column(
        children: [
          RawMaterialButton(
            onPressed: onPressed,
            elevation: 0.0,
            fillColor: MyColors.colorOrangeSecond,
            padding: const EdgeInsets.all(15.0),
            shape: const CircleBorder(),
            child: Icon(
              iconData,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .subtitle2!
                .copyWith(color: MyColors.colorPrimary.withOpacity(0.7)),
          ),
        ],
      );
}
