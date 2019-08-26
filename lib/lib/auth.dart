import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  FirebaseAuth _auth;
  FirebaseUser _user;

  AuthCredential credential;
  AuthException error;
  String verificationId;

  Auth() {
    _auth = FirebaseAuth.instance;
    _auth.setLanguageCode('en');
  }

  currentUser() {
    return _user;
  }

  Future<void> authenticate (String phoneNumber) async {
    final PhoneVerificationCompleted _verificationComplete = (AuthCredential credential) async {
      this.credential = credential;
      this._user = (await _auth.signInWithCredential(credential)).user;
    };

    final PhoneVerificationFailed _verificationFailed = (AuthException err) {
      this.error = err;
    };

    final PhoneCodeSent _codeSent = (String verificationId, [int resendCode]) {
      this.verificationId = verificationId;
    };

    final PhoneCodeAutoRetrievalTimeout _autoRetrieve = (String verId) {
      this.verificationId = verId;
    };

    _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 5),
      verificationCompleted: _verificationComplete,
      verificationFailed: _verificationFailed,
      codeSent: _codeSent,
      codeAutoRetrievalTimeout: _autoRetrieve,
    );
  }
}