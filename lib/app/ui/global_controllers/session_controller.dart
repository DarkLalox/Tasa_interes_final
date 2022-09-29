import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:tesis_1/app/domain/repositories/account_repository.dart';
import 'package:tesis_1/app/domain/repositories/authentication_repository.dart';
import 'package:tesis_1/app/domain/repositories/email_repository.dart';

class SessionController extends SimpleNotifier {
  User? _user;
  User? get user => _user;

  final AuthenticationRepository _auth = Get.find();

  final AccountRepository _account = Get.find();

  final EmailRepository _email = Get.find();

  void setUser(User user) {
    _user = user;
    notify();
  }

  Future<User?> updateDisplayName(String value) async {
    final user = await _account.updateDisplayName(value);
    if (user != null) {
      _user = user;
      notify();
    }
    return user;
  }

  Future<User?> updateEmail(String value) async {
    final user = await _email.updateEmail(value);
    if (user != null) {
      _user = user;
      notify();
    }
    return user;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _user = null;
  }
}

final sessionProvider = SimpleProvider(
  (_) => SessionController(),
  autoDispose: false,
);
