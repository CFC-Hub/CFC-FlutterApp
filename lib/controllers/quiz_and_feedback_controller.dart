import 'package:cfc/controllers/cfc_controllers.dart';
import 'package:cfc/models/cfc_models.dart';
import 'package:cfc/screens/cfc_screens.dart';
import 'package:cfc/services/cfc_firebase_firestore.dart';
import 'package:cfc/utils/cfc_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizAndFeedbackController extends GetxController {
  QuizAndFeedbackController({required bool isFinishedReading}) {
    if (isFinishedReading) {
      showCoursesCompletedUI.value = isFinishedReading;
    } else {
      isQuizShow.value = true;
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
  RxBool showCongratulationUI = false.obs;
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

  void skip(CourseDetails courseDetails) {
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
            finish(courseDetails);
          });
    }
  }

  void showQuiz() {
    isCoursesCompleted.value = true;
    showCoursesCompletedUI.value = false;
    isQuizShow.value = true;
  }

  void showQuizCompleted() {
    if (!quizFormKey.currentState!.validate()) {
      return;
    }
    isQuizCompleted.value = true;
    isQuizShow.value = false;
    showQuizCompletedUI.value = true;
  }

  void showFeedback1() {
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

  void showFeedbackCompleted() {
    isFeedbackCompleted.value = true;
    isFeedback4Show.value = false;
    showFeedbackCompletedUI.value = true;
  }

  void showCongratulation() {
    showFeedbackCompletedUI.value = false;
    showCongratulationUI.value = true;
  }

  Future<void> finish(CourseDetails courseDetails) async {
    try {
      var result = await Get.to(() => ConnectMetaMask(
            nftType: NftType.createLearningNFT,
            firstName: _dashboardController.popProfile.value.firstName,
            lastName: _dashboardController.popProfile.value.lastName,
            contentId: courseDetails.courseId,
          ));
      if (result == null) {
        return;
      }

      if (result is NftDetails) {
        isFeedback1Show.value = false;
        isFeedback2Show.value = false;
        isFeedback3Show.value = false;
        isFeedback4Show.value = false;
        showFeedbackCompletedUI.value = false;
        isSaving.value = true;

        var deviceInfo = await CFCHelper.getDeviceInfo();

        QuizDetails quizDetails = QuizDetails(
          createdBy: _dashboardController.popProfile.value.createdBy,
          id: CFCHelper.generateUUID(),
          createdOn: DateTime.now().millisecondsSinceEpoch,
          courseId: courseDetails.courseId,
          answers: Answers(
            questionOne: answer1Controller.text,
            questionTwo: answer2Controller.text,
            questionThree: answer3Controller.text,
            questionFour: answer4Controller.text,
          ),
          deviceInfo: deviceInfo,
        );

        FeedbackDetails feedbackDetails = FeedbackDetails(
          createdBy: _dashboardController.popProfile.value.createdBy,
          id: CFCHelper.generateUUID(),
          courseId: courseDetails.courseId,
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

        MyCourseDetails myCourseDetails = MyCourseDetails(
          createdBy: _dashboardController.popProfile.value.createdBy,
          id: CFCHelper.generateUUID(),
          courseName: courseDetails.courseName,
          courseDisplayPicture: courseDetails.courseDisplayPicture,
          courseUrl: courseDetails.courseUrl,
          isCourseCompleted: isCoursesCompleted.value,
          isQuizCompleted: isQuizCompleted.value,
          isFeedbackCompleted: isFeedbackCompleted.value,
          createdOn: DateTime.now().millisecondsSinceEpoch,
          courseId: courseDetails.courseId,
          deviceInfo: deviceInfo,
          feedbackId: '',
          quizId: '',
          modifiedOn: DateTime.now().millisecondsSinceEpoch,
        );

        MyWalletDetails myWallet = MyWalletDetails(
          accountAddress: result.accountAddress,
          contractAddress: result.contractAddress,
          createdOn: DateTime.now().millisecondsSinceEpoch,
          createdBy: _dashboardController.popProfile.value.createdBy,
          id: CFCHelper.generateUUID(),
          name: courseDetails.courseName,
          nftId: result.nftId,
          signature: result.signature,
          deviceInfo: deviceInfo,
        );

        await CFCFirebaseFireStore().setMyWallet(myWallet: myWallet);

        if (isQuizCompleted.isTrue) {
          await _fireStore.setQuiz(quiz: quizDetails);
          myCourseDetails = myCourseDetails.copyWith(
              quizId: quizDetails.id, modifiedOn: DateTime.now().microsecondsSinceEpoch, deviceInfo: deviceInfo);
        }

        if (isFeedbackCompleted.isTrue) {
          await _fireStore.setFeedback(feedback: feedbackDetails);
          myCourseDetails = myCourseDetails.copyWith(
              feedbackId: feedbackDetails.id,
              modifiedOn: DateTime.now().microsecondsSinceEpoch,
              deviceInfo: deviceInfo);
        }

        await _fireStore.setMyCourse(myCourseDetails: myCourseDetails);

        _dashboardController.afterCourseComplete();
        isSaving.value = false;
        showCongratulationUI.value = true;
      }
    } catch (e) {
      isSaving.value = false;
      if (isFeedbackCompleted.isFalse) {
        isFeedback1Show.value = true;
      } else {
        showFeedbackCompletedUI.value = true;
      }
      CFCHelper.showError(message: 'Failed to save your details.');
      _dashboardController.afterCourseComplete();
    }
  }

  void home() {
    Get.back();
  }
}
