import 'package:cfc/controllers/cfc_controllers.dart';
import 'package:cfc/models/cfc_models.dart';
import 'package:cfc/screens/cfc_screens.dart';
import 'package:cfc/utils/cfc_utils.dart';
import 'package:cfc/widgets/cfc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ViewCourse extends StatelessWidget {
  const ViewCourse({
    Key? key,
    required this.courseDetails,
  }) : super(key: key);

  final CourseDetails courseDetails;

  @override
  Widget build(BuildContext context) {
    final ViewCourseController controller = Get.put(ViewCourseController(courseDetails));
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
            Visibility(
              visible: controller.isCourseContinue.isTrue,
              child: IconButton(
                onPressed: () {
                  CFCHelper.showBottomAlert(
                    title: 'Are you sure?',
                    content: 'You want to skip the your learning?',
                    buttonText: 'Skip',
                    onPressed: () {
                      Get.back();
                      Get.off(() => QuizAndFeedback(courseDetails: courseDetails, isFinishedReading: false));
                    },
                  );
                },
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SfPdfViewer.network(
                  courseDetails.courseUrl,
                ),
              ),
              Visibility(
                visible: controller.isCourseContinue.isTrue,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CFCMaterialButton(
                    onPressed: () {
                      if (controller.isCourseContinue.isTrue) {
                        Get.off(() => QuizAndFeedback(courseDetails: courseDetails, isFinishedReading: true));
                      }
                    },
                    text: 'Continue',
                    width: double.infinity,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
