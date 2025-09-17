import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> loginSignup(String email, String password, bool isLogin) async {
    final cred = isLogin
        ? await _auth.signInWithEmailAndPassword(
            email: email,
            password: password,
          )
        : await _auth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
    return cred.user;
  }

  Stream<User?> get userChanges => _auth.authStateChanges();

  Future<void> signOut() => _auth.signOut();
}
