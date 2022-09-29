// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, prefer_interpolation_to_compose_strings, sort_child_properties_last

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:tesis_1/app/classes/language_constants.dart';
import 'package:tesis_1/app/ui/global_controllers/session_controller.dart';
import 'package:tesis_1/app/ui/global_controllers/theme_controller.dart';
import 'package:tesis_1/app/ui/global_widgets/dialogs/dialogs.dart';
import 'package:tesis_1/app/ui/global_widgets/dialogs/progress_dialog.dart';
import 'package:tesis_1/app/ui/global_widgets/dialogs/show_input_dialog.dart';
import 'package:tesis_1/app/ui/pages/home/tabs/profile/widgets/label_button.dart';
import 'package:tesis_1/app/ui/routes/routes.dart';

class ProfileTab extends ConsumerWidget {
  const ProfileTab({Key? key}) : super(key: key);

  void _updateDisplayName(BuildContext context) async {
    final SessionController = sessionProvider.read;
    List<String> splilName = SessionController.user!.displayName!.split(" ");
    final value = await showInputDialog(
      context,
      initialValue: splilName.first,
    );
    if (value != null) {
      ProgressDialog.show(context);
      final val = value + " " + splilName.last;
      final user = await SessionController.updateDisplayName(val);
      Navigator.pop(context);
      if (user == null) {
        Dialogs.alert(
          context,
          title: "ERROR",
          content: translation(context).simpleText31,
        );
      }
    }
  }

  void _updateDisplayName2(BuildContext context) async {
    final SessionController = sessionProvider.read;
    List<String> splilName = SessionController.user!.displayName!.split(" ");
    final value = await showInputDialog(
      context,
      initialValue: splilName.last,
    );
    if (value != null) {
      ProgressDialog.show(context);
      final val = splilName.first + " " + value;
      final user = await SessionController.updateDisplayName(val);
      Navigator.pop(context);
      if (user == null) {
        Dialogs.alert(
          context,
          title: "ERROR",
          content: translation(context).simpleText31,
        );
      }
    }
  }

  void _updateEmail(BuildContext context) async {
    final SessionController = sessionProvider.read;
    final value = await showInputDialog(
      context,
      initialValue: SessionController.user!.email ?? "",
    );
    if (value != null) {
      ProgressDialog.show(context);
      final user = await SessionController.updateEmail(value);
      Navigator.pop(context);
      if (user == null) {
        Dialogs.alert(
          context,
          title: "ERROR",
          content: translation(context).simpleText31,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, ref) {
    final sessionController = ref.watch(sessionProvider);
    final isDark = context.isDarkMode;
    final user = sessionController.user!;
    final displayName = user.displayName ?? '';
    final letter = displayName.isNotEmpty ? displayName[0] : "";
    List<String> splilName = user.displayName!.split(" ");

    return ListView(
      children: [
        const SizedBox(height: 20),
        CircleAvatar(
          radius: 75,
          child: user.photoURL == null
              ? Text(
                  letter,
                  style: const TextStyle(fontSize: 80),
                )
              : null,
          backgroundImage:
              user.photoURL != null ? NetworkImage(user.photoURL!) : null,
        ),
        const SizedBox(height: 10),
        Center(
            child: Text(
          splilName.first,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        )),
        Center(child: Text(splilName.last)),
        Center(child: Text(user.email ?? '')),
        const SizedBox(height: 20),
        //const Text("Perfil"),
        LabelButton(
          label: translation(context).simpleText32,
          value: splilName.first,
          onPressed: () => _updateDisplayName(context),
        ),
        LabelButton(
          label: "PYME",
          value: splilName.last,
          onPressed: () => _updateDisplayName2(context),
        ),
        LabelButton(
            label: translation(context).simpleText5,
            value: user.email ?? '',
            onPressed: () => _updateEmail(context)),
        LabelButton(
          label: translation(context).simpleText33,
          value: user.emailVerified ? translation(context).simpleText34 : "NO",
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                translation(context).simpleText35,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              CupertinoSwitch(
                value: isDark,
                activeColor: isDark ? Colors.red : Colors.blue,
                onChanged: (_) {
                  themeProvider.read.toggle();
                },
              ),
            ],
          ),
        ),
        LabelButton(
          label: translation(context).simpleText36,
          value: "",
          onPressed: () async {
            await sessionProvider.read.signOut();
            router.pushNamedAndRemoveUntil(Routes.LOGIN);
          },
        ),
      ],
    );
  }
}
