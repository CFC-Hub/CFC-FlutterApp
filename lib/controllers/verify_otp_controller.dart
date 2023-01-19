import 'package:cfc/services/cfc_api_client.dart';
import 'package:cfc/utils/cfc_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyOtpController extends GetxController {
  final CFCApiClient _apiClient = CFCApiClient();
  RxBool isLoading = false.obs;
  RxBool isOTPVerified = false.obs;
  final TextEditingController otpController = TextEditingController();

  Future<void> verifyOTP({required String emailAddress}) async {
    if (otpController.text.trim().length == 6) {
      isLoading.value = true;
      try {
        var responseBody = await _apiClient.verifyOTP(emailId: emailAddress, otp: otpController.text);
        isLoading.value = false;
        if (responseBody['message'] == 'OTP Verified') {
          isOTPVerified.value = true;
        } else {
          CFCHelper.showError(
              message: 'Incorrect OTP !!. Please enter the otp which you have received on $emailAddress');
        }
      } catch (error, stack) {
        isLoading.value = false;
        CFCHelper.showError(message: 'Failed to verify OTP.');
        debugPrintStack(stackTrace: stack, label: 'Error: $error');
      }
    } else {
      CFCHelper.showError(message: 'Enter valid OTP.');
    }
  }
}
