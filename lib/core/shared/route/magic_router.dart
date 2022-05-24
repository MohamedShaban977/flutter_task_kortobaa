import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Route<dynamic>? onGenerateRoute(RouteSettings settings) => null;

class MagicRouter {
  static BuildContext? currentContext = navigatorKey.currentContext;

  static Route<dynamic> _materialPageRoute(page) =>
      MaterialPageRoute(builder: (_) => page);

  /// Route with Animation
  // static Route<dynamic> _materialPageRoute(page) =>
  //     RouteAnimation(page: page);

  static navigateTo(Widget page) =>
      navigatorKey.currentState!.push(_materialPageRoute(page));

  static navigateReplacementTo(Widget page) =>
      navigatorKey.currentState!.pushReplacement(_materialPageRoute(page));

  static navigateAndPopAll(Widget page) =>
      navigatorKey.currentState!.pushAndRemoveUntil(
        _materialPageRoute(page),
        (_) => false,
      );

  static navigateAndPopUntilFirstPage(Widget page) => navigatorKey.currentState!
      .pushAndRemoveUntil(_materialPageRoute(page), (route) => route.isFirst);

  static pop([Object? result]) => navigatorKey.currentState!.pop(result);
}
