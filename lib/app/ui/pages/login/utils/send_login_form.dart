// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:tesis_1/app/classes/language_constants.dart';
import 'package:tesis_1/app/ui/global_widgets/dialogs/dialogs.dart';
import 'package:tesis_1/app/ui/global_widgets/dialogs/progress_dialog.dart';
import 'package:tesis_1/app/ui/routes/routes.dart';
import '../../../../domain/responses/sign_in_response.dart';
import '../login_page.dart' show loginProvider;

Future<void> sendLoginForm(BuildContext context) async {
  final controller = loginProvider.read;
  final isValidForm = controller.formkey.currentState!.validate();
  if (isValidForm) {
    ProgressDialog.show(context);
    final response = await controller.submit();
    router.pop();
    if (response.error != null) {
      String errorMessage = "";

      switch (response.error) {
        case SignInError.networkRequestFailed:
          // ignore: use_build_context_synchronously
          errorMessage = translation(context).simpleText9;
          break;
        case SignInError.userDisabled:
          errorMessage = translation(context).simpleText10;
          break;
        case SignInError.userNotFound:
          errorMessage = translation(context).simpleText11;
          break;
        case SignInError.wrongPassword:
          errorMessage = translation(context).simpleText12;
          break;
        case SignInError.tooManyRequests:
          errorMessage = translation(context).simpleText13;
          break;
        case SignInError.unknown:
        default:
          errorMessage = translation(context).simpleText14;
          break;
      }
      Dialogs.alert(
        context,
        title: "ERROR",
        content: errorMessage,
      );
    } else {
      router.pushReplacementNamed(
        Routes.HOME,
      );
    }
  } else {
    Dialogs.alert(
      context,
      title: "ERROR",
      content: translation(context).simpleText15,
    );
  }
}
