import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuththentication {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  // login
  Future<User?> loginWithEmail({required String email,required String password}) async{
    try {
      final UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      rethrow;
    }
  }
  // Sign up
  Future<User?> signUpWithEmail({required String email, required String password}) async{
    try {
      final UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      rethrow;
    }
  }

  //signout
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

}