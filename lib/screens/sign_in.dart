import 'package:cfc/controllers/cfc_controllers.dart';
import 'package:cfc/screens/cfc_screens.dart';
import 'package:cfc/utils/cfc_utils.dart';
import 'package:cfc/widgets/cfc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SignInController controller = Get.put(SignInController());
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
                        child: Form(
                          key: controller.signInFormKey,
                          child: ListView(
                            padding: const EdgeInsets.all(20.0),
                            shrinkWrap: true,
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
                                  text: 'Please Login with your Email Address and Password.',
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
                                child: TextFormField(
                                  controller: controller.emailAddressController,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Email address cannot be empty';
                                    } else if (!GetUtils.isEmail(value)) {
                                      return 'Email address not valid';
                                    }
                                    return null;
                                  },
                                  style: GoogleFonts.lexendDeca(
                                    fontSize: 16.0,
                                    color: CFCAppColors.textColorDark,
                                    fontWeight: FontWeight.w500,
                                  ),
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
                              const SizedBox(height: 30),
                              Container(
                                decoration: BoxDecoration(
                                  color: CFCAppColors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                                child: TextFormField(
                                  controller: controller.passwordController,
                                  obscureText: true,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Password cannot be empty';
                                    } else if (value.length < 8) {
                                      return 'The password must be at least 8 characters long.';
                                    }
                                    return null;
                                  },
                                  style: GoogleFonts.lexendDeca(
                                    fontSize: 16.0,
                                    color: CFCAppColors.textColorDark,
                                    fontWeight: FontWeight.w500,
                                  ),
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
                              InkWell(
                                onTap: () => Get.to(() => const ForgotPassword()),
                                child: const Align(
                                  alignment: Alignment.centerRight,
                                  child: CFCAppText(
                                    text: 'Forgot password? ',
                                    color: CFCAppColors.appPrimaryColor,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 50),
                              CFCMaterialButton(
                                onPressed: controller.signIn,
                                text: 'Continue',
                                width: double.infinity,
                              ),
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CFCAppText(
                                    text: 'New User?',
                                    fontWeight: FontWeight.w500,
                                    color: CFCAppColors.textColorLight,
                                  ),
                                  const SizedBox(width: 10),
                                  CFCMaterialButton(
                                    onPressed: () {
                                      Get.off(() => const SignUp());
                                    },
                                    text: 'Sign Up',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
