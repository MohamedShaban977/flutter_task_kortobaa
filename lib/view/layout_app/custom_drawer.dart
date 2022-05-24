import 'package:flutter/material.dart';
import 'package:flutter_task_kortobaa/core/shared/route/magic_router.dart';
import 'package:flutter_task_kortobaa/view/saved/saved_view.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../core/utils/colors.dart';
import '../../services/cubit/app_cubit/app_cubit.dart';

// ignore: must_be_immutable
class CustomDrawer extends StatelessWidget {
  CustomDrawer({
    Key? key,
    required AppCubit cubit,
    required TabController tabController,
  })  : _cubit = cubit,
        _tabController = tabController,
        super(key: key);

  final AppCubit _cubit;
  final TabController _tabController;
  late Size _deviceSize;

  @override
  Widget build(BuildContext context) {
    _deviceSize = MediaQuery.of(context).size;
    return SizedBox(
      width: _deviceSize.width * 0.7,
      child: Drawer(
        child: ListView(
          children: [
            /// Drawer Header
            buildDrawerHeader(context),
            const SizedBox(height: 20.0),

            /// Home Button Drawer
            buildButtonDrawer(
              context,
              text: 'Home'.tr(),
              icon: Icons.home,
              onTap: () {
                _tabController.index = 0;
                Navigator.pop(context);
              },
            ),
            buildDivider(),

            /// MyAccount Button Drawer
            buildButtonDrawer(
              context,
              text: 'MyAccount'.tr(),
              icon: Icons.person,
              onTap: () {
                _tabController.index = 1;
                Navigator.pop(context);
              },
            ),
            buildDivider(),

            /// Saved Button Drawer
            buildButtonDrawer(
              context,
              text: 'Saved'.tr(),
              icon: Icons.bookmark,
              onTap: () {
                Navigator.pop(context);
                MagicRouter.navigateTo(SavedView());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButtonDrawer(
    context, {
    required String text,
    required IconData icon,
    Function()? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        onTap: onTap,
        highlightColor: MyColors.colorDrawre.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10.0),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Icon(
                icon,
                color: MyColors.colorDrawre,
              ),
              const SizedBox(width: 20.0),
              Text(
                text,
                // 'Home'.tr(),
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: MyColors.colorDrawre, fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container buildDrawerHeader(BuildContext context) {
    return Container(
      color: MyColors.colorDrawre,
      child: DrawerHeader(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const SizedBox(height: 20.0),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white38,
              backgroundImage: NetworkImage(_cubit.userModel.image!),
              child: _cubit.userModel.image == null
                  ? const Icon(
                      Icons.person,
                      color: Colors.white70,
                      size: 40,
                    )
                  : const SizedBox(),
            ),
            Flexible(
              child: Text(
                '${_cubit.userModel.firstName!} ${_cubit.userModel.lastName!}',
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Colors.white70,
                    height: 2.0,
                    fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Divider buildDivider() {
    return const Divider(
      height: 10,
      thickness: 1,
      endIndent: 40,
      indent: 40,
    );
  }
}
