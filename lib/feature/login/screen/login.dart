import 'package:card/feature/login/bloc/login.dart';
import 'package:card/feature/login/widget/login_content.dart';
import 'package:delayed_progress_indicator/delayed_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:snackbar/snackbar.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocConsumer<LoginBloc, LoginState>(
      builder: (context, state) =>
          state == LoginState.loading || state == LoginState.success
              ? const Scaffold(
                  body: Center(
                    child: DelayedProgressIndicator(
                        delay: Duration.zero,
                        child: CircularProgressIndicator()),
                  ),
                )
              : const Scaffold(
                  body: Align(
                    alignment: Alignment.center,
                    child: LoginContent(),
                  ),
                ),
      listener: (context, state) {
        if (state == LoginState.error) {
          snack("An error occurred while logging in. Please try again.");
        } else if (state == LoginState.success) {
          Get.offAndToNamed("/");
        }
      });
}
