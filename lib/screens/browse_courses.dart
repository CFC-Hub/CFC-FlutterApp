import 'package:cfc/controllers/cfc_controllers.dart';
import 'package:cfc/models/cfc_models.dart';
import 'package:cfc/screens/cfc_screens.dart';
import 'package:cfc/utils/cfc_utils.dart';
import 'package:cfc/widgets/cfc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class BrowseCourses extends StatelessWidget {
  const BrowseCourses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BrowseCourseController controller = Get.put(BrowseCourseController());
    return Scaffold(
      appBar: AppBar(
        leadingWidth: CFCConstant.leadingWidth,
        title: const CFCAppText(
          text: 'Browse Courses',
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
            visible: controller.isLoading.isFalse,
            replacement: const Center(child: CFCWidgetHelper.loadingWidget),
            child: Visibility(
              visible: controller.courses.isNotEmpty,
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
                    text: 'Sorry!',
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
                      'There are no learning material to display. \nPlease check again later.',
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
                  itemCount: controller.courses.length,
                  itemBuilder: (context, index) {
                    CourseDetails details = controller.courses[index];
                    return InkWell(
                      onTap: () => Get.to(() => ViewCourse(courseDetails: details)),
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
                                      AbsorbPointer(
                                        absorbing: true,
                                        child: RatingBar(
                                          initialRating: details.rating,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: details.rating.toInt(),
                                          itemSize: 25,
                                          itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                                          onRatingUpdate: (rating) {},
                                          ratingWidget: RatingWidget(
                                            full: SvgPicture.asset(
                                              CFCAssets.starSVG,
                                              color: CFCAppColors.orangeColor,
                                              height: 20,
                                              width: 20,
                                            ),
                                            half: SvgPicture.asset(
                                              CFCAssets.halfStarSVG,
                                              color: CFCAppColors.orangeColor,
                                              height: 20,
                                              width: 20,
                                            ),
                                            empty: const SizedBox.shrink(),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10.0),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 5.0),
                                        child: CFCAppText(
                                          text: details.rating.toString(),
                                          fontWeight: FontWeight.w500,
                                          color: CFCAppColors.orangeColor,
                                        ),
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
