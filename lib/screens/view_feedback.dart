import 'package:cfc/controllers/cfc_controllers.dart';
import 'package:cfc/models/cfc_models.dart';
import 'package:cfc/utils/cfc_utils.dart';
import 'package:cfc/widgets/cfc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewFeedback extends StatelessWidget {
  const ViewFeedback({Key? key, required this.details}) : super(key: key);
  final MyCourseDetails details;

  @override
  Widget build(BuildContext context) {
    final ViewFeedbackController controller = Get.put(ViewFeedbackController(details));
    return Scaffold(
      appBar: AppBar(
        leadingWidth: CFCConstant.leadingWidth,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 300,
              child: CFCAppText(
                text: '${details.courseId} - ${details.courseName}',
                fontWeight: FontWeight.w700,
                color: CFCAppColors.textColorLight,
              ),
            ),
            const CFCAppText(
              text: 'Feedback',
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Colors.white70,
            ),
          ],
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_outlined,
          ),
        ),
      ),
      body: Obx(
        () => SafeArea(
          child: Visibility(
            visible: controller.isLoading.isFalse,
            replacement: const Center(child: CFCWidgetHelper.loadingWidget),
            child: controller.feedbackDetails.value != null
                ? ListView(
                    padding: const EdgeInsets.all(10.0),
                    children: [
                      CFCCard(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CFCSlider(
                              value: controller.feedbackDetails.value!.feedback.questionOne,
                              onChanged: (value) {
                                CFCHelper.showMessage(
                                    message: 'You cannot change values of feedback already submitted.');
                              },
                              titleText: 'Can this project succeed in its aims?',
                              startText: '1. Not a chance',
                              endText: 'Absolutely believe so. 6',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      CFCCard(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CFCSlider(
                              value: controller.feedbackDetails.value!.feedback.questionTwo.answerOne,
                              onChanged: (value) {
                                CFCHelper.showMessage(
                                    message: 'You cannot change values of feedback already submitted.');
                              },
                              titleText: 'How do you rate the knowledge and reputation of the project\'s leadership?',
                              startText: '1. Expert',
                              endText: 'Novice. 6',
                            ),
                            const SizedBox(height: 15),
                            CFCSlider(
                              value: controller.feedbackDetails.value!.feedback.questionTwo.answerTwo,
                              onChanged: (value) {
                                CFCHelper.showMessage(
                                    message: 'You cannot change values of feedback already submitted.');
                              },
                              startText: '1. Proven',
                              endText: 'Untested. 6',
                            ),
                            const SizedBox(height: 15),
                            CFCSlider(
                              value: controller.feedbackDetails.value!.feedback.questionTwo.answerThree,
                              onChanged: (value) {
                                CFCHelper.showMessage(
                                    message: 'You cannot change values of feedback already submitted.');
                              },
                              startText: '1. Comprehensive',
                              endText: 'Lacking. 6',
                            ),
                            const SizedBox(height: 15),
                            CFCSlider(
                              value: controller.feedbackDetails.value!.feedback.questionTwo.answerFour,
                              onChanged: (value) {
                                CFCHelper.showMessage(
                                    message: 'You cannot change values of feedback already submitted.');
                              },
                              startText: '1. Collaborative',
                              endText: 'Single vision. 6',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      CFCCard(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CFCSlider(
                              value: controller.feedbackDetails.value!.feedback.questionThree.answerOne,
                              onChanged: (value) {
                                CFCHelper.showMessage(
                                    message: 'You cannot change values of feedback already submitted.');
                              },
                              titleText: 'How well do you understand the project?\n',
                              startText: '1. Impressive',
                              endText: 'Underwhelming. 6',
                            ),
                            const SizedBox(height: 15),
                            CFCSlider(
                              value: controller.feedbackDetails.value!.feedback.questionThree.answerTwo,
                              onChanged: (value) {
                                CFCHelper.showMessage(
                                    message: 'You cannot change values of feedback already submitted.');
                              },
                              startText: '1. Complex',
                              endText: 'Simple. 6',
                            ),
                            const SizedBox(height: 15),
                            CFCSlider(
                              value: controller.feedbackDetails.value!.feedback.questionThree.answerThree,
                              onChanged: (value) {
                                CFCHelper.showMessage(
                                    message: 'You cannot change values of feedback already submitted.');
                              },
                              startText: '1. Completely',
                              endText: 'Partially. 6',
                            ),
                            const SizedBox(height: 15),
                            CFCSlider(
                              value: controller.feedbackDetails.value!.feedback.questionThree.answerFour,
                              onChanged: (value) {
                                CFCHelper.showMessage(
                                    message: 'You cannot change values of feedback already submitted.');
                              },
                              startText: '1. Out of my depth',
                              endText: 'In my zone. 6',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      CFCCard(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CFCSlider(
                              value: controller.feedbackDetails.value!.feedback.questionFour.answerOne,
                              onChanged: (value) {
                                CFCHelper.showMessage(
                                    message: 'You cannot change values of feedback already submitted.');
                              },
                              titleText: 'What would make the project more ambitious?',
                              startText: '1. More use of technology',
                              endText: 'Less use. 6',
                            ),
                            const SizedBox(height: 15),
                            CFCSlider(
                              value: controller.feedbackDetails.value!.feedback.questionFour.answerTwo,
                              onChanged: (value) {
                                CFCHelper.showMessage(
                                    message: 'You cannot change values of feedback already submitted.');
                              },
                              startText: '1. More input from stakeholders',
                              endText: 'Less Input. 6',
                            ),
                            const SizedBox(height: 15),
                            CFCSlider(
                              value: controller.feedbackDetails.value!.feedback.questionFour.answerThree,
                              onChanged: (value) {
                                CFCHelper.showMessage(
                                    message: 'You cannot change values of feedback already submitted.');
                              },
                              startText: '1. More global perspective',
                              endText: 'More local. 6',
                            ),
                            const SizedBox(height: 15),
                            CFCSlider(
                              value: controller.feedbackDetails.value!.feedback.questionFour.answerFour,
                              onChanged: (value) {
                                CFCHelper.showMessage(
                                    message: 'You cannot change values of feedback already submitted.');
                              },
                              startText: '1. More focus on circular\n& resume economics',
                              endText: 'More focus on linear efficiencies. 6',
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}
