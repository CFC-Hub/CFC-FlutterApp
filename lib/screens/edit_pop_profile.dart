import 'package:cfc/controllers/cfc_controllers.dart';
import 'package:cfc/utils/cfc_utils.dart';
import 'package:cfc/widgets/cfc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

class EditPopProfile extends StatelessWidget {
  const EditPopProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EditPopProfileController controller = Get.put(EditPopProfileController());
    return Scaffold(
      appBar: AppBar(
        leadingWidth: CFCConstant.leadingWidth,
        title: const CFCAppText(
          text: 'Edit POP Profile',
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
          () => Stack(
            children: [
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            CFCCard(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: CFCAppText(
                                      text: '1. Update your Organisation (if any):',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: CFCAppColors.textColorDark,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  CFCTextFormField(
                                    controller: controller.organisationController,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    onChanged: (String text) {},
                                    hintText: 'Organisation (optional)',
                                    labelText: 'Organisation (optional)',
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            CFCCard(
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: CFCAppText(
                                        text:
                                            '2. Please updated your answer YES or NO to each of the following. Are you:',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: CFCAppColors.textColorDark,
                                      ),
                                    ),
                                  ),
                                  const Divider(
                                    height: 0.75,
                                    thickness: 0.75,
                                    color: CFCAppColors.textColorDark,
                                  ),
                                  Container(
                                    color: CFCAppColors.tableBgGreenDark,
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const CFCAppText(
                                          text: 'Are you a Food Producer?',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: CFCAppColors.textColorDark,
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: Radio(
                                                value: 'yes',
                                                groupValue: controller.foodProducer.value,
                                                onChanged: (String? value) {
                                                  controller.foodProducer.value = value!;
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            const CFCAppText(
                                              text: 'Yes',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: CFCAppColors.textColorDark,
                                            ),
                                            const SizedBox(width: 30),
                                            SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: Radio(
                                                value: 'no',
                                                groupValue: controller.foodProducer.value,
                                                onChanged: (String? value) {
                                                  controller.foodProducer.value = value!;
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            const CFCAppText(
                                              text: 'No',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: CFCAppColors.textColorDark,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    color: CFCAppColors.tableBgGreenLight,
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const CFCAppText(
                                          text: 'Are you in logistics/ supply chain in the food industry?',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: CFCAppColors.textColorDark,
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: Radio(
                                                value: 'yes',
                                                groupValue: controller.logistics.value,
                                                onChanged: (String? value) {
                                                  controller.logistics.value = value!;
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            const CFCAppText(
                                              text: 'Yes',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: CFCAppColors.textColorDark,
                                            ),
                                            const SizedBox(width: 30),
                                            SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: Radio(
                                                value: 'no',
                                                groupValue: controller.logistics.value,
                                                onChanged: (String? value) {
                                                  controller.logistics.value = value!;
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            const CFCAppText(
                                              text: 'No',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: CFCAppColors.textColorDark,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    color: CFCAppColors.tableBgGreenDark,
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const CFCAppText(
                                          text: 'Are you in public administration?',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: CFCAppColors.textColorDark,
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: Radio(
                                                value: 'yes',
                                                groupValue: controller.publicAdministration.value,
                                                onChanged: (String? value) {
                                                  controller.publicAdministration.value = value!;
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            const CFCAppText(
                                              text: 'Yes',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: CFCAppColors.textColorDark,
                                            ),
                                            const SizedBox(width: 30),
                                            SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: Radio(
                                                value: 'no',
                                                groupValue: controller.publicAdministration.value,
                                                onChanged: (String? value) {
                                                  controller.publicAdministration.value = value!;
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            const CFCAppText(
                                              text: 'No',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: CFCAppColors.textColorDark,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    color: CFCAppColors.tableBgGreenLight,
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const CFCAppText(
                                          text: 'Are you in Agri-Food Research?',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: CFCAppColors.textColorDark,
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: Radio(
                                                value: 'yes',
                                                groupValue: controller.agriFoodResearch.value,
                                                onChanged: (String? value) {
                                                  controller.agriFoodResearch.value = value!;
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            const CFCAppText(
                                              text: 'Yes',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: CFCAppColors.textColorDark,
                                            ),
                                            const SizedBox(width: 30),
                                            SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: Radio(
                                                value: 'no',
                                                groupValue: controller.agriFoodResearch.value,
                                                onChanged: (String? value) {
                                                  controller.agriFoodResearch.value = value!;
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            const CFCAppText(
                                              text: 'No',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: CFCAppColors.textColorDark,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    color: CFCAppColors.tableBgGreenDark,
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const CFCAppText(
                                          text: 'Are you involved in technology relating to Agri-Food?',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: CFCAppColors.textColorDark,
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: Radio(
                                                value: 'yes',
                                                groupValue: controller.technologyAgriFood.value,
                                                onChanged: (String? value) {
                                                  controller.technologyAgriFood.value = value!;
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            const CFCAppText(
                                              text: 'Yes',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: CFCAppColors.textColorDark,
                                            ),
                                            const SizedBox(width: 30),
                                            SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: Radio(
                                                value: 'no',
                                                groupValue: controller.technologyAgriFood.value,
                                                onChanged: (String? value) {
                                                  controller.technologyAgriFood.value = value!;
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            const CFCAppText(
                                              text: 'No',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: CFCAppColors.textColorDark,
                                            ),
                                          ],
                                        ),
                                      ],
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
                                      text: '3. Update your CrowdField Companion tagline:',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: CFCAppColors.textColorDark,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: CFCAppText(
                                      text: 'I believe the future of food is...',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: CFCAppColors.textColorDark,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  CFCTextFormField(
                                    controller: controller.taglineController,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Tagline cannot be empty';
                                      }
                                      return null;
                                    },
                                    onChanged: (String text) {},
                                    hintText: 'Type your tagline...',
                                    labelText: 'Tagline',
                                    minLines: 6,
                                    maxLines: 10,
                                  ),
                                  const SizedBox(height: 10),
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
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                Get.back();
                              },
                              text: 'Cancel',
                              width: double.infinity,
                              buttonBackgroundColor: CFCAppColors.lightGreenButtonColor,
                              buttonBorderColor: CFCAppColors.lightGreenButtonColor,
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: CFCMaterialButton(
                              onPressed: controller.updatePopProfile,
                              text: 'Updated',
                              width: double.infinity,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              /// saving cfc pop profile loading
              Visibility(
                visible: controller.isSavingProfile.isTrue,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: CFCAppColors.backgroundOverlayWhite,
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        CFCAssets.progressSavingPopProfileSVG,
                        fit: BoxFit.contain,
                        height: MediaQuery.of(context).size.width,
                        width: MediaQuery.of(context).size.width,
                      ),
                      const SizedBox(height: 20),
                      Row(
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
                              text: 'Saving your POP Profile...',
                              fontWeight: FontWeight.w500,
                              color: CFCAppColors.textColorDark,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              /// pop profile updated message
              Visibility(
                visible: controller.isProfileUpdated.isTrue,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: CFCAppColors.backgroundOverlayWhite,
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
                              const CFCAppText(
                                text: 'Your POP Profile was updated.',
                                fontWeight: FontWeight.w600,
                                color: CFCAppColors.textColorDark,
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CFCMaterialButton(
                          onPressed: () => Get.back(),
                          text: 'Back',
                          width: double.infinity,
                        ),
                      ),
                    ],
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
