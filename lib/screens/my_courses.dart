import 'package:cfc/controllers/cfc_controllers.dart';
import 'package:cfc/models/cfc_models.dart';
import 'package:cfc/screens/cfc_screens.dart';
import 'package:cfc/utils/cfc_utils.dart';
import 'package:cfc/widgets/cfc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class MyCourses extends StatelessWidget {
  const MyCourses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DashboardController dashboardController = Get.find<DashboardController>();
    return Scaffold(
      appBar: AppBar(
        leadingWidth: CFCConstant.leadingWidth,
        title: const CFCAppText(
          text: 'My Courses',
          fontWeight: FontWeight.w700,
          color: CFCAppColors.textColorLight,
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_outlined,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Image.asset(
              CFCAssets.cfcLogoWhitePNG,
              color: CFCAppColors.iconColorLight,
              height: 35,
              width: 35,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(
          () => Visibility(
            visible: dashboardController.isLoadingMyCourses.isFalse,
            replacement: const Center(child: CFCWidgetHelper.loadingWidget),
            child: Visibility(
              visible: dashboardController.myCourseDetails.isNotEmpty,
              replacement: ListView(
                children: [
                  SvgPicture.asset(
                    CFCAssets.emptyDashboardSVG,
                    fit: BoxFit.contain,
                    height: MediaQuery.of(context).size.width,
                    width: MediaQuery.of(context).size.width,
                  ),
                  const SizedBox(height: 30),
                  const CFCAppText(
                    text: 'Well...',
                    fontWeight: FontWeight.w600,
                    color: CFCAppColors.textColorDark,
                    textAlign: TextAlign.center,
                    fontSize: 18,
                  ),
                  const SizedBox(height: 30),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: CFCAppText(
                      text:
                      'It looks like you haven\'t selected any learning module yet and there is nothing to show. '
                          '\n\nYou can select a learning module from the \nCFC Menu > Browse Courses option.',
                      fontWeight: FontWeight.w400,
                      color: CFCAppColors.textColorDark,
                      height: 2.0,
                      textAlign: TextAlign.center,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
              child: CFCCard(
                margin: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: dashboardController.myCourseDetails.length,
                  itemBuilder: (context, index) {
                    MyCourseDetails details = dashboardController.myCourseDetails[index];
                    return InkWell(
                      onTap: () => Get.to(() => ViewMyCourse(myCourses: details)),
                      child: Container(
                        color: index % 2 == 0 ? CFCAppColors.tableBgGreenDark : CFCAppColors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: details.courseDisplayPicture.isNotEmpty
                                  ? Image.network(
                                      details.courseDisplayPicture,
                                      height: 80,
                                      width: 80,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      color: Colors.grey.withOpacity(0.5),
                                      height: 80,
                                      width: 80,
                                      padding: const EdgeInsets.fromLTRB(12.0, 10.0, 8.0, 10.0),
                                      child: SvgPicture.asset(
                                        CFCAssets.bookPlaceholderSVG,
                                        height: 30,
                                        width: 30,
                                        fit: BoxFit.contain,
                                        color: CFCAppColors.appPrimaryColor,
                                      ),
                                    ),
                            ),
                            const SizedBox(width: 15.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CFCAppText(
                                    text: details.courseName,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  const SizedBox(height: 10.0),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        details.isCourseCompleted &&
                                                details.isQuizCompleted &&
                                                details.isFeedbackCompleted
                                            ? CFCAssets.courseCompletedSVG
                                            : CFCAssets.courseInProgressSVG,
                                        height: 25,
                                        width: 25,
                                      ),
                                      const SizedBox(width: 10),
                                      CFCAppText(
                                        text: details.isCourseCompleted ? 'Completed' : 'Pending',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 5),
                            SvgPicture.asset(
                              CFCAssets.rightArrowSVG,
                              color: CFCAppColors.appPrimaryColor,
                              height: 25,
                              width: 25,
                            ),
                            const SizedBox(width: 5),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
