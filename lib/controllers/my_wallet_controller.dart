import 'package:cfc/controllers/cfc_controllers.dart';
import 'package:cfc/models/cfc_models.dart';
import 'package:cfc/services/cfc_firebase_firestore.dart';
import 'package:cfc/utils/cfc_helper.dart';
import 'package:get/get.dart';

class MyWalletController extends GetxController {
  final DashboardController dashboardController = Get.find<DashboardController>();
  RxList<MyWalletDetails> walletsDetails = <MyWalletDetails>[].obs;

  RxBool isLoading = false.obs;

  int colorPick = 0;

  @override
  void onInit() {
    if (dashboardController.popProfile.value.isPopProfileCreated) {
      getWallet();
    }
    super.onInit();
  }

  Future<void> getWallet() async {
    try {
      isLoading.value = true;
      var documentSnapshot =
          await CFCFirebaseFireStore().getMyWallet(createdBy: dashboardController.popProfile.value.createdBy);
      for (var element in documentSnapshot) {
        walletsDetails.add(MyWalletDetails.fromMap(element.data() as Map<String, dynamic>));
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      CFCHelper.showError(message: 'Failed to fetch wallet details.');
    }
  }
}
