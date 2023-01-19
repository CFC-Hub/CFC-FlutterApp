import 'package:cfc/controllers/cfc_controllers.dart';
import 'package:cfc/models/cfc_models.dart';
import 'package:cfc/services/cfc_firebase_firestore.dart';
import 'package:cfc/utils/cfc_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateQuizAndFeedbackController extends GetxController {
  Rx<MyCourseDetails> myCourseDetails;

  UpdateQuizAndFeedbackController(this.myCourseDetails) {
    if (!myCourseDetails.value.isQuizCompleted) {
      isQuizShow.value = true;
    } else if (!myCourseDetails.value.isFeedbackCompleted) {
      isFeedbackCompleted.value = true;
    }
  }

  final DashboardController _dashboardController = Get.find<DashboardController>();
  final CFCFirebaseFireStore _fireStore = CFCFirebaseFireStore();
  RxBool showCoursesCompletedUI = false.obs;
  RxBool isQuizShow = false.obs;
  RxBool showQuizCompletedUI = false.obs;
  RxBool isFeedback1Show = false.obs;
  RxBool isFeedback2Show = false.obs;
  RxBool isFeedback3Show = false.obs;
  RxBool isFeedback4Show = false.obs;
  RxBool showFeedbackCompletedUI = false.obs;
  RxBool isSaving = false.obs;
  RxBool isCoursesCompleted = false.obs;
  RxBool isQuizCompleted = false.obs;
  RxBool isFeedbackCompleted = false.obs;

  RxString answer1 = ''.obs;
  RxString answer2 = ''.obs;
  RxString answer3 = ''.obs;
  RxString answer4 = ''.obs;

  final quizFormKey = GlobalKey<FormState>();
  final TextEditingController answer1Controller = TextEditingController();
  final TextEditingController answer2Controller = TextEditingController();
  final TextEditingController answer3Controller = TextEditingController();
  final TextEditingController answer4Controller = TextEditingController();

  RxInt feedback1Answer = 1.obs;
  RxInt feedback2Answer1 = 1.obs;
  RxInt feedback2Answer2 = 1.obs;
  RxInt feedback2Answer3 = 1.obs;
  RxInt feedback2Answer4 = 1.obs;
  RxInt feedback3Answer1 = 1.obs;
  RxInt feedback3Answer2 = 1.obs;
  RxInt feedback3Answer3 = 1.obs;
  RxInt feedback3Answer4 = 1.obs;
  RxInt feedback4Answer1 = 1.obs;
  RxInt feedback4Answer2 = 1.obs;
  RxInt feedback4Answer3 = 1.obs;
  RxInt feedback4Answer4 = 1.obs;

  void skip() {
    if (isQuizShow.isTrue) {
      CFCHelper.showBottomAlert(
          title: 'Are you sure?',
          content: 'You want to skip answering the quiz?',
          buttonText: 'Skip',
          onPressed: () {
            Get.back();
            isQuizShow.value = false;
            isFeedback1Show.value = true;
          });
    } else if (isFeedback1Show.isTrue || isFeedback2Show.isTrue || isFeedback3Show.isTrue || isFeedback4Show.isTrue) {
      CFCHelper.showBottomAlert(
          title: 'Are you sure?',
          content: 'You want to skip the feedback section?',
          buttonText: 'Skip',
          onPressed: () {
            Get.back();
            isFeedback1Show.value = false;
            finish();
          });
    }
  }

  void showQuiz() {
    isCoursesCompleted.value = true;
    showCoursesCompletedUI.value = false;
    isQuizShow.value = true;
  }

  Future<void> showQuizCompleted() async {
    if (!quizFormKey.currentState!.validate()) {
      return;
    }

    try {
      FocusManager.instance.primaryFocus?.unfocus();
      isSaving.value = true;
      var deviceInfo = await CFCHelper.getDeviceInfo();
      QuizDetails quizDetails = QuizDetails(
        createdBy: _dashboardController.popProfile.value.createdBy,
        id: CFCHelper.generateUUID(),
        createdOn: DateTime.now().millisecondsSinceEpoch,
        courseId: myCourseDetails.value.courseId,
        answers: Answers(
          questionOne: answer1Controller.text,
          questionTwo: answer2Controller.text,
          questionThree: answer3Controller.text,
          questionFour: answer4Controller.text,
        ),
        deviceInfo: deviceInfo,
      );
      await _fireStore.setQuiz(quiz: quizDetails);
      myCourseDetails.value = myCourseDetails.value.copyWith(
          quizId: quizDetails.id,
          isQuizCompleted: true,
          modifiedOn: DateTime.now().microsecondsSinceEpoch,
          deviceInfo: deviceInfo);
      await _fireStore.updateMyCourse(myCourseDetails: myCourseDetails.value);
      isQuizCompleted.value = true;
      isQuizShow.value = false;
      showQuizCompletedUI.value = true;
      isSaving.value = false;
      _dashboardController.afterCourseComplete();
    } catch (e) {
      isSaving.value = false;
      CFCHelper.showError(message: 'Failed to save Quiz Answers.');
    }
  }

  void showFeedback1() {
    if (myCourseDetails.value.isFeedbackCompleted) {
      Get.back();
      return;
    }
    showQuizCompletedUI.value = false;
    isFeedback1Show.value = true;
    isFeedback2Show.value = false;
  }

  void showFeedback2() {
    isFeedback1Show.value = false;
    isFeedback2Show.value = true;
    isFeedback3Show.value = false;
  }

  void showFeedback3() {
    isFeedback2Show.value = false;
    isFeedback3Show.value = true;
    isFeedback4Show.value = false;
  }

  void showFeedback4() {
    isFeedback3Show.value = false;
    isFeedback4Show.value = true;
    showFeedbackCompletedUI.value = false;
  }

  Future<void> finish() async {
    if (myCourseDetails.value.isFeedbackCompleted) {
      Get.back();
      return;
    }

    try {
      isSaving.value = true;
      var deviceInfo = await CFCHelper.getDeviceInfo();

      FeedbackDetails feedbackDetails = FeedbackDetails(
        createdBy: _dashboardController.popProfile.value.createdBy,
        id: CFCHelper.generateUUID(),
        courseId: myCourseDetails.value.courseId,
        createdOn: DateTime.now().millisecondsSinceEpoch,
        feedback: FeedbackAnswer(
          questionOne: feedback1Answer.value,
          questionTwo: Question(
            answerOne: feedback2Answer1.value,
            answerTwo: feedback2Answer2.value,
            answerThree: feedback2Answer3.value,
            answerFour: feedback2Answer4.value,
          ),
          questionThree: Question(
            answerOne: feedback3Answer1.value,
            answerTwo: feedback3Answer2.value,
            answerThree: feedback3Answer3.value,
            answerFour: feedback3Answer4.value,
          ),
          questionFour: Question(
            answerOne: feedback4Answer1.value,
            answerTwo: feedback4Answer2.value,
            answerThree: feedback4Answer3.value,
            answerFour: feedback4Answer4.value,
          ),
        ),
        deviceInfo: deviceInfo,
      );
      await _fireStore.setFeedback(feedback: feedbackDetails);
      myCourseDetails.value = myCourseDetails.value.copyWith(
          feedbackId: feedbackDetails.id,
          isFeedbackCompleted: true,
          modifiedOn: DateTime.now().microsecondsSinceEpoch,
          deviceInfo: deviceInfo);
      await _fireStore.updateMyCourse(myCourseDetails: myCourseDetails.value);
      _dashboardController.afterCourseComplete();
      isSaving.value = false;
      isFeedback4Show.value = false;
      showFeedbackCompletedUI.value = true;
    } catch (e) {
      isSaving.value = false;
      isFeedback4Show.value = true;
      showFeedbackCompletedUI.value = false;
      CFCHelper.showError(message: 'Failed to save feedback.');
    }
  }
}
