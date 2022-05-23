import 'package:firebase_auth/firebase_auth.dart';
import 'package:mono_management/src/core/data/repositories/flutterfire/flutterfire_repository.dart';

class FlutterFireRepositoryImpl implements FlutterFireRepository {
  FlutterFireRepositoryImpl();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  User? getFirebaseUser() => firebaseAuth.currentUser;

  @override
  Future<void> signOut() => firebaseAuth.signOut();
}
