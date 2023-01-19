import 'package:cfc/hive/cfc_hives.dart';
import 'package:cfc/models/cfc_models.dart';
import 'package:cfc/services/cfc_firebase_auth.dart';
import 'package:cfc/services/cfc_firebase_firestore.dart';
import 'package:cfc/utils/cfc_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatePasswordController extends GetxController {
  final CFCFirebaseAuth _cfcAuth = CFCFirebaseAuth();
  final createPasswordFormKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool isAccountCreated = false.obs;

  Future<void> createPassword({required String emailAddress}) async {
    if (createPasswordFormKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      if (passwordController.text != confirmPasswordController.text) {
        CFCHelper.showError(message: 'Password and Confirm Password are not matching.');
        return;
      }
      isLoading.value = true;
      try {
        User? user =
            await _cfcAuth.createUserWithEmailAndPassword(email: emailAddress, password: passwordController.text);
        if (user != null) {
          createProfile(user);
        } else {
          isLoading.value = false;
          CFCHelper.showError(message: 'Failed to create password.');
        }
      } on FirebaseException catch (error) {
        isLoading.value = false;
        if (error.code == 'email-already-in-use') {
          CFCHelper.showError(message: 'The email address is already in use by another account.');
        } else {
          CFCHelper.showError(message: error.message ?? error.code);
        }
      } catch (error, stack) {
        isLoading.value = false;
        CFCHelper.showError(message: 'Failed to create password.');
        debugPrintStack(stackTrace: stack, label: 'Error: $error');
      }
    }
  }

  Future<void> createProfile(User user) async {
    DeviceInfo deviceInfo = await CFCHelper.getDeviceInfo();
    PopProfile popProfile = PopProfile(
      createdOn: DateTime.now().millisecondsSinceEpoch,
      createdBy: user.uid,
      firstName: '',
      lastName: '',
      emailAddress: user.email ?? '',
      isPopProfileCreated: false,
      organisation: '',
      questions: Questions(
        isFoodProducer: false,
        inLogistics: false,
        inPublicAdministration: false,
        inAgriFoodResearch: false,
        inTechnologyAgriFood: false,
      ),
      tagline: '',
      aboutCfcProject: '',
      deviceInfo: deviceInfo,
      isVerifiedOnChain: false,
      metamaskAccountAddress: '',
      modifiedOn: DateTime.now().millisecondsSinceEpoch,
    );
    try {
      await CFCFirebaseFireStore().setPopProfile(popProfile: popProfile);
      isLoading.value = false;
      isAccountCreated.value = true;
      await CFCPopProfileHive().setPopProfile(popProfile); // Store the pop profile details in the hive.
    } catch (error, stack) {
      isLoading.value = false;
      CFCHelper.showError(message: 'Failed to create password.');
      debugPrintStack(stackTrace: stack, label: error.toString());
    }
  }
}
