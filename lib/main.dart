import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_kortobaa/core/helper/local/cache_helper.dart';
import 'package:flutter_task_kortobaa/core/helper/local/hive_helper.dart';
import 'package:flutter_task_kortobaa/core/shared/route/custom_route.dart';
import 'package:flutter_task_kortobaa/core/shared/route/magic_router.dart';
import 'package:flutter_task_kortobaa/core/utils/colors.dart';
import 'package:flutter_task_kortobaa/core/utils/constants.dart';
import 'package:flutter_task_kortobaa/services/cubit/app_cubit/app_cubit.dart';
import 'package:flutter_task_kortobaa/view/authentication/login/login_view.dart';
import 'package:flutter_task_kortobaa/view/layout_app/layout_app.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'core/shared/bloc_observer.dart';
import 'core/shared/translation/Translation.dart';
import 'core/utils/style.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: MyColors.colorStatusBar));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // await Hive.initFlutter();
  await HiveHelper.init();

  await CacheHelper.init();
  currentLang = CacheHelper.getData(key: CURRENT_LANG_KEY);
  uId = CacheHelper.getData(key: Shared_Uid);
  await TranslateLang.translatorInit();

  BlocOverrides.runZoned(
    () => runApp(LocalizedApp(
        child: MyApp(
      uId: uId,
    ))),
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final String? uId;

  const MyApp({Key? key, this.uId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..getUserData()
        ..getPost()
        ..getPostsSavedInHave()
        ..getPostsFavoritesInHave(),
      child: MaterialApp(
        title: 'Social Demo Task',

        theme: themeDataLight,
        darkTheme: themeDataDark,
        debugShowCheckedModeBanner: false,

        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
        localizationsDelegates: translator.delegates,
        supportedLocales: translator.locals(),
        locale: translator.activeLocale,

        navigatorKey: navigatorKey,
        onGenerateRoute: onGenerateRoute,
        home: uId == null ? LoginView() : LayoutApp(),

        // locale: ,
      ),
    );
  }
}
