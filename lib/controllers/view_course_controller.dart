import 'package:cfc/controllers/cfc_controllers.dart';
import 'package:cfc/models/cfc_models.dart';
import 'package:cfc/services/cfc_firebase_firestore.dart';
import 'package:get/get.dart';

class ViewCourseController extends GetxController {
  ViewCourseController(this.courseDetails);
  final CourseDetails? courseDetails;

  final DashboardController dashboardController = Get.find<DashboardController>();

  RxBool isCourseContinue = false.obs;

  @override
  void onInit() {
    checkCourse();
    super.onInit();
  }

  Future<void> checkCourse() async {
    if (courseDetails != null) {
      var snapshot = await CFCFirebaseFireStore().getMyCourseUsingCourseId(
          createdBy: dashboardController.popProfile.value.createdBy, courseId: courseDetails!.courseId);
      if (snapshot.isEmpty) {
        isCourseContinue.value = true;
      }
    }
  }
}
