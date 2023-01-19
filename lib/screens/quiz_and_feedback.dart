import 'package:cfc/controllers/cfc_controllers.dart';
import 'package:cfc/models/cfc_models.dart';
import 'package:cfc/utils/cfc_utils.dart';
import 'package:cfc/widgets/cfc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';

class QuizAndFeedback extends StatelessWidget {
  const QuizAndFeedback({Key? key, required this.courseDetails, required this.isFinishedReading}) : super(key: key);

  final CourseDetails courseDetails;
  final bool isFinishedReading;

  @override
  Widget build(BuildContext context) {
    final QuizAndFeedbackController controller =
        Get.put(QuizAndFeedbackController(isFinishedReading: isFinishedReading));
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leadingWidth: CFCConstant.leadingWidth,
          title: SizedBox(
            width: 300,
            child: CFCAppText(
              text: '${courseDetails.courseId} - ${courseDetails.courseName}',
              fontWeight: FontWeight.w700,
              color: CFCAppColors.textColorLight,
            ),
          ),
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_outlined,
            ),
          ),
          actions: [
            if (controller.isQuizShow.isTrue ||
                controller.isFeedback1Show.isTrue ||
                controller.isFeedback2Show.isTrue ||
                controller.isFeedback3Show.isTrue ||
                controller.isFeedback4Show.isTrue) ...[
              IconButton(
                onPressed: () => controller.skip(courseDetails),
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.white,
                ),
              ),
            ],
          ],
        ),
        body: Container(
          color: CFCAppColors.lightBackground,
          child: SafeArea(
            child: Stack(
              children: [
                /// Congratulations
                Visibility(
                  visible: controller.showCoursesCompletedUI.isTrue,
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                CFCAssets.successDarkSVG,
                                fit: BoxFit.contain,
                                height: MediaQuery.of(context).size.width / 1.5,
                                width: MediaQuery.of(context).size.width / 1.5,
                              ),
                              const SizedBox(height: 30),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: 'Congratulations! ',
                                  style: GoogleFonts.lexendDeca(
                                    fontWeight: FontWeight.w600,
                                    color: CFCAppColors.textColorDark,
                                    height: 2.0,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          'Now that you have finished reading let\'s take a short Quiz to recap on what you learnt.',
                                      style: GoogleFonts.lexendDeca(
                                        fontWeight: FontWeight.w400,
                                        color: CFCAppColors.textColorDark,
                                        height: 2.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: CFCMaterialButton(
                          onPressed: controller.showQuiz,
                          text: 'Continue',
                          width: double.infinity,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),

                /// Quiz
                Visibility(
                  visible: controller.isQuizShow.isTrue,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      key: controller.quizFormKey,
                      child: Column(
                        children: [
                          CFCCard(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: CFCAppText(
                                    text: 'Can you name the communities or stakeholders this project benefits?',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: CFCAppColors.textColorDark,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                CFCTextFormField(
                                  controller: controller.answer1Controller,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This field cannot be empty';
                                    }
                                    return null;
                                  },
                                  onChanged: (String text) {
                                    controller.answer1.value = text;
                                  },
                                  hintText: 'Type your answer',
                                  labelText: 'Your Answer',
                                  minLines: 6,
                                  maxLines: 10,
                                  inputFormatters: [CFCConstant.limitingTextInputFormatter],
                                ),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: CFCAppText(
                                    text: '${controller.answer1.value.length}/180',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: CFCAppColors.textColorDark,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          CFCCard(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: CFCAppText(
                                    text: 'Can you describe the expected impact of the project?',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: CFCAppColors.textColorDark,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                CFCTextFormField(
                                  controller: controller.answer2Controller,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This field cannot be empty';
                                    }
                                    return null;
                                  },
                                  onChanged: (String text) {
                                    controller.answer2.value = text;
                                  },
                                  hintText: 'Type your answer',
                                  labelText: 'Your Answer',
                                  minLines: 6,
                                  maxLines: 10,
                                  inputFormatters: [CFCConstant.limitingTextInputFormatter],
                                ),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: CFCAppText(
                                    text: '${controller.answer2.value.length}/180',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: CFCAppColors.textColorDark,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          CFCCard(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: CFCAppText(
                                    text: 'How useful do you think this project is in addressing climate change?',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: CFCAppColors.textColorDark,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                CFCTextFormField(
                                  controller: controller.answer3Controller,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This field cannot be empty';
                                    }
                                    return null;
                                  },
                                  onChanged: (String text) {
                                    controller.answer3.value = text;
                                  },
                                  hintText: 'Type your answer',
                                  labelText: 'Your Answer',
                                  minLines: 6,
                                  maxLines: 10,
                                  inputFormatters: [CFCConstant.limitingTextInputFormatter],
                                ),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: CFCAppText(
                                    text: '${controller.answer3.value.length}/180',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: CFCAppColors.textColorDark,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          CFCCard(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: CFCAppText(
                                    text: 'Anything else to add?',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: CFCAppColors.textColorDark,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                CFCTextFormField(
                                  controller: controller.answer4Controller,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This field cannot be empty';
                                    }
                                    return null;
                                  },
                                  onChanged: (String text) {
                                    controller.answer4.value = text;
                                  },
                                  hintText: 'Type your answer',
                                  labelText: 'Your Answer',
                                  minLines: 6,
                                  maxLines: 10,
                                  inputFormatters: [CFCConstant.limitingTextInputFormatter],
                                ),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: CFCAppText(
                                    text: '${controller.answer4.value.length}/180',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: CFCAppColors.textColorDark,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          CFCMaterialButton(
                            onPressed: controller.showQuizCompleted,
                            text: 'Continue',
                            width: double.infinity,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                /// Quiz complete
                Visibility(
                  visible: controller.showQuizCompletedUI.isTrue,
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                CFCAssets.successDarkSVG,
                                fit: BoxFit.contain,
                                height: MediaQuery.of(context).size.width / 1.5,
                                width: MediaQuery.of(context).size.width / 1.5,
                              ),
                              const SizedBox(height: 30),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: 'Awesome! ',
                                  style: GoogleFonts.lexendDeca(
                                    fontWeight: FontWeight.w600,
                                    color: CFCAppColors.textColorDark,
                                    height: 2.0,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'We would like to know what you felt about your latest learning. '
                                          'Please tap on \'Continue\' to leave a feedback.',
                                      style: GoogleFonts.lexendDeca(
                                        fontWeight: FontWeight.w400,
                                        color: CFCAppColors.textColorDark,
                                        height: 2.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CFCMaterialButton(
                          onPressed: controller.showFeedback1,
                          text: 'Continue',
                          width: double.infinity,
                        ),
                      ),
                    ],
                  ),
                ),

                /// Feedback 1
                Visibility(
                  visible: controller.isFeedback1Show.isTrue,
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            SvgPicture.asset(
                              CFCAssets.feedbackImage1SVG,
                              fit: BoxFit.contain,
                              height: MediaQuery.of(context).size.width / 1.3,
                              width: MediaQuery.of(context).size.width / 1.3,
                            ),
                            const SizedBox(height: 30),
                            CFCSlider(
                              value: controller.feedback1Answer.value,
                              onChanged: (value) {
                                controller.feedback1Answer.value = value.toInt();
                              },
                              titleText: 'Can this project succeed in its aims?',
                              startText: '1. Not a chance',
                              endText: 'Absolutely believe so. 6',
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CFCMaterialButton(
                          onPressed: controller.showFeedback2,
                          text: 'Continue',
                          width: double.infinity,
                        ),
                      ),
                    ],
                  ),
                ),

                /// Feedback 2
                Visibility(
                  visible: controller.isFeedback2Show.isTrue,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            const SizedBox(height: 20),
                            SvgPicture.asset(
                              CFCAssets.feedbackImage2SVG,
                              fit: BoxFit.contain,
                              height: MediaQuery.of(context).size.width / 1.3,
                              width: MediaQuery.of(context).size.width / 1.3,
                            ),
                            const SizedBox(height: 30),
                            CFCSlider(
                              value: controller.feedback2Answer1.value,
                              onChanged: (value) {
                                controller.feedback2Answer1.value = value.toInt();
                              },
                              titleText: 'How do you rate the knowledge and reputation of the project\'s leadership?',
                              startText: '1. Expert',
                              endText: 'Novice. 6',
                            ),
                            const SizedBox(height: 15),
                            CFCSlider(
                              value: controller.feedback2Answer2.value,
                              onChanged: (value) {
                                controller.feedback2Answer2.value = value.toInt();
                              },
                              startText: '1. Proven',
                              endText: 'Untested. 6',
                            ),
                            const SizedBox(height: 15),
                            CFCSlider(
                              value: controller.feedback2Answer3.value,
                              onChanged: (value) {
                                controller.feedback2Answer3.value = value.toInt();
                              },
                              startText: '1. Comprehensive',
                              endText: 'Lacking. 6',
                            ),
                            const SizedBox(height: 15),
                            CFCSlider(
                              value: controller.feedback2Answer4.value,
                              onChanged: (value) {
                                controller.feedback2Answer4.value = value.toInt();
                              },
                              startText: '1. Collaborative',
                              endText: 'Single vision. 6',
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: CFCMaterialButton(
                                onPressed: controller.showFeedback1,
                                text: 'Back',
                                width: double.infinity,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: CFCMaterialButton(
                                onPressed: controller.showFeedback3,
                                text: 'Continue',
                                width: double.infinity,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                /// Feedback 3
                Visibility(
                  visible: controller.isFeedback3Show.isTrue,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            const SizedBox(height: 20),
                            SvgPicture.asset(
                              CFCAssets.feedbackImage3SVG,
                              fit: BoxFit.contain,
                              height: MediaQuery.of(context).size.width / 1.3,
                              width: MediaQuery.of(context).size.width / 1.3,
                            ),
                            const SizedBox(height: 30),
                            CFCSlider(
                              value: controller.feedback3Answer1.value,
                              onChanged: (value) {
                                controller.feedback3Answer1.value = value.toInt();
                              },
                              titleText: 'How well do you understand the project?\n',
                              startText: '1. Impressive',
                              endText: 'Underwhelming. 6',
                            ),
                            const SizedBox(height: 15),
                            CFCSlider(
                              value: controller.feedback3Answer2.value,
                              onChanged: (value) {
                                controller.feedback3Answer2.value = value.toInt();
                              },
                              startText: '1. Complex',
                              endText: 'Simple. 6',
                            ),
                            const SizedBox(height: 15),
                            CFCSlider(
                              value: controller.feedback3Answer3.value,
                              onChanged: (value) {
                                controller.feedback3Answer3.value = value.toInt();
                              },
                              startText: '1. Completely',
                              endText: 'Partially. 6',
                            ),
                            const SizedBox(height: 15),
                            CFCSlider(
                              value: controller.feedback3Answer4.value,
                              onChanged: (value) {
                                controller.feedback3Answer4.value = value.toInt();
                              },
                              startText: '1. Out of my depth',
                              endText: 'In my zone. 6',
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: CFCMaterialButton(
                                onPressed: controller.showFeedback2,
                                text: 'Back',
                                width: double.infinity,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: CFCMaterialButton(
                                onPressed: controller.showFeedback4,
                                text: 'Continue',
                                width: double.infinity,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                /// Feedback 4
                Visibility(
                  visible: controller.isFeedback4Show.isTrue,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            const SizedBox(height: 20),
                            SvgPicture.asset(
                              CFCAssets.feedbackImage4SVG,
                              fit: BoxFit.contain,
                              height: MediaQuery.of(context).size.width / 1.3,
                              width: MediaQuery.of(context).size.width / 1.3,
                            ),
                            const SizedBox(height: 30),
                            CFCSlider(
                              value: controller.feedback4Answer1.value,
                              onChanged: (value) {
                                controller.feedback4Answer1.value = value.toInt();
                              },
                              titleText: 'What would make the project more ambitious?',
                              startText: '1. More use of technology',
                              endText: 'Less use. 6',
                            ),
                            const SizedBox(height: 15),
                            CFCSlider(
                              value: controller.feedback4Answer2.value,
                              onChanged: (value) {
                                controller.feedback4Answer2.value = value.toInt();
                              },
                              startText: '1. More input from stakeholders',
                              endText: 'Less Input. 6',
                            ),
                            const SizedBox(height: 15),
                            CFCSlider(
                              value: controller.feedback4Answer3.value,
                              onChanged: (value) {
                                controller.feedback4Answer3.value = value.toInt();
                              },
                              startText: '1. More global perspective',
                              endText: 'More local. 6',
                            ),
                            const SizedBox(height: 15),
                            CFCSlider(
                              value: controller.feedback4Answer4.value,
                              onChanged: (value) {
                                controller.feedback4Answer4.value = value.toInt();
                              },
                              startText: '1. More focus on circular &\n resume economics',
                              endText: 'More focus on linear efficiencies. 6',
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: CFCMaterialButton(
                                onPressed: controller.showFeedback3,
                                text: 'Back',
                                width: double.infinity,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: CFCMaterialButton(
                                onPressed: controller.showFeedbackCompleted,
                                text: 'Continue',
                                width: double.infinity,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                /// Finish
                Visibility(
                  visible: controller.showFeedbackCompletedUI.isTrue,
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                CFCAssets.feedbackImage5SVG,
                                fit: BoxFit.contain,
                                height: MediaQuery.of(context).size.width,
                                width: MediaQuery.of(context).size.width,
                              ),
                              const SizedBox(height: 30),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: 'Awesome! ',
                                  style: GoogleFonts.lexendDeca(
                                    fontWeight: FontWeight.w600,
                                    color: CFCAppColors.textColorDark,
                                    height: 2.0,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          'Thank you for your valuable feedback. Please tap on \'Finish\' to submit your responses and get rewarded.',
                                      style: GoogleFonts.lexendDeca(
                                        fontWeight: FontWeight.w400,
                                        color: CFCAppColors.textColorDark,
                                        height: 2.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: CFCMaterialButton(
                                onPressed: controller.showFeedback4,
                                text: 'Back',
                                width: double.infinity,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: CFCMaterialButton(
                                onPressed: () => controller.finish(courseDetails),
                                text: 'Finish',
                                width: double.infinity,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                /// save loading
                Visibility(
                  visible: controller.isSaving.isTrue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        CFCAssets.finishProgressIndicatorSVG,
                        fit: BoxFit.contain,
                        height: MediaQuery.of(context).size.width,
                        width: MediaQuery.of(context).size.width,
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            SizedBox(
                              height: 50,
                              width: 50,
                              child: LoadingIndicator(
                                indicatorType: Indicator.ballRotateChase,
                                colors: [
                                  CFCAppColors.appPrimaryColor,
                                ],
                              ),
                            ),
                            SizedBox(width: 20),
                            Flexible(
                              child: CFCAppText(
                                text: 'Sit back and relax while your information is begin saved.',
                                fontWeight: FontWeight.w500,
                                color: CFCAppColors.textColorDark,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                /// Congratulations
                Visibility(
                  visible: controller.showCongratulationUI.isTrue,
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                CFCAssets.congratulationSVG,
                                fit: BoxFit.contain,
                                height: MediaQuery.of(context).size.width / 1.5,
                                width: MediaQuery.of(context).size.width / 1.5,
                              ),
                              const SizedBox(height: 30),
                              const CFCAppText(
                                text: 'Congratulations!',
                                fontWeight: FontWeight.w600,
                                color: CFCAppColors.textColorDark,
                                textAlign: TextAlign.center,
                                fontSize: 18,
                              ),
                              const SizedBox(height: 30),
                              CFCAppText(
                                text:
                                    '${controller.isCoursesCompleted.isTrue && controller.isQuizCompleted.isTrue && controller.isFeedbackCompleted.isTrue ? 'You were just rewarded for completing your Learning and submitting your Quiz Answer & Feedback.' : ''}'
                                    '\nTo track your rewards, select the \'My Wallet\' option from the CFC Menu. '
                                    '\n\nWe cannot wait to have you back to learn more. See you soon!',
                                fontWeight: FontWeight.w400,
                                color: CFCAppColors.textColorDark,
                                height: 2.0,
                                textAlign: TextAlign.center,
                                fontSize: 14,
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: CFCMaterialButton(
                          onPressed: controller.home,
                          text: 'Home',
                          width: double.infinity,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
