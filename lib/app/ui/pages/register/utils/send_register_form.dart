// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:tesis_1/app/classes/language_constants.dart';
import 'package:tesis_1/app/domain/responses/sign_up_response.dart';
import 'package:tesis_1/app/ui/global_widgets/dialogs/dialogs.dart';
import 'package:tesis_1/app/ui/global_widgets/dialogs/progress_dialog.dart';
import 'package:tesis_1/app/ui/routes/routes.dart';
import '../register_page.dart' show registerProvider;
import 'package:flutter_meedu/ui.dart';

Future<void> sendRegisterForm(BuildContext context) async {
  final controller = registerProvider.read;
  final isValidForm = controller.formkey.currentState!.validate();

  if (isValidForm) {
    ProgressDialog.show(context);
    final response = await controller.submit();
    router.pop();
    if (response.error != null) {
      late String content;
      switch (response.error) {
        case SignUpError.emailAlreadyInUse:
          content = translation(context).simpleText24;
          break;
        case SignUpError.weakPassword:
          content = translation(context).simpleText25;
          break;
        case SignUpError.tooManyRequests:
          content = translation(context).simpleText13;
          break;
        case SignUpError.unknown:
        default:
          content = translation(context).simpleText14;
          break;
      }
      Dialogs.alert(
        context,
        title: "ERROR",
        content: content,
      );
    } else {
      router.pushNamedAndRemoveUntil(
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
