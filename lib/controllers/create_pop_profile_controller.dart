import 'package:cfc/controllers/cfc_controllers.dart';
import 'package:cfc/models/cfc_models.dart';
import 'package:cfc/screens/cfc_screens.dart';
import 'package:cfc/services/cfc_firebase_firestore.dart';
import 'package:cfc/utils/cfc_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CreatePopProfileController extends GetxController {
  final DashboardController dashboardController = Get.find<DashboardController>();
  final formKey = GlobalKey<FormState>();
  RxBool isSavingProfile = false.obs;
  RxBool isPopProfileCreated = false.obs;

  RxString foodProducer = 'yes'.obs;
  RxString logistics = 'yes'.obs;
  RxString publicAdministration = 'yes'.obs;
  RxString agriFoodResearch = 'yes'.obs;
  RxString technologyAgriFood = 'yes'.obs;
  RxString knownCfcSelected = 'website'.obs;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController organisationController = TextEditingController();
  final TextEditingController taglineController = TextEditingController();

  Future<void> createPopProfile() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (!formKey.currentState!.validate()) {
      return;
    }
    var result = await Get.to(() => ConnectMetaMask(
        nftType: NftType.createPopNFT,
        firstName: firstNameController.text.toLowerCase(),
        lastName: lastNameController.text.toLowerCase()));
    if (result == null) {
      return;
    }
    if (result is NftDetails) {
      try {
        isSavingProfile.value = true;
        var deviceInfo = await CFCHelper.getDeviceInfo();
        PopProfile updatedPopProfile = dashboardController.popProfile.value.copyWith(
          firstName: firstNameController.text.trim().toLowerCase(),
          lastName: lastNameController.text.trim().toLowerCase(),
          organisation: organisationController.text.trim().toLowerCase(),
          questions: Questions(
            isFoodProducer: foodProducer.value == 'yes' ? true : false,
            inLogistics: logistics.value == 'yes' ? true : false,
            inPublicAdministration: publicAdministration.value == 'yes' ? true : false,
            inAgriFoodResearch: agriFoodResearch.value == 'yes' ? true : false,
            inTechnologyAgriFood: technologyAgriFood.value == 'yes' ? true : false,
          ),
          tagline: taglineController.text.trim().toLowerCase(),
          aboutCfcProject: knownCfcSelected.value,
          isPopProfileCreated: true,
          metamaskAccountAddress: result.accountAddress,
          deviceInfo: deviceInfo,
          modifiedOn: DateTime.now().millisecondsSinceEpoch,
        );
        await CFCFirebaseFireStore().updatePopProfile(popProfile: updatedPopProfile);
        MyWalletDetails myWallet = MyWalletDetails(
          accountAddress: result.accountAddress,
          contractAddress: result.contractAddress,
          createdOn: DateTime.now().millisecondsSinceEpoch,
          createdBy: updatedPopProfile.createdBy,
          id: CFCHelper.generateUUID(),
          name: 'pop profile',
          nftId: result.nftId,
          signature: result.signature,
          deviceInfo: deviceInfo,
        );
        await CFCFirebaseFireStore().setMyWallet(myWallet: myWallet);
        await dashboardController.updatePopProfileInHive(updatedPopProfile);
        dashboardController.afterPopProfileCreate();
        isSavingProfile.value = false;
        isPopProfileCreated.value = true;
      } catch (e, s) {
        isSavingProfile.value = false;
        CFCHelper.showError(message: 'Failed to create POP Profile.');
        debugPrintStack(stackTrace: s, label: e.toString());
      }
      // var doc =
      //     await CFCFirebaseFireStore().getPopProfileUsingId(createdBy: dashboardController.popProfile.value.createdBy);
      // if (doc.data() != null) {
      //   PopProfile popProfile = PopProfile.fromMap(doc.data() as Map<String, dynamic>);
      //   PopProfile updatedPopProfile = popProfile.copyWith();
      //   await CFCFirebaseFireStore().updatePopProfile(popProfile: popProfile.copyWith());
      //   dashboardController.updatePopProfileInHive(updatedPopProfile);
      // } else {
      //   // TODO: Handel error.
      // }
    }
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    organisationController.dispose();
    taglineController.dispose();
    super.onClose();
  }
}
