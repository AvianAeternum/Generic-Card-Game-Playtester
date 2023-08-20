/*
 * Copyright (c) 2022-2023. MyGuide
 *
 * MyGuide is a closed source project developed by Arcane Arts.
 * Do not copy, share, distribute or otherwise allow this source file
 * to leave hardware approved by Arcane Arts unless otherwise
 * approved by Arcane Arts.
 */

import 'dart:math';

import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Image.asset(
      Assets.icon.path,
      width: min(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height) /
          3,
    ));
  }
}
