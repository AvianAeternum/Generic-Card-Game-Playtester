import 'package:card/feature/login/bloc/login.dart';
import 'package:card/sugar.dart';
import 'package:card/util/generated/assets.gen.dart';
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
                child: Assets.google.svg(width: 32, height: 32),
              ),
              const Text("Sign in with Google",
                  style: TextStyle(color: Colors.white, fontSize: 18))
            ],
          ),
        ),
      );
}
