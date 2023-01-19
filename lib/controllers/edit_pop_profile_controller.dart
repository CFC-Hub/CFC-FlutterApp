import 'package:cfc/controllers/cfc_controllers.dart';
import 'package:cfc/models/cfc_models.dart';
import 'package:cfc/services/cfc_firebase_firestore.dart';
import 'package:cfc/utils/cfc_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditPopProfileController extends GetxController {
  final DashboardController dashboardController = Get.find<DashboardController>();
  final formKey = GlobalKey<FormState>();
  RxBool isSavingProfile = false.obs;
  RxBool isProfileUpdated = false.obs;

  RxString foodProducer = 'yes'.obs;
  RxString logistics = 'yes'.obs;
  RxString publicAdministration = 'yes'.obs;
  RxString agriFoodResearch = 'yes'.obs;
  RxString technologyAgriFood = 'yes'.obs;
  RxString knownCfcSelected = 'website'.obs;

  final TextEditingController organisationController = TextEditingController();
  final TextEditingController taglineController = TextEditingController();

  @override
  void onInit() {
    fillForm();
    super.onInit();
  }

  void fillForm() {
    organisationController.text = dashboardController.popProfile.value.organisation;
    taglineController.text = dashboardController.popProfile.value.tagline;
    foodProducer.value = dashboardController.popProfile.value.questions.isFoodProducer ? 'yes' : 'no';
    logistics.value = dashboardController.popProfile.value.questions.inLogistics ? 'yes' : 'no';
    publicAdministration.value = dashboardController.popProfile.value.questions.inPublicAdministration ? 'yes' : 'no';
    agriFoodResearch.value = dashboardController.popProfile.value.questions.inAgriFoodResearch ? 'yes' : 'no';
    technologyAgriFood.value = dashboardController.popProfile.value.questions.inTechnologyAgriFood ? 'yes' : 'no';
  }

  Future<void> updatePopProfile() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (!formKey.currentState!.validate()) {
      return;
    }
    try {
      isSavingProfile.value = true;
      var deviceInfo = await CFCHelper.getDeviceInfo();
      PopProfile updatedPopProfile = dashboardController.popProfile.value.copyWith(
          organisation: organisationController.text.trim().toLowerCase(),
          questions: Questions(
            isFoodProducer: foodProducer.value == 'yes' ? true : false,
            inLogistics: logistics.value == 'yes' ? true : false,
            inPublicAdministration: publicAdministration.value == 'yes' ? true : false,
            inAgriFoodResearch: agriFoodResearch.value == 'yes' ? true : false,
            inTechnologyAgriFood: technologyAgriFood.value == 'yes' ? true : false,
          ),
          tagline: taglineController.text.trim().toLowerCase(),
          deviceInfo: deviceInfo,
          modifiedOn: DateTime.now().millisecondsSinceEpoch);
      await CFCFirebaseFireStore().updatePopProfile(popProfile: updatedPopProfile);
      await dashboardController.updatePopProfileInHive(updatedPopProfile);
      isSavingProfile.value = false;
      isProfileUpdated.value = true;
    } catch (e, s) {
      isSavingProfile.value = false;
      CFCHelper.showError(message: 'Failed to updated POP Profile.');
      debugPrintStack(stackTrace: s, label: e.toString());
    }
  }

  @override
  void onClose() {
    organisationController.dispose();
    taglineController.dispose();
    super.onClose();
  }
}
