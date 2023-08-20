import 'package:card/feature/home/screen/home.dart';
import 'package:card/feature/login/screen/login.dart';
import 'package:card/feature/login/screen/splash.dart';
import 'package:card/feature/login/service/auth_service.dart';
import 'package:card/feature/user/service/user_service.dart';
import 'package:card/sugar.dart';
import 'package:fast_log/fast_log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serviced/serviced.dart';

class CardApp extends StatefulWidget {
  const CardApp({super.key});

  @override
  State<CardApp> createState() => _CardAppState();
}

class _CardAppState extends State<CardApp> {
  @override
  void initState() {
    tempContext = context;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        title: "Generic App",
        initialRoute: "/splash",
        getPages: [
          GetPage(
              name: "/",
              page: () => const HomeScreen(),
              middlewares: middlewares),
          GetPage(
              name: "/login",
              page: () => const LoginScreen(),
              middlewares: middlewares),
          GetPage(
              name: "/splash",
              page: () => const SplashScreen(),
              middlewares: middlewares),
        ],
      );
}

bool fts = false;

final List<GetMiddleware> middlewares = [Middleware()];

class Middleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    if (route == "/splash" || route == "/login" || route == "/register") {
      return null;
    }

    if (!svc<AuthService>().isSignedIn() || !svc<UserService>().bound && !fts) {
      warn("Navigating to ${route ?? "?"} before splash!");
      splashRouteTo = route ?? "/";
      return const RouteSettings(name: "/splash");
    }

    return null;
  }
}
