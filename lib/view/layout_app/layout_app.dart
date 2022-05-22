import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_kortobaa/core/shared/route/magic_router.dart';
import 'package:flutter_task_kortobaa/core/utils/colors.dart';
import 'package:flutter_task_kortobaa/core/utils/style.dart';
import 'package:flutter_task_kortobaa/services/cubit/app_cubit/app_cubit.dart';
import 'package:flutter_task_kortobaa/view/edit_profile/edit_profile.dart';
import 'package:flutter_task_kortobaa/widget/custom_buttons.dart';
import 'package:flutter_task_kortobaa/widget/toast_and_snackbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'custom_drawer.dart';

class LayoutApp extends StatefulWidget {
  LayoutApp({Key? key}) : super(key: key);

  @override
  State<LayoutApp> createState() => _LayoutAppState();
}

class _LayoutAppState extends State<LayoutApp>
    with SingleTickerProviderStateMixin {
  late Size deviceSize;

  late AppCubit _cubit;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        _cubit = AppCubit.get(context);
        return ConditionalBuilder(
          condition: state is! GetUserLoadingState,
          fallback: (context) => Scaffold(
            appBar: buildAppBar(),
            body: Center(
              child: loading(context),
            ),
          ),
          builder: (context) => Scaffold(
            appBar: buildAppBar(),
            drawer: CustomDrawer(
              cubit: _cubit,
              tabController: _tabController,
            ),
            body: Column(
              children: <Widget>[
                // buildCardCheckEmailIsVerified(),
                buildTabBarView(),
              ],
            ),
          ),
        );
      },
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text('Home'.tr()),
      bottom: TabBar(
        controller: _tabController,
        tabs: [
          Tab(text: 'Home'.tr()),
          Tab(text: 'MyAccount'.tr()),
        ],
        indicatorColor: Colors.white,
        labelColor: Colors.white,
      ),
    );
  }

  Expanded buildTabBarView() {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: [
          /// HomeView tab bar view widget
          const HomeView(),

          /// MyAccountView tab bar view widget
          MyAccountView(),
        ],
      ),
    );
  }

  StatelessWidget buildCardCheckEmailIsVerified() {
    if (!FirebaseAuth.instance.currentUser!.emailVerified) {
      return Card(
        color: MyColors.colorPrimary2.withOpacity(0.2),
        elevation: 0.0,
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.amber[700]),
              const SizedBox(width: 15.0),
              Expanded(child: Text('PleaseVerifyYourEmail'.tr())),
              CustomButtonArgonAnimation(
                  text: 'Send'.tr(),
                  width: 50,
                  height: 40,
                  color: MyColors.colorPrimary2,
                  onTap: (startLoading, stopLoading, stateBut) async {
                    startLoading();
                    await FirebaseAuth.instance.currentUser!
                        .sendEmailVerification()
                        .then((value) {
                      ToastAndSnackBar.toastSuccess(
                          message: 'CheckYourEmail'.tr());
                    }).catchError((error) {
                      print(error.toString());

                      ToastAndSnackBar.toastError(message: error.toString());
                    });
                    stopLoading();
                  })
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}

class HomeView extends StatelessWidget {
  const HomeView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(
              2,
              (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 10.0),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor:
                                      MyColors.colorDrawre.withOpacity(0.15),
                                  child: Icon(
                                    FontAwesomeIcons.solidUser,
                                    size: 20,
                                    color:
                                        MyColors.colorDrawre.withOpacity(0.4),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Column(
                                    children: [
                                      Icon(
                                        Icons.share_rounded,
                                        size: 20,
                                        color: MyColors.colorDrawre
                                            .withOpacity(0.6),
                                      ),
                                      Container(
                                          margin: const EdgeInsets.all(5.0),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5.0, vertical: 2.0),
                                          child: Text('',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption))
                                    ],
                                  ),
                                  const SizedBox(width: 20.0),
                                  Column(
                                    children: [
                                      Icon(
                                        Icons.bookmark,
                                        size: 20,
                                        color: MyColors.colorDrawre
                                            .withOpacity(0.6),
                                      ),
                                      Container(
                                          margin: const EdgeInsets.all(5.0),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5.0, vertical: 2.0),
                                          child: Text('',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption))
                                    ],
                                  ),
                                  const SizedBox(width: 20.0),
                                  Column(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.solidThumbsUp,
                                        size: 19,
                                        color: MyColors.colorDrawre
                                            .withOpacity(0.6),
                                      ),
                                      Container(
                                          decoration: BoxDecoration(
                                              color: MyColors.colorDrawre
                                                  .withOpacity(0.15),
                                              borderRadius:
                                                  BorderRadius.circular(2.0)),
                                          margin: const EdgeInsets.all(5.0),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 3.0),
                                          child: Text(
                                            '1000000',
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith(
                                                  color: MyColors.colorPrimary
                                                      .withOpacity(0.8),
                                                ),
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://images.pexels.com/photos/4318822/pexels-photo-4318822.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                              'هذا النص هو مثال لنص يمكن ان يستبدل فى نفس المساحه لقد تم توليد هذا النص من مولد النص ',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                      height: 1.5,
                                      color: MyColors.colorDrawre)),
                        ),
                      ],
                    ),
                  ))),
        ),
      ),
    );
  }

  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: MyColors.colorOrangeSecond,
      child: const Icon(Icons.add, color: Colors.white),
    );
  }
}

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
          imageUrl: _cubit.model.imageCover!,
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
          backgroundImage: CachedNetworkImageProvider(_cubit.model.image!,
              errorListener: () => CircleAvatar(
                    radius: (deviseSize.height * 0.15) / 2,
                    backgroundColor: MyColors.colorDrawre.withOpacity(0.5),
                  )),
        ),
      );

  Widget buildViewUserData(context) => Column(
        children: [
          const SizedBox(height: 30.0),
          Text('${_cubit.model.firstName} ${_cubit.model.lastName}',
              style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: MyColors.colorPrimary, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8.0),
          Text('${_cubit.model.email}',
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
              text: 'EditProfile'.tr(), iconData: Icons.edit, onPressed: () =>MagicRouter.navigateTo( EditProfile())),
          buildButton(context,
              text: 'Settings'.tr(),
              iconData: Icons.settings,
              onPressed: () {}),
          buildButton(context,
              text: 'Favorites'.tr(), iconData: Icons.star, onPressed: () {}),
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
