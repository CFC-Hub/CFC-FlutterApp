import 'package:cfc/controllers/cfc_controllers.dart';
import 'package:cfc/screens/cfc_screens.dart';
import 'package:cfc/utils/cfc_utils.dart';
import 'package:cfc/widgets/cfc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MyPopProfile extends StatelessWidget {
  const MyPopProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DashboardController dashboardController = Get.find<DashboardController>();
    return Obx(
      () =>  Scaffold(
        appBar: AppBar(
          leadingWidth: CFCConstant.leadingWidth,
          title: const CFCAppText(
            text: 'My POP Profile',
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
          child: Visibility(
            visible: dashboardController.popProfile.value.isPopProfileCreated,
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
            child: ListView(
              padding: const EdgeInsets.all(10.0),
              children: [
                CFCCard(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            child: CFCAppText(
                              text: 'Name: ',
                            ),
                          ),
                          CFCAppText(
                            text:
                            '${dashboardController.popProfile.value.firstName} ${dashboardController.popProfile.value.lastName}'
                                .toTitleCase(),
                            fontWeight: FontWeight.w600,
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Expanded(
                            child: CFCAppText(
                              text: 'Organization: ',
                              color: CFCAppColors.textColorDark,
                            ),
                          ),
                          CFCAppText(
                            text: dashboardController.popProfile.value.organisation.isEmpty
                                ? 'N/A'
                                : dashboardController.popProfile.value.organisation.toTitleCase(),
                            color: CFCAppColors.textColorDark,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                CFCCard(
                  child: Column(
                    children: [
                      Container(
                        color: CFCAppColors.tableBgGreenDark,
                        width: double.infinity,
                        height: 65,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            const Expanded(
                              child: CFCAppText(
                                text: 'A Food Producer: ',
                                maxLines: 2,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                              decoration: BoxDecoration(
                                color: CFCAppColors.appPrimaryColor,
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              child: CFCAppText(
                                text: dashboardController.popProfile.value.questions.isFoodProducer ? 'Yes' : 'No',
                                fontWeight: FontWeight.w600,
                                color: CFCAppColors.textColorLight,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        color: CFCAppColors.tableBgGreenLight,
                        width: double.infinity,
                        height: 65,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            const Expanded(
                              child: CFCAppText(
                                text: 'In logistics/ supply chain in the food industry: ',
                                maxLines: 2,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                              decoration: BoxDecoration(
                                color: CFCAppColors.appPrimaryColor,
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              child: CFCAppText(
                                text: dashboardController.popProfile.value.questions.inLogistics ? 'Yes' : 'No',
                                fontWeight: FontWeight.w600,
                                color: CFCAppColors.textColorLight,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        color: CFCAppColors.tableBgGreenDark,
                        width: double.infinity,
                        height: 65,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            const Expanded(
                              child: CFCAppText(
                                text: 'In public administration: ',
                                maxLines: 2,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                              decoration: BoxDecoration(
                                color: CFCAppColors.appPrimaryColor,
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              child: CFCAppText(
                                text: dashboardController.popProfile.value.questions.inPublicAdministration
                                    ? 'Yes'
                                    : 'No',
                                fontWeight: FontWeight.w600,
                                color: CFCAppColors.textColorLight,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        color: CFCAppColors.tableBgGreenLight,
                        width: double.infinity,
                        height: 65,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            const Expanded(
                              child: CFCAppText(
                                text: 'In Agri-Food Research: ',
                                maxLines: 2,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                              decoration: BoxDecoration(
                                color: CFCAppColors.appPrimaryColor,
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              child: CFCAppText(
                                text: dashboardController.popProfile.value.questions.inAgriFoodResearch ? 'Yes' : 'No',
                                fontWeight: FontWeight.w600,
                                color: CFCAppColors.textColorLight,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        color: CFCAppColors.tableBgGreenDark,
                        width: double.infinity,
                        height: 65,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            const Expanded(
                              child: CFCAppText(
                                text: 'Involved in technology relating to Agri-Food: ',
                                maxLines: 2,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                              decoration: BoxDecoration(
                                color: CFCAppColors.appPrimaryColor,
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              child: CFCAppText(
                                text:
                                dashboardController.popProfile.value.questions.inTechnologyAgriFood ? 'Yes' : 'No',
                                fontWeight: FontWeight.w600,
                                color: CFCAppColors.textColorLight,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                CFCCard(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: CFCAppText(
                          text: 'CrowdField Companion tagline:',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: CFCAppColors.textColorDark,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CFCAppText(
                          text: 'I believe the future of food is ${dashboardController.popProfile.value.tagline}',
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
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: CFCAppText(
                          text: 'How did you hear about the CFC Project? ',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: CFCAppColors.textColorDark,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CFCAppText(
                          text: dashboardController.popProfile.value.aboutCfcProject.toCapitalized(),
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: CFCAppColors.textColorDark,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 70),
              ],
            ),
          ),
        ),
        floatingActionButton: dashboardController.popProfile.value.isPopProfileCreated ? FloatingActionButton.extended(
          onPressed: () => Get.to(() => const EditPopProfile()),
          icon: const Icon(
            Icons.edit,
            color: Colors.white,
          ),
          label: const CFCAppText(
            text: 'Edit POP Profile',
            color: CFCAppColors.textColorLight,
          ),
        ) : null,
      ),
    );
  }
}
