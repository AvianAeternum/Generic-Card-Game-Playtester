import 'package:card/feature/login/widget/google_sign_in_button.dart';
import 'package:card/util/generated/assets.gen.dart';
import 'package:flutter/material.dart';

class LoginContent extends StatelessWidget {
  const LoginContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Assets.iconSvg.svg(width: 275, height: 275, color: Colors.grey),
          const GoogleSignInButton(),
        ],
      );
}
