import 'dart:io';

import 'package:cfc/controllers/cfc_controllers.dart';
import 'package:cfc/screens/cfc_screens.dart';
import 'package:cfc/utils/cfc_utils.dart';
import 'package:cfc/widgets/cfc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CreatePassword extends StatelessWidget {
  const CreatePassword({Key? key, required this.emailAddress}) : super(key: key);

  final String emailAddress;

  @override
  Widget build(BuildContext context) {
    final CreatePasswordController controller = Get.put(CreatePasswordController());
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(CFCAssets.cfcBackgroundJPG),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: CFCAppColors.foregroundColorLight,
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    CFCAssets.appLogoWhitePNG,
                    color: CFCAppColors.iconColorLight,
                    height: 150,
                    width: 150,
                  ),
                ),
              ),
              Obx(
                () => Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(28.0),
                        topRight: Radius.circular(28.0),
                      ),
                    ),
                    child: SafeArea(
                      top: false,
                      child: Visibility(
                        visible: controller.isLoading.isFalse,
                        replacement: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              CFCAssets.otpValidationProgressSVG,
                              fit: BoxFit.fitWidth,
                              height: 450,
                              width: double.infinity,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: LoadingIndicator(
                                      indicatorType: Indicator.ballRotateChase,
                                      colors: [
                                        CFCAppColors.loadingColorLight,
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: CFCAppText(
                                      text: 'Please wait... This will just be a moment.',
                                      fontWeight: FontWeight.w400,
                                      color: CFCAppColors.textColorLight,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                        child: Visibility(
                          visible: controller.isAccountCreated.isFalse,
                          replacement: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 40),
                                SvgPicture.asset(
                                  CFCAssets.successLightSVG,
                                  fit: BoxFit.cover,
                                  height: 300,
                                  width: double.infinity,
                                ),
                                const SizedBox(height: 30),
                                const CFCAppText(
                                  text: 'Congratulations on becoming a member.',
                                  color: CFCAppColors.textColorLight,
                                  textAlign: TextAlign.center,
                                  fontWeight: FontWeight.w500,
                                ),
                                const SizedBox(height: 10),
                                CFCAppText(
                                  text: 'Please make sure you have METAMASK Wallet App on this device. '
                                      'If you do not have it yet, you can download it from '
                                      'the ${Platform.isAndroid ? 'Play Store' : Platform.isIOS ? 'App Store' : ''}.',
                                  color: CFCAppColors.textColorLight,
                                  fontSize: 14,
                                  textAlign: TextAlign.center,
                                  height: 1.7,
                                ),
                                const SizedBox(height: 30),
                                CFCMaterialButton(
                                  onPressed: () => Get.offAll(() => const Dashboard()),
                                  text: 'Continue',
                                  width: double.infinity,
                                ),
                                const SizedBox(height: 30),
                                const CFCAppText(
                                  text: 'What is METAMASK? and why do I need it?',
                                  color: CFCAppColors.textColorLight,
                                  textAlign: TextAlign.center,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(3.0, 3.0),
                                      blurRadius: 5.0,
                                      color: Colors.black54,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                          child: Form(
                            key: controller.createPasswordFormKey,
                            child: ListView(
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(20.0),
                              children: [
                                const SizedBox(height: 40),
                                const Align(
                                  alignment: Alignment.center,
                                  child: CFCAppText(
                                    text: 'Create a Password',
                                    color: CFCAppColors.textColorLight,
                                    fontWeight: FontWeight.w700,
                                    textAlign: TextAlign.center,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Align(
                                  alignment: Alignment.center,
                                  child: CFCAppText(
                                    text: 'Your Password should:',
                                    color: CFCAppColors.textColorLight,
                                    fontWeight: FontWeight.w500,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.center,
                                  child: CFCAppText(
                                    text: '${String.fromCharCode(0x2713)} Be at least 8 letters long.\n'
                                        '${String.fromCharCode(0x2713)} Include at least once CAPITAL letter.\n'
                                        '${String.fromCharCode(0x2713)} Include at least one Number.',
                                    color: CFCAppColors.textColorLight,
                                    fontSize: 14,
                                    textAlign: TextAlign.center,
                                    height: 1.7,
                                  ),
                                ),
                                const SizedBox(height: 40),
                                Container(
                                  decoration: BoxDecoration(
                                    color: CFCAppColors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                                  child: TextFormField(
                                    obscureText: true,
                                    controller: controller.passwordController,
                                    textInputAction: TextInputAction.next,
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Password cannot be empty';
                                      } else if (value.length < 8) {
                                        return 'The password must be at least 8 characters long.';
                                      } else if (!value.containsUppercase) {
                                        return 'At least one CAPITAL letter required.';
                                      } else if (!value.containsNumber) {
                                        return 'At least one Number required.';
                                      }
                                      return null;
                                    },
                                    style: GoogleFonts.lexendDeca(
                                      fontSize: 16.0,
                                      color: CFCAppColors.textColorDark,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: 'Password',
                                      hintStyle: GoogleFonts.lexendDeca(
                                        fontSize: 16.0,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Container(
                                  decoration: BoxDecoration(
                                    color: CFCAppColors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                                  child: TextFormField(
                                    obscureText: true,
                                    controller: controller.confirmPasswordController,
                                    textInputAction: TextInputAction.done,
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Confirm Password cannot be empty';
                                      } else if (controller.passwordController.text != value) {
                                        return 'Password and Confirm Password are not matching.';
                                      }
                                      return null;
                                    },
                                    style: GoogleFonts.lexendDeca(
                                      fontSize: 16.0,
                                      color: CFCAppColors.textColorDark,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: 'Confirm Password',
                                      hintStyle: GoogleFonts.lexendDeca(
                                        fontSize: 16.0,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 50),
                                CFCMaterialButton(
                                  onPressed: () => controller.createPassword(emailAddress: emailAddress),
                                  text: 'Continue',
                                  width: double.infinity,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
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
