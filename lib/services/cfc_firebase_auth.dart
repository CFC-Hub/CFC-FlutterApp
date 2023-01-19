import 'dart:async';

import 'package:cfc/services/cfc_firebase_instance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CFCFirebaseAuth {
  final CFCFirebaseInstance _firebaseService = Get.find<CFCFirebaseInstance>();
  late final FirebaseAuth _auth = _firebaseService.auth;

  Future<User?> signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  void signInWithPhoneNumber({required String phoneNumber, required StreamController streamController}) {
    _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException firebaseAuthException) {
          streamController.addError(firebaseAuthException);
          streamController.close();
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          streamController.add(verificationId);
          streamController.close();
        },
        codeAutoRetrievalTimeout: (String timeout) {});
  }

  Future<User?> verifyOtp({required String verificationId, required String otp}) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otp);
      UserCredential userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    } on FirebaseAuthException catch (_) {
      rethrow;
    }
  }

  Future<User?> createUserWithEmailAndPassword({required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  Future<void> changePassword({required String currentPassword, required String newPassword}) async {
    try {
      AuthCredential credential =
          EmailAuthProvider.credential(email: _auth.currentUser!.email!, password: currentPassword);
      await _auth.currentUser!.reauthenticateWithCredential(credential);
      await _auth.currentUser?.updatePassword(newPassword);
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  User? get getCurrentUser {
    return _auth.currentUser;
  }

  Future<String> getRefreshToken() async {
    final getRefreshToken = await _auth.currentUser!.getIdTokenResult(true);
    return getRefreshToken.token!;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
