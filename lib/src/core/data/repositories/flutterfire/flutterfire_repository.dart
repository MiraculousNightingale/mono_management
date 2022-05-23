import 'package:firebase_auth/firebase_auth.dart';

abstract class FlutterFireRepository {
  User? getFirebaseUser();

  Future<void> signOut();
}
