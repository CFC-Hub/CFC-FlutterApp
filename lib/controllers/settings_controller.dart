import 'package:cfc/services/cfc_firebase_auth.dart';
import 'package:cfc/utils/cfc_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  final CFCFirebaseAuth _cfcAuth = CFCFirebaseAuth();
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final changePasswordFormKey = GlobalKey<FormState>();

  RxBool isLoading = false.obs;

  Future<void> changePassword() async {
    if (!changePasswordFormKey.currentState!.validate()) {
      return;
    }
    FocusManager.instance.primaryFocus?.unfocus();
    try {
      isLoading.value = true;
      await _cfcAuth.changePassword(
          currentPassword: currentPasswordController.text, newPassword: newPasswordController.text);
      isLoading.value = false;
      currentPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();
      CFCHelper.showMessage(message: 'Password changed successfully.');
    } on FirebaseException catch (error) {
      isLoading.value = false;
      if (error.code == 'wrong-password') {
        CFCHelper.showError(message: 'The current password is invalid.');
      } else {
        CFCHelper.showError(message: error.message ?? error.code);
      }
    }
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
