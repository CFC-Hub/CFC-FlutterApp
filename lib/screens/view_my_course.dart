import 'package:cfc/controllers/cfc_controllers.dart';
import 'package:cfc/models/cfc_models.dart';
import 'package:cfc/screens/cfc_screens.dart';
import 'package:cfc/utils/cfc_utils.dart';
import 'package:cfc/widgets/cfc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ViewMyCourse extends StatelessWidget {
  const ViewMyCourse({Key? key, required this.myCourses}) : super(key: key);

  final MyCourseDetails myCourses;

  @override
  Widget build(BuildContext context) {
    final ViewMyCourseController controller = Get.put(ViewMyCourseController(myCourses.obs));
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leadingWidth: CFCConstant.leadingWidth,
          title: SizedBox(
            width: 300,
            child: CFCAppText(
              text: '${myCourses.courseId} - ${myCourses.courseName}',
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
            Visibility(
              visible: !myCourses.isCourseCompleted && !controller.showCoursesCompletedUI.value,
              child: IconButton(
                onPressed: () {
                  CFCHelper.showBottomAlert(
                    title: 'Are you sure?',
                    content: 'You want to skip the your learning?',
                    buttonText: 'Skip',
                    onPressed: () {
                      Get.back();
                      Get.off(() => UpdateQuizAndFeedback(myCourses: myCourses));
                    },
                  );
                },
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Visibility(
                visible: controller.showCourse.value,
                child: Column(
                  children: [
                    Expanded(
                      child: SfPdfViewer.network(
                        myCourses.courseUrl,
                      ),
                    ),
                    Visibility(
                      visible: !controller.myCourses.value.isCourseCompleted ||
                          !controller.myCourses.value.isQuizCompleted ||
                          !controller.myCourses.value.isFeedbackCompleted,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CFCMaterialButton(
                          onPressed: controller.continueButton,
                          text: !myCourses.isCourseCompleted
                              ? 'Continue'
                              : !myCourses.isQuizCompleted
                                  ? 'Continue to Quiz'
                                  : !myCourses.isFeedbackCompleted
                                      ? 'Continue to Feedback'
                                      : '',
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// save loading
              Visibility(
                visible: controller.isSaving.isTrue,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: CFCAppColors.backgroundOverlayWhite,
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
              ),

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
                                    text: !myCourses.isQuizCompleted
                                        ? 'Now that you have finished reading.  Let\'s take a short Quiz to recap on what you learnt.'
                                        : !myCourses.isFeedbackCompleted
                                            ? 'Now that you have finished reading.  Please tap on \'Continue\' to leave a feedback.'
                                            : '',
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
                        onPressed: controller.continueButton,
                        text: !controller.myCourses.value.isQuizCompleted
                            ? 'Continue to Quiz'
                            : !controller.myCourses.value.isFeedbackCompleted
                                ? 'Continue to Feedback'
                                : 'Home',
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
    );
  }
}
