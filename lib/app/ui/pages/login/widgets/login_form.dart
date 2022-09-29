// ignore_for_file: use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tesis_1/app/classes/language.dart';
import 'package:tesis_1/app/classes/language_constants.dart';
import 'package:tesis_1/app/my_app.dart';
import 'package:tesis_1/app/ui/pages/login/login_page.dart';
import '../../../../utils/email_validator.dart';
import '../../../global_widgets/custom_input_field.dart';
import '../../../global_widgets/rounded_button.dart';
import '../../../routes/routes.dart';
import '../utils/send_login_form.dart';

class LoginForm extends StatelessWidget {
  LoginForm({
    Key? key,
  }) : super(key: key);
  final _controller = loginProvider.read;
  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.isDarkMode;
    final padding = context.mediaQueryPadding;
    final height = context.height - padding.top - padding.bottom;

    return ListView(
      children: [
        SizedBox(
          height: height,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _controller.formkey,
                child: Align(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 360,
                    ),
                    child: Column(
                      mainAxisAlignment: context.isTablet
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.end,
                      children: [
                        AppBar(
                          actions: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton<Language>(
                                underline: const SizedBox(),
                                icon: Icon(
                                  Icons.language,
                                  color: isDarkMode ? Colors.red : Colors.blue,
                                ),
                                onChanged: (Language? language) async {
                                  if (language != null) {
                                    Locale _locale =
                                        await setLocale(language.languageCode);
                                    MyApp.setLocale(context, _locale);
                                  }
                                },
                                items: Language.languageList()
                                    .map<DropdownMenuItem<Language>>(
                                      (e) => DropdownMenuItem<Language>(
                                        value: e,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Text(
                                              e.flag,
                                              style:
                                                  const TextStyle(fontSize: 30),
                                            ),
                                            Text(e.name)
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                        AspectRatio(
                          aspectRatio: 7 / 4,
                          child: SvgPicture.asset(
                            'assets/images/${isDarkMode ? 'dark' : 'light'}/Graphic_Welcome.svg',
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomInputField(
                          label: translation(context).simpleText5,
                          onChanged: _controller.onEmailChanged,
                          inputType: TextInputType.emailAddress,
                          validator: (text) {
                            if (isValidEmail(text!)) {
                              return null;
                            }
                            return translation(context).simpleText6;
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomInputField(
                          label: translation(context).simpleText8,
                          onChanged: _controller.onPasswordChanged,
                          isPassword: true,
                          validator: (text) {
                            if (text!.trim().length >= 6) {
                              return null;
                            }
                            return translation(context).simpleText7;
                          },
                        ),
                        const SizedBox(height: 22),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundedButton(
                              text: translation(context).simpleText,
                              onPressed: () => sendLoginForm(context),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () =>
                              router.pushNamed(Routes.RESET_PASSWORD),
                          child: Text(
                            translation(context).simpleText2,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(translation(context).simpleText3),
                            TextButton(
                              onPressed: () => router.pushNamed(
                                Routes.REGISTER,
                              ),
                              child: Text(
                                translation(context).simpleText4,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        if (!context.isTablet) const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
