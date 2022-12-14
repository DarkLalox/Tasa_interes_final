import 'package:flutter/widgets.dart' show FormState, GlobalKey;
import 'package:flutter_meedu/meedu.dart';
import 'package:tesis_1/app/domain/repositories/authentication_repository.dart';
import 'package:tesis_1/app/domain/responses/sign_in_response.dart';
import 'package:tesis_1/app/ui/global_controllers/session_controller.dart';

class LoginController extends SimpleNotifier {
  final SessionController _sessionController;

  String _email = '', _password = '';
  final _authenticationRepository = Get.find<AuthenticationRepository>();

  final GlobalKey<FormState> formkey = GlobalKey();

  LoginController(this._sessionController);

  void onEmailChanged(String text) {
    _email = text;
  }

  void onPasswordChanged(String text) {
    _password = text;
  }

  Future<SignInResponse> submit() async {
    final response = await _authenticationRepository.signInWithEmailAndPassword(
      _email,
      _password,
    );
    if (response.error == null) {
      _sessionController.setUser(response.user!);
    }
    return response;
  }
}
