import 'package:firebase_auth/firebase_auth.dart';

abstract class EmailRepository {
  Future<User?> updateEmail(String value);
}
