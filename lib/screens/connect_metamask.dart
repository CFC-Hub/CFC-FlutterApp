import 'dart:io';

import 'package:cfc/controllers/cfc_controllers.dart';
import 'package:cfc/utils/cfc_utils.dart';
import 'package:cfc/widgets/cfc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';

enum NftType { createPopNFT, createLearningNFT }

class ConnectMetaMask extends StatelessWidget {
  const ConnectMetaMask({
    Key? key,
    required this.nftType,
    required this.firstName,
    required this.lastName,
    this.contentId = '',
    this.contractAddress = '',
  }) : super(key: key);

  final NftType nftType;
  final String firstName;
  final String lastName;
  final String contentId;
  final String contractAddress;

  @override
  Widget build(BuildContext context) {
    final ConnectMetaMaskController controller = Get.put(ConnectMetaMaskController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leadingWidth: CFCConstant.leadingWidth,
        title: CFCAppText(
          text: nftType == NftType.createPopNFT ? 'New POP Profile' : 'Create NFT',
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
              /// login to metamask
              Visibility(
                visible: controller.isCreatePopProfile.isTrue && controller.sessionStatus.value == null,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              CFCAssets.metamaskLoginSVG,
                              fit: BoxFit.contain,
                              height: MediaQuery.of(context).size.width,
                              width: MediaQuery.of(context).size.width,
                            ),
                            const SizedBox(height: 20),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: 'You will be redirected to sign in to your',
                                style: GoogleFonts.lexendDeca(
                                  fontWeight: FontWeight.w400,
                                  color: CFCAppColors.textColorDark,
                                  height: 2.0,
                                ),
                                children: [
                                  TextSpan(
                                    text: '\nMETAMASK ',
                                    style: GoogleFonts.lexendDeca(
                                      fontWeight: FontWeight.w600,
                                      color: CFCAppColors.textColorDark,
                                      height: 2.0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'account on this device.\nOnce you have signed in, '
                                        'you will be brought \nback here. Please tap on ',
                                    style: GoogleFonts.lexendDeca(
                                      fontWeight: FontWeight.w400,
                                      color: CFCAppColors.textColorDark,
                                      height: 2.0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Continue.',
                                    style: GoogleFonts.lexendDeca(
                                      fontWeight: FontWeight.w600,
                                      color: CFCAppColors.textColorDark,
                                      height: 2.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CFCMaterialButton(
                        width: double.infinity,
                        text: 'Continue',
                        onPressed: controller.initWalletConnect,
                      ),
                    ),
                  ],
                ),
              ),

              /// create pop profile
              Visibility(
                visible: controller.sessionStatus.value != null &&
                    controller.sessionStatus.value?.chainId == 1337 &&
                    controller.isCreatePopProfileError.isFalse,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              CFCAssets.metamaskCreateNftSVG,
                              fit: BoxFit.contain,
                              height: MediaQuery.of(context).size.width,
                              width: MediaQuery.of(context).size.width,
                            ),
                            const SizedBox(height: 20),
                            nftType == NftType.createPopNFT
                                ? RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      text: 'Awesome! ',
                                      style: GoogleFonts.lexendDeca(
                                        fontWeight: FontWeight.w600,
                                        color: CFCAppColors.textColorDark,
                                        height: 2.0,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: 'It\'s now time to create your',
                                          style: GoogleFonts.lexendDeca(
                                            fontWeight: FontWeight.w400,
                                            color: CFCAppColors.textColorDark,
                                            height: 2.0,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '\nPOP Profile ',
                                          style: GoogleFonts.lexendDeca(
                                            fontWeight: FontWeight.w600,
                                            color: CFCAppColors.textColorDark,
                                            height: 2.0,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'and get your first ',
                                          style: GoogleFonts.lexendDeca(
                                            fontWeight: FontWeight.w400,
                                            color: CFCAppColors.textColorDark,
                                            height: 2.0,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'NFT.',
                                          style: GoogleFonts.lexendDeca(
                                            fontWeight: FontWeight.w600,
                                            color: CFCAppColors.textColorDark,
                                            height: 2.0,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '\nTap on the ',
                                          style: GoogleFonts.lexendDeca(
                                            fontWeight: FontWeight.w400,
                                            color: CFCAppColors.textColorDark,
                                            height: 2.0,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Create POP Profile ',
                                          style: GoogleFonts.lexendDeca(
                                            fontWeight: FontWeight.w600,
                                            color: CFCAppColors.textColorDark,
                                            height: 2.0,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'button.',
                                          style: GoogleFonts.lexendDeca(
                                            fontWeight: FontWeight.w400,
                                            color: CFCAppColors.textColorDark,
                                            height: 2.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      text: 'Awesome! ',
                                      style: GoogleFonts.lexendDeca(
                                        fontWeight: FontWeight.w600,
                                        color: CFCAppColors.textColorDark,
                                        height: 2.0,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: 'It\'s now time to create your',
                                          style: GoogleFonts.lexendDeca(
                                            fontWeight: FontWeight.w400,
                                            color: CFCAppColors.textColorDark,
                                            height: 2.0,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '\nCourse ',
                                          style: GoogleFonts.lexendDeca(
                                            fontWeight: FontWeight.w600,
                                            color: CFCAppColors.textColorDark,
                                            height: 2.0,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'NFT.',
                                          style: GoogleFonts.lexendDeca(
                                            fontWeight: FontWeight.w600,
                                            color: CFCAppColors.textColorDark,
                                            height: 2.0,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '\nTap on the ',
                                          style: GoogleFonts.lexendDeca(
                                            fontWeight: FontWeight.w400,
                                            color: CFCAppColors.textColorDark,
                                            height: 2.0,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Create NET ',
                                          style: GoogleFonts.lexendDeca(
                                            fontWeight: FontWeight.w600,
                                            color: CFCAppColors.textColorDark,
                                            height: 2.0,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'button.',
                                          style: GoogleFonts.lexendDeca(
                                            fontWeight: FontWeight.w400,
                                            color: CFCAppColors.textColorDark,
                                            height: 2.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CFCMaterialButton(
                        width: double.infinity,
                        text: nftType == NftType.createPopNFT ? 'Create POP Profile' : 'Create NFT',
                        onPressed: () => controller.createNFT(
                            nftType: nftType, firstName: firstName, lastName: lastName, contentId: contentId),
                      ),
                    ),
                  ],
                ),
              ),

              /// metamask app not found
              Visibility(
                visible: controller.isAppNotFound.isTrue,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                CFCAssets.metamaskErrorSVG,
                                fit: BoxFit.contain,
                                height: MediaQuery.of(context).size.width,
                                width: MediaQuery.of(context).size.width,
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: 'Wallet Not Found',
                                    style: GoogleFonts.lexendDeca(
                                      fontWeight: FontWeight.w600,
                                      color: CFCAppColors.textColorDark,
                                      height: 2.0,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: '\nIt looks like you do not have the ',
                                        style: GoogleFonts.lexendDeca(
                                          fontWeight: FontWeight.w400,
                                          color: CFCAppColors.textColorDark,
                                          height: 2.0,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'METAMASK ',
                                        style: GoogleFonts.lexendDeca(
                                          fontWeight: FontWeight.w600,
                                          color: CFCAppColors.textColorDark,
                                          height: 2.0,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Wallet App installed on your device. '
                                            '\nYou can download and install the app from the ${Platform.isAndroid ? 'Play Store' : Platform.isIOS ? 'App Store' : ''} by searching for the term \'metamask\'.',
                                        style: GoogleFonts.lexendDeca(
                                          fontWeight: FontWeight.w400,
                                          color: CFCAppColors.textColorDark,
                                          height: 2.0,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '\n\nYou can continue with CFC Setup once you have installed ',
                                        style: GoogleFonts.lexendDeca(
                                          fontWeight: FontWeight.w400,
                                          color: CFCAppColors.textColorDark,
                                          height: 2.0,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'METAMASK.',
                                        style: GoogleFonts.lexendDeca(
                                          fontWeight: FontWeight.w600,
                                          color: CFCAppColors.textColorDark,
                                          height: 2.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CFCMaterialButton(
                          width: double.infinity,
                          text: 'Try Again',
                          onPressed: ()  {
                            controller.isAppNotFound.value = false;
                            controller.initWalletConnect();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// network not support error
              Visibility(
                visible: controller.sessionStatus.value != null && controller.sessionStatus.value?.chainId != 1337,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              CFCAssets.metamaskErrorSVG,
                              fit: BoxFit.contain,
                              height: MediaQuery.of(context).size.width,
                              width: MediaQuery.of(context).size.width,
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: 'OOPs! ',
                                  style: GoogleFonts.lexendDeca(
                                    fontWeight: FontWeight.w600,
                                    color: CFCAppColors.textColorDark,
                                    height: 2.0,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'There seems to be a problem.',
                                      style: GoogleFonts.lexendDeca(
                                        fontWeight: FontWeight.w400,
                                        color: CFCAppColors.textColorDark,
                                        height: 2.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '\nYou have to connect the ',
                                      style: GoogleFonts.lexendDeca(
                                        fontWeight: FontWeight.w400,
                                        color: CFCAppColors.textColorDark,
                                        height: 2.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'CFC Network ',
                                      style: GoogleFonts.lexendDeca(
                                        fontWeight: FontWeight.w600,
                                        color: CFCAppColors.textColorDark,
                                        height: 2.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'on ',
                                      style: GoogleFonts.lexendDeca(
                                        fontWeight: FontWeight.w400,
                                        color: CFCAppColors.textColorDark,
                                        height: 2.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'METAMASK.',
                                      style: GoogleFonts.lexendDeca(
                                        fontWeight: FontWeight.w600,
                                        color: CFCAppColors.textColorDark,
                                        height: 2.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '\n\nTap on ',
                                      style: GoogleFonts.lexendDeca(
                                        fontWeight: FontWeight.w400,
                                        color: CFCAppColors.textColorDark,
                                        height: 2.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Try Again ',
                                      style: GoogleFonts.lexendDeca(
                                        fontWeight: FontWeight.w600,
                                        color: CFCAppColors.textColorDark,
                                        height: 2.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'to retry ',
                                      style: GoogleFonts.lexendDeca(
                                        fontWeight: FontWeight.w400,
                                        color: CFCAppColors.textColorDark,
                                        height: 2.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'METAMASK ',
                                      style: GoogleFonts.lexendDeca(
                                        fontWeight: FontWeight.w600,
                                        color: CFCAppColors.textColorDark,
                                        height: 2.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'sign in.',
                                      style: GoogleFonts.lexendDeca(
                                        fontWeight: FontWeight.w400,
                                        color: CFCAppColors.textColorDark,
                                        height: 2.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '\n\nTo get help on how to do this, \nPlease tap on the ',
                                      style: GoogleFonts.lexendDeca(
                                        fontWeight: FontWeight.w400,
                                        color: CFCAppColors.textColorDark,
                                        height: 2.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Help ',
                                      style: GoogleFonts.lexendDeca(
                                        fontWeight: FontWeight.w600,
                                        color: CFCAppColors.textColorDark,
                                        height: 2.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'button.',
                                      style: GoogleFonts.lexendDeca(
                                        fontWeight: FontWeight.w400,
                                        color: CFCAppColors.textColorDark,
                                        height: 2.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
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
                              buttonBackgroundColor: CFCAppColors.lightGreenButtonColor,
                              buttonBorderColor: CFCAppColors.lightGreenButtonColor,
                              width: double.infinity,
                              text: 'Help',
                              onPressed: () {},
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CFCMaterialButton(
                              width: double.infinity,
                              text: 'Try Again',
                              onPressed: controller.initWalletConnect,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              /// create pop profile error
              Visibility(
                visible: controller.isCreatePopProfileError.isTrue,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              CFCAssets.metamaskErrorSVG,
                              fit: BoxFit.contain,
                              height: MediaQuery.of(context).size.width,
                              width: MediaQuery.of(context).size.width,
                            ),
                            const SizedBox(height: 20),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: 'OOPs! ',
                                style: GoogleFonts.lexendDeca(
                                  fontWeight: FontWeight.w600,
                                  color: CFCAppColors.textColorDark,
                                  height: 2.0,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'There seems to be a problem.',
                                    style: GoogleFonts.lexendDeca(
                                      fontWeight: FontWeight.w400,
                                      color: CFCAppColors.textColorDark,
                                      height: 2.0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '\nThere was a Network Error while trying \nto signing in to ',
                                    style: GoogleFonts.lexendDeca(
                                      fontWeight: FontWeight.w400,
                                      color: CFCAppColors.textColorDark,
                                      height: 2.0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'METAMASK. ',
                                    style: GoogleFonts.lexendDeca(
                                      fontWeight: FontWeight.w600,
                                      color: CFCAppColors.textColorDark,
                                      height: 2.0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '\n\nMake sure your internet is working and \ntap on the ',
                                    style: GoogleFonts.lexendDeca(
                                      fontWeight: FontWeight.w400,
                                      color: CFCAppColors.textColorDark,
                                      height: 2.0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Try Again ',
                                    style: GoogleFonts.lexendDeca(
                                      fontWeight: FontWeight.w600,
                                      color: CFCAppColors.textColorDark,
                                      height: 2.0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'button.',
                                    style: GoogleFonts.lexendDeca(
                                      fontWeight: FontWeight.w400,
                                      color: CFCAppColors.textColorDark,
                                      height: 2.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CFCMaterialButton(
                        width: double.infinity,
                        text: 'Try Again',
                        onPressed: () => controller.createNFT(
                            nftType: nftType, firstName: firstName, lastName: lastName, contentId: contentId),
                      ),
                    ),
                  ],
                ),
              ),

              /// loading
              Visibility(
                visible: controller.isLoading.isTrue,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: CFCAppColors.backgroundOverlayWhite,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        CFCAssets.progressMintingNftSVG,
                        fit: BoxFit.contain,
                        height: MediaQuery.of(context).size.width,
                        width: MediaQuery.of(context).size.width,
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 50,
                              width: 50,
                              child: LoadingIndicator(
                                indicatorType: Indicator.ballRotateChase,
                                colors: [
                                  CFCAppColors.appPrimaryColor,
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            Flexible(
                              child: CFCAppText(
                                text: 'Minting your ${nftType == NftType.createPopNFT ? 'first ' : ''}NFT...',
                                fontWeight: FontWeight.w500,
                                color: CFCAppColors.textColorDark,
                                fontSize: 18,
                              ),
                            ),
                          ],
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
