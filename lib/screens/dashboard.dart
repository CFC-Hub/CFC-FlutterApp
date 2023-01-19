import 'package:cfc/controllers/cfc_controllers.dart';
import 'package:cfc/models/cfc_models.dart';
import 'package:cfc/screens/cfc_screens.dart';
import 'package:cfc/screens/my_feedback.dart';
import 'package:cfc/utils/cfc_utils.dart';
import 'package:cfc/widgets/cfc_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DashboardController controller = Get.put(DashboardController());
    return AdvancedDrawer(
      controller: controller.advancedDrawerController,
      backdropColor: CFCAppColors.appPrimaryColor,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      openScale: 1,
      childDecoration: const BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black,
            blurRadius: 4.0,
          ),
        ],
      ),
      drawer: SafeArea(
        bottom: false,
        child: Obx(
          () => Column(
            children: [
              Image.asset(
                CFCAssets.appLogoWhitePNG,
                width: 180,
                height: 180,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CFCAppText(
                  text: controller.popProfile.value.firstName.toTitleCase(),
                  fontSize: 20,
                  color: CFCAppColors.textColorLight,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  color: CFCAppColors.primaryBackground,
                  child: ListView(
                    children: [
                      const SizedBox(height: 20),
                      if (controller.popProfile.value.isPopProfileCreated) ...[
                        CFCDrawerMenu(
                          onTap: () {
                            controller.advancedDrawerController.hideDrawer();
                            Get.to(() => const MyPopProfile());
                          },
                          imagePathSVG: CFCAssets.myPopProfileSVG,
                          title: 'My POP Profile',
                        ),
                        CFCDrawerMenu(
                          onTap: () {
                            controller.advancedDrawerController.hideDrawer();
                            Get.to(() => const MyWallet());
                          },
                          imagePathSVG: CFCAssets.myWalletSVG,
                          title: 'My Wallet',
                        ),
                        CFCDrawerMenu(
                          onTap: () {
                            controller.advancedDrawerController.hideDrawer();
                            Get.to(() => const MyCourses());
                          },
                          imagePathSVG: CFCAssets.myCoursesSVG,
                          title: 'My Courses',
                        ),
                        ListTile(
                          onTap: () {
                            controller.advancedDrawerController.hideDrawer();
                            Get.to(() => const BrowseCourses());
                          },
                          leading: const Icon(
                            CupertinoIcons.collections_solid,
                            color: CFCAppColors.iconColorDark,
                          ),
                          title: const CFCAppText(
                            text: 'Browse Courses',
                            color: CFCAppColors.textColorDark,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        CFCDrawerMenu(
                          onTap: () {
                            controller.advancedDrawerController.hideDrawer();
                            Get.to(() => const MyFeedback());
                          },
                          imagePathSVG: CFCAssets.myFeedbackSVG,
                          title: 'My Feedback',
                        ),
                      ],
                      CFCDrawerMenu(
                        onTap: () {
                          controller.advancedDrawerController.hideDrawer();
                          Get.to(() => const Settings());
                        },
                        imagePathSVG: CFCAssets.settingsSVG,
                        title: 'Settings',
                      ),
                      CFCDrawerMenu(
                        onTap: () {
                          controller.advancedDrawerController.hideDrawer();
                          Get.to(() => const HelpAndFAQ());
                        },
                        imagePathSVG: CFCAssets.helpAndFaqSVG,
                        title: 'Help and FAQ',
                      ),
                      CFCDrawerMenu(
                        onTap: () {
                          controller.advancedDrawerController.hideDrawer();
                          controller.logout();
                        },
                        imagePathSVG: CFCAssets.logoutSVG,
                        title: 'Logout',
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: CFCAppColors.primaryBackground,
                child: SafeArea(
                  top: false,
                  child: CFCDrawerMenu(
                    onTap: () {
                      controller.advancedDrawerController.hideDrawer();
                    },
                    imagePathSVG: CFCAssets.licensesAndAttributionSVG,
                    title: 'Licenses & Attribution',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: CFCConstant.leadingWidth,
          title: const CFCAppText(
            text: 'Dashboard',
            fontWeight: FontWeight.w700,
            color: CFCAppColors.textColorLight,
          ),
          leading: IconButton(
            onPressed: () => controller.advancedDrawerController.showDrawer(),
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: controller.advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.close : Icons.menu_rounded,
                    key: ValueKey<bool>(value.visible),
                    // color: WCThemes.colorAccent,
                  ),
                );
              },
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
              visible: controller.isHiveLoaded.isTrue,
              replacement: const Center(child: CFCWidgetHelper.loadingWidget),
              child: Visibility(
                visible: controller.popProfile.value.isPopProfileCreated,
                replacement: Column(
                  children: [
                    SvgPicture.asset(
                      CFCAssets.emptyDashboardSVG,
                      fit: BoxFit.contain,
                      height: MediaQuery.of(context).size.width,
                      width: MediaQuery.of(context).size.width,
                    ),
                    const Spacer(),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'You have not created your POP Profile yet.'
                            '\nTo create one, tap on the ',
                        style: GoogleFonts.lexendDeca(
                          fontWeight: FontWeight.w400,
                          color: CFCAppColors.textColorDark,
                          height: 2.0,
                        ),
                        children: [
                          TextSpan(
                            text: 'Create POP Profile',
                            style: GoogleFonts.lexendDeca(
                              fontWeight: FontWeight.w600,
                              color: CFCAppColors.textColorDark,
                              height: 2.0,
                            ),
                          ),
                          TextSpan(
                            text: '\nbutton below.',
                            style: GoogleFonts.lexendDeca(
                              fontWeight: FontWeight.w400,
                              color: CFCAppColors.textColorDark,
                              height: 2.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CFCMaterialButton(
                        onPressed: () {},
                        text: 'What is a POP Profile? and why do I need it?',
                        width: double.infinity,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontColor: CFCAppColors.textColorDark,
                        buttonBackgroundColor: CFCAppColors.appPrimaryColor.withOpacity(0.32),
                        buttonBorderColor: CFCAppColors.appPrimaryColor.withOpacity(0.32),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CFCMaterialButton(
                        onPressed: () => Get.to(() => const CreatePopProfile()),
                        text: 'Create POP Profile',
                        width: double.infinity,
                      ),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(10),
                        children: [
                          CFCCard(
                            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CFCAppText(
                                      text: controller.myCourseDetails.length.toString(),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 40,
                                      color: CFCAppColors.textColorDark,
                                    ),
                                    const SizedBox(height: 10),
                                    CFCAppText(
                                      text: controller.myCourseDetails.length > 1 ? 'Courses Taken' : 'Course Taken',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: CFCAppColors.textColorDark,
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CFCAppText(
                                      text: controller.totalCourses.value.toString(),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 40,
                                      color: CFCAppColors.textColorDark,
                                    ),
                                    const SizedBox(height: 10),
                                    CFCAppText(
                                      text: controller.totalCourses > 1 ? 'Courses Available' : 'Course Available',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: CFCAppColors.textColorDark,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Visibility(
                            visible: controller.myCourseDetails.isNotEmpty,
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: CFCAppText(
                                    text: 'My Courses',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: CFCAppColors.textColorDark,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                CFCCard(
                                  child: ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: controller.myCourseDetails.length,
                                    itemBuilder: (context, index) {
                                      MyCourseDetails myCourseDetails = controller.myCourseDetails[index];
                                      return InkWell(
                                        onTap: () => Get.to(() => ViewMyCourse(myCourses: myCourseDetails)),
                                        child: Container(
                                          color: index % 2 == 0
                                              ? CFCAppColors.tableBgGreenDark
                                              : CFCAppColors.tableBgGreenLight,
                                          padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 20),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: CFCAppText(
                                                  text: myCourseDetails.courseName,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  color: CFCAppColors.textColorDark,
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              SvgPicture.asset(
                                                myCourseDetails.isCourseCompleted &&
                                                        myCourseDetails.isQuizCompleted &&
                                                        myCourseDetails.isFeedbackCompleted
                                                    ? CFCAssets.courseCompletedSVG
                                                    : CFCAssets.courseInProgressSVG,
                                                height: 30,
                                                width: 30,
                                              ),
                                              const SizedBox(width: 10),
                                              SvgPicture.asset(
                                                CFCAssets.rightArrowSVG,
                                                color: CFCAppColors.appPrimaryColor,
                                                height: 25,
                                                width: 25,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          const CFCAppText(
                            text: 'Top Ten Courses',
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: CFCAppColors.textColorDark,
                          ),
                          const SizedBox(height: 10),
                          Visibility(
                            visible: controller.topTenCourses.isNotEmpty,
                            child: CFCCard(
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.topTenCourses.length,
                                itemBuilder: (context, index) {
                                  CourseDetails course = controller.topTenCourses[index];
                                  return InkWell(
                                    onTap: () => Get.to(() => ViewCourse(courseDetails: course)),
                                    child: Container(
                                      color: index % 2 == 0
                                          ? CFCAppColors.tableBgGreenDark
                                          : CFCAppColors.tableBgGreenLight,
                                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Flexible(
                                                  fit: FlexFit.loose,
                                                  child: CFCAppText(
                                                    text: course.courseName,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                    color: CFCAppColors.textColorDark,
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                const SizedBox(width: 5),
                                                AbsorbPointer(
                                                  absorbing: true,
                                                  child: RatingBar(
                                                    initialRating: course.rating,
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: course.rating.toInt(),
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
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CFCMaterialButton(
                        onPressed: () => Get.to(() => const BrowseCourses()),
                        text: 'Browse All Courses',
                        width: double.infinity,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
