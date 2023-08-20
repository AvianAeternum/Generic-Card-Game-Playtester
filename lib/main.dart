import 'package:card/app.dart';
import 'package:card/feature/login/service/auth_service.dart';
import 'package:card/feature/user/service/user_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:serviced/serviced.dart';

void main() {
  init().then((value) => runApp(const CardApp()));
}

Future<void> init() async {
  await Firebase.initializeApp();
  services().register<UserService>(() => UserService());
  services().register<AuthService>(() => AuthService());

  await services().waitForStartup();
}
