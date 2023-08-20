/*
 * Copyright (c) 2023. MyGuide
 *
 * MyGuide is a closed source project developed by Arcane Arts.
 * Do not copy, share, distribute or otherwise allow this source file
 * to leave hardware approved by Arcane Arts unless otherwise
 * approved by Arcane Arts.
 */

import 'package:card/feature/login/bloc/login.dart';
import 'package:card/sugar.dart';
import 'package:flutter/material.dart';
import 'package:padded/padded.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => blocEvent<LoginBloc>(LoginGoogleEvent()),
        child: PaddingAll(
          padding: 14,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              PaddingRight(
                padding: 14,
                child: Assets.logo.google.svg(width: 32, height: 32),
              ),
              const TXT("Sign in with Google",
                  style: TextStyle(color: Colors.white, fontSize: 18))
            ],
          ),
        ),
      ).blur(
          blur: 100,
          frostColor: Colors.black,
          borderRadius: BorderRadius.circular(24));
}
