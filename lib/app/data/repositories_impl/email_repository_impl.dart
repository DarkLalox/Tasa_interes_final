import 'package:firebase_auth/firebase_auth.dart';
import 'package:tesis_1/app/domain/repositories/email_repository.dart';

class EmailRepositoryImpl implements EmailRepository {
  final FirebaseAuth _auth;

  EmailRepositoryImpl(this._auth);

  @override
  Future<User?> updateEmail(String value) async {
    try {
      final user = _auth.currentUser;
      assert(user != null);
      await user!.updateEmail(value);
      user.reload();
      return _auth.currentUser;
    } catch (e) {
      return null;
    }
  }
}
