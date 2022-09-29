import 'package:firebase_auth/firebase_auth.dart';
import 'package:tesis_1/app/domain/inputs/sign_up.dart';
import 'package:tesis_1/app/domain/repositories/sign_up_repository.dart';
import 'package:tesis_1/app/domain/responses/sign_up_response.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  final FirebaseAuth _auth;

  SignUpRepositoryImpl(this._auth);
  @override
  Future<SignUpResponse> register(SignUpData data) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: data.email,
        password: data.password,
      );
      await userCredential.user!.updateDisplayName(
        "${data.name} ${data.namepyme}",
      );
      await _auth.currentUser!.reload();
      final user = _auth.currentUser;
      return SignUpResponse(null, user);
    } on FirebaseAuthException catch (e) {
      return SignUpResponse(parseStringToSignUpError(e.code), null);
    }
  }
}
