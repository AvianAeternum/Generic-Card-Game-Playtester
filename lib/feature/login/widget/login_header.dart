import 'dart:math';

import 'package:card/util/generated/assets.gen.dart';
import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Image.asset(
      Assets.iconPng.path,
      width: min(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height) /
          3,
    ));
  }
}
