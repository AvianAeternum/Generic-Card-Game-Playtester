import 'package:card/feature/login/service/auth_service.dart';
import 'package:card/feature/user/service/user_service.dart';
import 'package:card/sugar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serviced/serviced.dart';

String? splashRouteTo;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 25), () {
      if (svc<AuthService>().isSignedIn()) {
        svc<UserService>().bind(svc<UserService>().uid()).then((value) {
          Navigator.pushNamedAndRemoveUntil(ctx(), "/", (route) => false);

          if ((splashRouteTo ?? "/") != "/") {
            Get.toNamed(splashRouteTo ?? "/");
          }
        });
      } else {
        Navigator.pushNamedAndRemoveUntil(ctx(), "/login", (route) => false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
            child: SizedBox(
      width: 100,
      height: 100,
      child: CircularProgressIndicator(),
    )));
  }
}
