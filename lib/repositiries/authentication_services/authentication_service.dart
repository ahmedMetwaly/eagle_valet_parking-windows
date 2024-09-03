import 'package:firebase_auth/firebase_auth.dart';

import '../../generated/l10n.dart';
import '../../models/employer_model.dart';

class FirebaseAuthService {
  static userState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        ////print'User is currently signed out!');
      } else {
        ////print'User is signed in!\nemial:${user.email}');
      }
    });
  }

  /* static Future signUp(
      {required String emailAddress, required String password}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return UserModel(
          uid: credential.user?.uid ?? "0",
          name: credential.user?.displayName ?? "",
          email: credential.user?.email ?? "",
          imageUrl: credential.user?.photoURL ?? "",
          password: "");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return S.current.passErrorSignUp;
        // ////print'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return S.current.emailErrorSignUp;
        //////print'The account already exists for that email.');
      } else {
        return S.current.connectionError;
      }
    } catch (e) {
      return e.toString();
    }
  }
 */
  static Future signIn(
      {required String emailAddress, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return EmployerModel(
          uid: credential.user?.uid ?? "0",
          name: credential.user?.displayName ?? "",
          email: credential.user?.email ?? "",
          imageUrl: credential.user?.photoURL ?? "",
          password: '',
          parkingId: '');
    } on FirebaseAuthException catch (e) {
      //print"login exception : ${e.code}");
      if (e.code == "invalid-credential") {
        return S.current.loginError;
      }
      if (e.code == 'user-not-found') {
        return S.current.userNotFound;
      } else if (e.code == 'wrong-password') {
        return S.current.wrongPass;
      } else {
        return 
            S.current.unknown_error;
      }
    } catch (e) {
      return e;
    }
  }

  static Future logOut() async {
    await FirebaseAuth.instance.signOut();
    //  await GoogleSignIn().signOut();
  }

  static Future forgotPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-credential") {
        return S.current.loginError;
      }
      if (e.code == 'user-not-found') {
        return S.current.userNotFound;
      } else {
        return S.current.connectionError;
      }
    }
  }

  static Future sendEmailVerfication() async {
    try {
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();
      return true;
    } on FirebaseAuthException catch (e) {
      ////print"error from email verfication");
      if (e.code == "invalid-credential") {
        return S.current.loginError;
      }
      if (e.code == 'user-not-found') {
        return S.current.userNotFound;
      } else if (e.code == 'wrong-password') {
        return S.current.wrongPass;
      } else {
        return S.current.connectionError;
      }
      // return e.toString();
    }
  }
}
