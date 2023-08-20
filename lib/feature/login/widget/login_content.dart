/*
 * Copyright (c) 2023. MyGuide
 *
 * MyGuide is a closed source project developed by Arcane Arts.
 * Do not copy, share, distribute or otherwise allow this source file
 * to leave hardware approved by Arcane Arts unless otherwise
 * approved by Arcane Arts.
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myguide/features/login/widget/apple_sign_in_button.dart';
import 'package:myguide/features/login/widget/google_sign_in_button.dart';
import 'package:myguide/shared/util/sugar.dart';
import 'package:myguide/shared/widget/components/txt.dart';
import 'package:myguide/util/generated/assets.gen.dart';
import 'package:padded/padded.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginContent extends StatelessWidget {
  const LoginContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Assets.icon.svg(width: 275, height: 275, color: Colors.grey),
          if (shouldSuggestElection())
            PaddingAll(
                padding: 14,
                child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(7)),
                    child: ListTile(
                      leading: Icon(webPlatformIcon(), size: 52),
                      onTap: () => launchUrl(Uri.parse(webPlatformUrlFor())),
                      title: TXT(
                        "MyGuide for ${webPlatformName()}",
                        style: const TextStyle(fontSize: 24),
                      ),
                      subtitle: TXT(
                          "Get MyGuide for ${webPlatformName()} instead for a far superior experience!"),
                    ))),
          const GoogleSignInButton(),
          PaddingTop(padding: 14, child: Container()),
          Visibility(
            visible: GetPlatform.isIOS,
            child: const AppleSignInButton(),
          ),
        ],
      );
}
