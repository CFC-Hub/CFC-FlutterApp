import 'package:cfc/controllers/cfc_controllers.dart';
import 'package:cfc/utils/cfc_utils.dart';
import 'package:cfc/widgets/cfc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SettingsController controller = Get.put(SettingsController());
    return Scaffold(
      appBar: AppBar(
        leadingWidth: CFCConstant.leadingWidth,
        title: const CFCAppText(
          text: 'Settings',
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
              ListView(
                padding: const EdgeInsets.all(10.0),
                children: [
                  CFCCard(
                    padding: const EdgeInsets.all(15.0),
                    child: Form(
                      key: controller.changePasswordFormKey,
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: CFCAppText(
                              text: 'Change Password',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 30),
                          CFCTextFormField(
                            obscureText: true,
                            controller: controller.currentPasswordController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Current Password cannot be empty';
                              }
                              /*else if (value.length < 8) {
                                return 'The password must be at least 8 characters long.';
                              } else if (!value.containsUppercase) {
                                return 'At least one CAPITAL letter required.';
                              } else if (!value.containsNumber) {
                                return 'At least one Number required.';
                              }*/
                              return null;
                            },
                            onChanged: (String text) {},
                            hintText: 'Current Password',
                            labelText: 'Current Password',
                          ),
                          const SizedBox(height: 30),
                          CFCTextFormField(
                            obscureText: true,
                            controller: controller.newPasswordController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'New Password cannot be empty';
                              } else if (value.length < 8) {
                                return 'The password must be at least 8 characters long.';
                              } else if (!value.containsUppercase) {
                                return 'At least one CAPITAL letter required.';
                              } else if (!value.containsNumber) {
                                return 'At least one Number required.';
                              }
                              return null;
                            },
                            onChanged: (String text) {},
                            hintText: 'New Password',
                            labelText: 'New Password',
                          ),
                          const SizedBox(height: 30),
                          CFCTextFormField(
                            obscureText: true,
                            controller: controller.confirmPasswordController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Confirm Password cannot be empty';
                              } else if (controller.newPasswordController.text != value) {
                                return 'New Password and Confirm Password are not matching.';
                              }
                              return null;
                            },
                            onChanged: (String text) {},
                            hintText: 'Confirm Password',
                            labelText: 'Confirm Password',
                          ),
                          const SizedBox(height: 30),
                          CFCMaterialButton(
                            onPressed: controller.changePassword,
                            width: double.infinity,
                            text: 'Continue',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              /// loading
              Visibility(
                visible: controller.isLoading.isTrue,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: CFCAppColors.backgroundOverlayWhite,
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: const Center(
                    child: CFCWidgetHelper.loadingWidget,
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
