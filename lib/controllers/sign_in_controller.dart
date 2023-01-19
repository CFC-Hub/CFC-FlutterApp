import 'package:cfc/hive/cfc_hives.dart';
import 'package:cfc/models/cfc_models.dart';
import 'package:cfc/screens/cfc_screens.dart';
import 'package:cfc/services/cfc_firebase_auth.dart';
import 'package:cfc/services/cfc_firebase_firestore.dart';
import 'package:cfc/utils/cfc_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final CFCFirebaseAuth _cfcAuth = CFCFirebaseAuth();
  final signInFormKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;

  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signIn() async {
    if (signInFormKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      isLoading.value = true;
      try {
        User? user = await _cfcAuth.signInWithEmailAndPassword(
            email: emailAddressController.text, password: passwordController.text);
        if (user != null) {
          getPopProfile(user: user, emailAddress: emailAddressController.text);
        } else {
          isLoading.value = false;
          CFCHelper.showError(message: 'Failed to sign in.');
        }
      } on FirebaseException catch (error) {
        isLoading.value = false;
        if (error.code == 'user-not-found') {
          CFCHelper.showError(
            title: 'User Not Found.',
            message: 'There is no user record corresponding to this email address. '
                'The user may have been deleted.',
            enableBtn: true,
          );
        } else if (error.code == 'wrong-password') {
          CFCHelper.showError(
            title: 'Invalid Credentials.',
            message: 'Password did not match. '
                'Please enter a valid password.',
            enableBtn: true,
          );
        } else if (error.code == 'user-disabled') {
          CFCHelper.showError(
            title: 'Account Disabled.',
            message: 'The user account has been disabled by an administrator.',
            enableBtn: true,
          );
        } else {
          CFCHelper.showError(message: error.message ?? error.code);
        }
      } catch (error, stack) {
        isLoading.value = false;
        CFCHelper.showError(message: 'Failed to sign in.');
        debugPrintStack(stackTrace: stack, label: 'Error: $error');
      }
    }
  }

  Future<void> getPopProfile({required User user, required String emailAddress}) async {
    try {
      var docs = await CFCFirebaseFireStore().getPopProfileUsingEmail(emailAddress: emailAddress);
      if (docs.isNotEmpty && docs.first.data() != null) {
        PopProfile popProfile = PopProfile.fromMap(docs.first.data()! as Map<String, dynamic>);
        await CFCPopProfileHive().setPopProfile(popProfile); // Store the pop profile details in the hive.
        isLoading.value = false;
        Get.offAll(() => const Dashboard());
      } else {
        // TODO: check here
        isLoading.value = false;
        CFCHelper.showError(message: 'The user profile could not be found.');
      }
    } catch (error, stack) {
      isLoading.value = false;
      CFCHelper.showError(message: 'Failed to sign in.');
      debugPrintStack(stackTrace: stack, label: 'Error: $error');
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
      await CFCPopProfileHive().setPopProfile(popProfile); // Store the pop profile details in the hive.
      isLoading.value = false;
      Get.offAll(() => const Dashboard());
    } catch (error, stack) {
      isLoading.value = false;
      CFCHelper.showError(message: 'Failed to sign in.');
      debugPrintStack(stackTrace: stack, label: error.toString());
    }
  }

  @override
  void onClose() {
    emailAddressController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
