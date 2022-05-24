import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_kortobaa/core/helper/local/cache_helper.dart';
import 'package:flutter_task_kortobaa/core/utils/constants.dart';
import 'package:flutter_task_kortobaa/core/utils/style.dart';
import 'package:flutter_task_kortobaa/services/cubit/app_cubit/app_cubit.dart';
import 'package:flutter_task_kortobaa/view/authentication/login/login_view.dart';
import 'package:flutter_task_kortobaa/view/layout_app/layout_app.dart';

import '../../core/shared/route/magic_router.dart';

class SplashView extends StatefulWidget {
  final String? uId;

  const SplashView({Key? key, this.uId}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late String? uId2 ;

  Future<void> getCategories() async {
    uId2 = CacheHelper.getData(key: Shared_Uid);
    if (uId2 == null) {
      Timer(Duration.zero, () => MagicRouter.navigateAndPopAll(LoginView()));
    } else {
      await AppCubit.get(context).getPost();
      Timer(Duration.zero,
          () => MagicRouter.navigateAndPopAll(const LayoutApp()));
    }
  }

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: loading(context),
          ),
        );
      },
    );
  }
}
