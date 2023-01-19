import 'package:cfc/controllers/cfc_controllers.dart';
import 'package:cfc/models/cfc_models.dart';
import 'package:cfc/services/cfc_firebase_firestore.dart';
import 'package:cfc/utils/cfc_utils.dart';
import 'package:get/get.dart';

class BrowseCourseController extends GetxController {
  final DashboardController dashboardController = Get.find<DashboardController>();
  final RxList<CourseDetails> courses = <CourseDetails>[].obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    if (dashboardController.popProfile.value.isPopProfileCreated) {
      getAllCourses();
    }
    super.onInit();
  }

  Future<void> getAllCourses() async {
    try {
      isLoading.value = true;
      var documentSnapshot = await CFCFirebaseFireStore().getAllCourses();
      for (var element in documentSnapshot) {
        courses.add(CourseDetails.fromMap(element.data()! as Map<String, dynamic>));
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      CFCHelper.showError(message: 'Failed to fetch courses.');
    }
  }
}
