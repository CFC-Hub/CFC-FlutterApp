import 'package:cfc/controllers/cfc_controllers.dart';
import 'package:cfc/screens/cfc_screens.dart';
import 'package:cfc/utils/cfc_utils.dart';
import 'package:cfc/widgets/cfc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SignUpController controller = Get.put(SignUpController());
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
                        child: ListView(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(20.0),
                          children: [
                            const SizedBox(height: 40),
                            const Align(
                              alignment: Alignment.center,
                              child: CFCAppText(
                                text: 'Welcome Back!',
                                color: CFCAppColors.textColorLight,
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Align(
                              alignment: Alignment.center,
                              child: CFCAppText(
                                text: 'Please enter your Email Address to Sign Up.',
                                color: CFCAppColors.textColorLight,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 40),
                            Container(
                              decoration: BoxDecoration(
                                color: CFCAppColors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                              child: Form(
                                key: controller.signUpFormKey,
                                child: TextFormField(
                                  controller: controller.emailAddressController,
                                  style: GoogleFonts.lexendDeca(
                                    fontSize: 16.0,
                                    color: CFCAppColors.textColorDark,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.done,
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Email address cannot be empty';
                                    } else if (!GetUtils.isEmail(value)) {
                                      return 'Email address not valid';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Email Address',
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
                            ),
                            const SizedBox(height: 50),
                            CFCMaterialButton(
                              onPressed: controller.sendOTP,
                              text: 'Continue',
                              width: double.infinity,
                            ),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CFCAppText(
                                  text: 'Already a User?',
                                  fontWeight: FontWeight.w500,
                                  color: CFCAppColors.textColorLight,
                                ),
                                const SizedBox(width: 10),
                                CFCMaterialButton(
                                  onPressed: () {
                                    Get.off(() => const SignIn());
                                  },
                                  text: 'Login',
                                  buttonBackgroundColor: CFCAppColors.lightGreenButtonColor,
                                  buttonBorderColor: CFCAppColors.lightGreenButtonColor,
                                  height: 40,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ],
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
