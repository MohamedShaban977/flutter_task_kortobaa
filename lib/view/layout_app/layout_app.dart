import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_kortobaa/core/utils/colors.dart';
import 'package:flutter_task_kortobaa/core/utils/style.dart';
import 'package:flutter_task_kortobaa/services/cubit/app_cubit/app_cubit.dart';
import 'package:flutter_task_kortobaa/widget/custom_buttons.dart';
import 'package:flutter_task_kortobaa/widget/toast_and_snackbar.dart';
import 'package:localize_and_translate/localize_and_translate.dart';


import '../../widget/custom_drawer.dart';
import 'home/home_view.dart';
import 'my_account/my_account.dart';

class LayoutApp extends StatefulWidget {
  const LayoutApp({Key? key}) : super(key: key);

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
      listener: (context, state) {},
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
          builder: (context) => WillPopScope(
           onWillPop: ()async{
             if (_tabController.index != 0) {
               _tabController.index = 0;
               return false;
             }
             else {
               return true;
             }
           },
            child: Scaffold(
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
          ),
        );
      },
    );
  }

  AppBar buildAppBar() => AppBar(
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

  Expanded buildTabBarView() => Expanded(
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
