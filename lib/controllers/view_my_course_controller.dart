import 'package:cfc/controllers/cfc_controllers.dart';
import 'package:cfc/models/cfc_models.dart';
import 'package:cfc/screens/update_quiz_and_feedback.dart';
import 'package:cfc/services/cfc_firebase_firestore.dart';
import 'package:cfc/utils/cfc_helper.dart';
import 'package:get/get.dart';

class ViewMyCourseController extends GetxController {
  ViewMyCourseController(this.myCourses);

  Rx<MyCourseDetails> myCourses;

  final CFCFirebaseFireStore _fireStore = CFCFirebaseFireStore();

  final DashboardController _dashboardController = Get.find<DashboardController>();

  RxBool showCourse = true.obs;
  RxBool isSaving = false.obs;
  RxBool showCoursesCompletedUI = false.obs;

  void continueButton() {
    if (!myCourses.value.isCourseCompleted) {
      updateCourseCompleted();
    } else if (!myCourses.value.isQuizCompleted || !myCourses.value.isFeedbackCompleted) {
      Get.off(() => UpdateQuizAndFeedback(myCourses: myCourses.value));
    } else {
      Get.back();
    }
  }

  Future<void> updateCourseCompleted() async {
    try {
      isSaving.value = true;
      var deviceInfo = await CFCHelper.getDeviceInfo();
      MyCourseDetails details = myCourses.value
          .copyWith(isCourseCompleted: true, modifiedOn: DateTime.now().microsecondsSinceEpoch, deviceInfo: deviceInfo);
      await _fireStore.updateMyCourse(myCourseDetails: details);
      myCourses.value = details;
      isSaving.value = false;
      showCourse.value = false;
      showCoursesCompletedUI.value = true;
      _dashboardController.afterCourseComplete();
    } catch (e) {
      showCourse.value = true;
      isSaving.value = false;
      showCoursesCompletedUI.value = false;
      CFCHelper.showError(message: 'Failed to update.');
    }
  }
}
