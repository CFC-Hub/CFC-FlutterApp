import 'package:cfc/screens/cfc_screens.dart';
import 'package:cfc/services/cfc_api_client.dart';
import 'package:cfc/services/cfc_firebase_firestore.dart';
import 'package:cfc/utils/cfc_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final CFCApiClient _apiClient = CFCApiClient();
  final signUpFormKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  final TextEditingController emailAddressController = TextEditingController();

  Future<void> sendOTP() async {
    if (signUpFormKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      isLoading.value = true;
      try {
        var docs =
            await CFCFirebaseFireStore().getPopProfileUsingEmail(emailAddress: emailAddressController.text.trim());
        if (docs.isEmpty) {
          var responseBody = await _apiClient.sendOTP(emailId: emailAddressController.text.trim());
          isLoading.value = false;
          if (responseBody['message'] == 'Mail send') {
            Get.to(() => VerifyOTP(emailAddress: emailAddressController.text.trim()));
          } else {
            CFCHelper.showError(message: 'Failed to send OTP.');
          }
        } else {
          isLoading.value = false;
          CFCHelper.showError(
            title: 'Email Already Exists',
            message: 'The email address is already in use by another account. '
                'Please try again with another email address.',
            enableBtn: true,
          );
        }
      } catch (error, stack) {
        isLoading.value = false;
        CFCHelper.showError(message: 'Failed to send OTP.');
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
