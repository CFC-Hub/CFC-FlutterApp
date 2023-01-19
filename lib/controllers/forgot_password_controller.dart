import 'package:cfc/services/cfc_firebase_auth.dart';
import 'package:cfc/utils/cfc_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  final TextEditingController emailAddressController = TextEditingController();
  RxBool isLinkSent = false.obs;

  Future<void> sendOTP() async {
    if (formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      isLoading.value = true;
      try {
        await CFCFirebaseAuth().sendPasswordResetEmail(email: emailAddressController.text.trim());
        isLoading.value = false;
        isLinkSent.value = true;
      } on FirebaseException catch (error, stack) {
        isLoading.value = false;
        if (error.code == 'user-not-found') {
          CFCHelper.showError(
            title: 'Email Not Exists',
            message: 'The Email Address you have entered is not a valid CFC User. '
                'Please enter a valid Email Address.',
            enableBtn: true,
          );
        } else {
          CFCHelper.showError(message: 'Failed to send reset password mail.');
        }
        debugPrintStack(stackTrace: stack, label: 'Error: $error');
      }
    }
  }

  @override
  void onClose() {
    emailAddressController.dispose();
    super.onClose();
  }
}
