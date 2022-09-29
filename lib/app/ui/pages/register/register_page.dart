import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:tesis_1/app/classes/language_constants.dart';
import 'package:tesis_1/app/ui/global_controllers/session_controller.dart';
import 'package:tesis_1/app/ui/global_widgets/custom_input_field.dart';
import 'package:tesis_1/app/ui/global_widgets/rounded_button.dart';
import 'package:tesis_1/app/ui/pages/register/controller/register_controller.dart';
import 'package:tesis_1/app/ui/pages/register/controller/register_state.dart';
import 'package:tesis_1/app/ui/pages/register/utils/send_register_form.dart';
import 'package:tesis_1/app/utils/email_validator.dart';
import 'package:tesis_1/app/utils/name_validator.dart';

final registerProvider = StateProvider<RegisterController, RegisterState>(
  (_) => RegisterController(sessionProvider.read),
);

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      elevation: 0,
    );
    final padding = context.mediaQueryPadding;
    final height = context.height -
        padding.top -
        padding.bottom -
        appBar.preferredSize.height;
    return ProviderListener<RegisterController>(
      provider: registerProvider,
      builder: (_, controller) {
        return Scaffold(
          appBar: appBar,
          body: ListView(
            children: [
              SizedBox(
                height: height,
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.transparent,
                    padding: const EdgeInsets.all(15),
                    child: Align(
                      child: Form(
                        key: controller.formkey,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 360),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                translation(context).simpleText16,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 15),
                              CustomInputField(
                                label: translation(context).simpleText17,
                                onChanged: controller.onNameChanged,
                                validator: (text) {
                                  return isValidName(text!)
                                      ? null
                                      : translation(context).simpleText18;
                                },
                              ),
                              const SizedBox(height: 15),
                              CustomInputField(
                                label: translation(context).simpleText19,
                                onChanged: controller.onNamePymeChanged,
                                validator: (text) {
                                  return isValidName(text!)
                                      ? null
                                      : translation(context).simpleText20;
                                },
                              ),
                              const SizedBox(height: 15),
                              CustomInputField(
                                label: translation(context).simpleText5,
                                inputType: TextInputType.emailAddress,
                                onChanged: controller.onEmailChanged,
                                validator: (text) {
                                  return isValidEmail(text!)
                                      ? null
                                      : translation(context).simpleText6;
                                },
                              ),
                              const SizedBox(height: 15),
                              CustomInputField(
                                label: translation(context).simpleText8,
                                onChanged: controller.onPasswordChanged,
                                isPassword: true,
                                validator: (text) {
                                  if (text!.trim().length >= 6) {
                                    return null;
                                  }
                                  return translation(context).simpleText7;
                                },
                              ),
                              const SizedBox(height: 15),
                              Consumer(
                                builder: (_, ref, __) {
                                  ref.watch(
                                    registerProvider.select(
                                      (_) => _.password,
                                    ),
                                  );
                                  return CustomInputField(
                                    label: translation(context).simpleText21,
                                    onChanged: controller.onVPasswordChanged,
                                    isPassword: true,
                                    validator: (text) {
                                      if (controller.state.password != text) {
                                        return translation(context)
                                            .simpleText22;
                                      }
                                      if (text!.trim().length >= 6) {
                                        return null;
                                      }
                                      return translation(context).simpleText7;
                                    },
                                  );
                                },
                              ),
                              const SizedBox(height: 30),
                              RoundedButton(
                                text: (translation(context).simpleText23),
                                onPressed: () => sendRegisterForm(context),
                              ),
                              const SizedBox(height: 30),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
