import 'dart:io';

import 'package:cfc/screens/cfc_screens.dart';
import 'package:cfc/utils/cfc_utils.dart';
import 'package:cfc/widgets/cfc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartInfo extends StatelessWidget {
  const StartInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              Align(
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
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 40),
                          const CFCAppText(
                            text: 'Before you begin...',
                            color: CFCAppColors.textColorLight,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                          const SizedBox(height: 30),
                          CFCAppText(
                            text:
                                'Please download METAMASK from the ${Platform.isAndroid ? 'Play Store' : Platform.isIOS ? 'App Store' : ''} '
                                'and install it on the device. \n\nMETAMASK is a Digital Wallet to store Tokens that you will earn '
                                'in your Learning Journey with \nCrowField Companion.',
                            color: CFCAppColors.textColorLight,
                            textAlign: TextAlign.center,
                            height: 1.7,
                          ),
                          const SizedBox(height: 40),
                          const SizedBox(height: 50),
                          CFCMaterialButton(
                            onPressed: () {
                              Get.to(() => const SignIn());
                            },
                            text: 'Continue',
                            width: double.infinity,
                          ),
                        ],
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
