import 'package:cfc/controllers/cfc_controllers.dart';
import 'package:cfc/screens/cfc_screens.dart';
import 'package:cfc/utils/cfc_utils.dart';
import 'package:cfc/widgets/cfc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyOTP extends StatelessWidget {
  const VerifyOTP({Key? key, required this.emailAddress}) : super(key: key);

  final String emailAddress;

  @override
  Widget build(BuildContext context) {
    final VerifyOtpController controller = Get.put(VerifyOtpController());
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
                                      text: 'Validating OTP... This will just be a moment.',
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
                          visible: controller.isOTPVerified.isFalse,
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
                                  text: 'Your OTP has been validated successfully.',
                                  color: CFCAppColors.textColorLight,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 30),
                                CFCMaterialButton(
                                  onPressed: () => Get.off(() => CreatePassword(emailAddress: emailAddress)),
                                  text: 'Continue',
                                  width: double.infinity,
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                          child: ListView(
                            padding: const EdgeInsets.all(20.0),
                            shrinkWrap: true,
                            children: [
                              const SizedBox(height: 40),
                              const Align(
                                alignment: Alignment.center,
                                child: CFCAppText(
                                  text: 'One Time PIN',
                                  color: CFCAppColors.textColorLight,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 40),
                              const Align(
                                alignment: Alignment.center,
                                child: CFCAppText(
                                  text: 'A One Time PIN (OTP) was sent to the Email Address you provided. '
                                      'Please check your Email and enter the OTP in the boxes below.',
                                  color: CFCAppColors.textColorLight,
                                  textAlign: TextAlign.center,
                                  height: 1.7,
                                ),
                              ),
                              const SizedBox(height: 40),
                              PinCodeTextField(
                                controller: controller.otpController,
                                appContext: context,
                                length: 6,
                                backgroundColor: Colors.transparent,
                                textStyle: GoogleFonts.lexendDeca(
                                  fontSize: 16,
                                  color: CFCAppColors.textColorDark,
                                  fontWeight: FontWeight.w700,
                                ),
                                pastedTextStyle: GoogleFonts.lexendDeca(
                                  fontSize: 16,
                                  color: CFCAppColors.textColorDark,
                                  fontWeight: FontWeight.w700,
                                ),
                                obscureText: false,
                                blinkWhenObscuring: true,
                                animationType: AnimationType.fade,
                                validator: (String? text) {
                                  if (text!.length < 6) {
                                    return '';
                                  } else {
                                    return null;
                                  }
                                },
                                pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderWidth: 1.0,
                                  errorBorderColor: CFCAppColors.appErrorBackground,
                                  fieldWidth: 40,
                                  fieldHeight: 50,
                                  inactiveColor: CFCAppColors.white,
                                  selectedColor: CFCAppColors.white,
                                  activeColor: CFCAppColors.white,
                                  selectedFillColor: Colors.white,
                                  inactiveFillColor: Colors.white,
                                  activeFillColor: Colors.white,
                                ),
                                cursorColor: CFCAppColors.appPrimaryColor,
                                animationDuration: const Duration(milliseconds: 300),
                                enableActiveFill: true,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                beforeTextPaste: (text) {
                                  return false;
                                },
                                onChanged: (String text) {},
                              ),
                              const SizedBox(height: 50),
                              CFCMaterialButton(
                                onPressed: () => controller.verifyOTP(emailAddress: emailAddress),
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
            ],
          ),
        ),
      ),
    );
  }
}
