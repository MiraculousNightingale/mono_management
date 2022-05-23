import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthRepository {
  User? getFirebaseUser();

  Future<void> signOut();

  Future<void> registerAuthStateListener();

  Future<UserCredential> createAccountWithEmailAndPassword(
      String email, String password);

  Future<UserCredential> loginWithEmailAndPassword(String email, String password);
}
