import 'package:cfc/controllers/cfc_controllers.dart';
import 'package:cfc/utils/cfc_utils.dart';
import 'package:cfc/widgets/cfc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CreatePopProfile extends StatelessWidget {
  const CreatePopProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CreatePopProfileController controller = Get.put(CreatePopProfileController());
    return Scaffold(
      appBar: AppBar(
        leadingWidth: CFCConstant.leadingWidth,
        title: const CFCAppText(
          text: 'New POP Profile',
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
                                text: '1. Please fill your Name and Organisation (if any):',
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: CFCAppColors.textColorDark,
                              ),
                            ),
                            const SizedBox(height: 20),
                            CFCTextFormField(
                              controller: controller.firstNameController,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'First Name cannot be empty';
                                }
                                return null;
                              },
                              onChanged: (String text) {},
                              hintText: 'First Name',
                              labelText: 'First Name',
                            ),
                            const SizedBox(height: 20),
                            CFCTextFormField(
                              controller: controller.lastNameController,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Last Name cannot be empty';
                                }
                                return null;
                              },
                              onChanged: (String text) {},
                              hintText: 'Last Name',
                              labelText: 'Last Name',
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
                                  text: '2. Please answer YES or NO to each of the following. Are you:',
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
                                text: '3. Create your CrowdField Companion tagline:',
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
                      const SizedBox(height: 20),
                      CFCCard(
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: CFCAppText(
                                  text: '4. How did you hear about the CFC Project?',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: CFCAppColors.textColorDark,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: CFCAppText(
                                  text: 'Please select one option',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: CFCAppColors.textColorDark,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            InkWell(
                              onTap: () {
                                controller.knownCfcSelected.value = 'website';
                              },
                              child: Container(
                                color: CFCAppColors.tableBgGreenDark,
                                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: Radio(
                                        value: 'website',
                                        groupValue: controller.knownCfcSelected.value,
                                        onChanged: (String? value) {
                                          controller.knownCfcSelected.value = value!;
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const CFCAppText(
                                      text: 'Website',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: CFCAppColors.textColorDark,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                controller.knownCfcSelected.value = 'social channels';
                              },
                              child: Container(
                                color: CFCAppColors.tableBgGreenLight,
                                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: Radio(
                                        value: 'social channels',
                                        groupValue: controller.knownCfcSelected.value,
                                        onChanged: (String? value) {
                                          controller.knownCfcSelected.value = value!;
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const CFCAppText(
                                      text: 'Social Channels',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: CFCAppColors.textColorDark,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                controller.knownCfcSelected.value = 'attended a webinar';
                              },
                              child: Container(
                                color: CFCAppColors.tableBgGreenDark,
                                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: Radio(
                                        value: 'attended a webinar',
                                        groupValue: controller.knownCfcSelected.value,
                                        onChanged: (String? value) {
                                          controller.knownCfcSelected.value = value!;
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const CFCAppText(
                                      text: 'Attended a webinar',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: CFCAppColors.textColorDark,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                controller.knownCfcSelected.value = 'word of mouth';
                              },
                              child: Container(
                                color: CFCAppColors.tableBgGreenLight,
                                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: Radio(
                                        value: 'word of mouth',
                                        groupValue: controller.knownCfcSelected.value,
                                        onChanged: (String? value) {
                                          controller.knownCfcSelected.value = value!;
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const CFCAppText(
                                      text: 'Word of Mouth',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: CFCAppColors.textColorDark,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                controller.knownCfcSelected.value = 'other';
                              },
                              child: Container(
                                color: CFCAppColors.tableBgGreenDark,
                                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: Radio(
                                        value: 'other',
                                        groupValue: controller.knownCfcSelected.value,
                                        onChanged: (String? value) {
                                          controller.knownCfcSelected.value = value!;
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const CFCAppText(
                                      text: 'Other',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: CFCAppColors.textColorDark,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      CFCMaterialButton(
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (!controller.formKey.currentState!.validate()) {
                            return;
                          }
                          Get.bottomSheet(
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              margin: const EdgeInsets.all(10.0),
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 10),
                                  const CFCAppText(
                                    text: 'Are you sure?',
                                    color: CFCAppColors.textColorDark,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                  const SizedBox(height: 20),
                                  const CFCAppText(
                                    text: 'First Name and Last Name cannot be change once saved.',
                                    color: CFCAppColors.textColorDark,
                                    fontWeight: FontWeight.w400,
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 30),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const CFCAppText(
                                          text: 'First Name: ',
                                          color: CFCAppColors.textColorDark,
                                          fontWeight: FontWeight.w600,
                                          maxLines: 2,
                                        ),
                                        Expanded(
                                          child: CFCAppText(
                                            text: controller.firstNameController.text.trim(),
                                            color: CFCAppColors.textColorDark,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const CFCAppText(
                                          text: 'Last Name: ',
                                          color: CFCAppColors.textColorDark,
                                          fontWeight: FontWeight.w600,
                                          maxLines: 2,
                                        ),
                                        Expanded(
                                          child: CFCAppText(
                                            text: controller.lastNameController.text.trim(),
                                            color: CFCAppColors.textColorDark,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CFCMaterialButton(
                                          text: 'Edit',
                                          buttonBackgroundColor: CFCAppColors.lightGreenButtonColor,
                                          buttonBorderColor: CFCAppColors.lightGreenButtonColor,
                                          onPressed: () => Get.back(),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: CFCMaterialButton(
                                          text: 'Continue',
                                          onPressed: () {
                                            Get.back();
                                            controller.createPopProfile();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        text: 'Continue',
                        width: double.infinity,
                      ),
                    ],
                  ),
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

              /// pop profile created message
              Visibility(
                visible: controller.isPopProfileCreated.isTrue,
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
                                      text: 'Your POP Profile was created and an NFT was awarded to you.'
                                          '\n\nYou many now browse Learning Material and begin your learning journey. ',
                                      style: GoogleFonts.lexendDeca(
                                        fontWeight: FontWeight.w400,
                                        color: CFCAppColors.textColorDark,
                                        height: 2.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Happy Learning!',
                                      style: GoogleFonts.lexendDeca(
                                        fontWeight: FontWeight.w600,
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
                          onPressed: () => Get.back(),
                          text: 'Continue',
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
