import 'package:cfc/controllers/cfc_controllers.dart';
import 'package:cfc/models/cfc_models.dart';
import 'package:cfc/utils/cfc_utils.dart';
import 'package:cfc/widgets/cfc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MyWallet extends StatelessWidget {
  const MyWallet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyWalletController controller = Get.put(MyWalletController());
    return Scaffold(
      appBar: AppBar(
        leadingWidth: CFCConstant.leadingWidth,
        title: const CFCAppText(
          text: 'My Wallet',
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
          () => Visibility(
            visible: controller.isLoading.isFalse,
            replacement: const Center(child: CFCWidgetHelper.loadingWidget),
            child: Visibility(
              visible: controller.walletsDetails.isNotEmpty,
              replacement: ListView(
                children: [
                  SvgPicture.asset(
                    CFCAssets.emptyDashboardSVG,
                    fit: BoxFit.contain,
                    height: MediaQuery.of(context).size.width,
                    width: MediaQuery.of(context).size.width,
                  ),
                  const CFCAppText(
                    text: 'No Tokens Yet!',
                    fontWeight: FontWeight.w600,
                    color: CFCAppColors.textColorDark,
                    textAlign: TextAlign.center,
                    fontSize: 18,
                  ),
                  const SizedBox(height: 30),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: CFCAppText(
                      text:
                      'Your wallet currently has no tokens to show. '
                          '\nTokens are awarded once you opt for a learning module. '
                          '\n\nYou can select a learning module from the \nCFC Menu > Browse Courses option.',
                      fontWeight: FontWeight.w400,
                      color: CFCAppColors.textColorDark,
                      height: 2.0,
                      textAlign: TextAlign.center,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
              child: ListView.separated(
                padding: const EdgeInsets.all(10.0),
                itemCount: controller.walletsDetails.length,
                itemBuilder: (context, index) {
                  MyWalletDetails details = controller.walletsDetails[index];
                  if (controller.colorPick == 3) {
                    controller.colorPick = 0;
                  }
                  ++controller.colorPick;
                  return CFCCard(
                    backgroundColor: controller.colorPick == 1
                        ? CFCAppColors.walletBgColorViolet
                        : controller.colorPick == 2
                            ? CFCAppColors.walletBgColorOrange
                            : CFCAppColors.walletBgColorGreen,
                    padding: const EdgeInsets.all(15.0),
                    child: Stack(
                      children: [
                        Positioned(
                          right: 10,
                          top: 10,
                          child: SvgPicture.asset(
                            CFCAssets.certificationSignSVG,
                            height: 80,
                            width: 80,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CFCAppText(
                              text: details.name.toTitleCase(),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: CFCAppColors.textColorLight,
                            ),
                            const SizedBox(height: 5),
                            CFCAppText(
                              text: CFCHelper.getDateFromMillisecondsSinceEpoch(details.createdOn),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: CFCAppColors.textColorLight,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                const CFCAppText(
                                  text: 'Contract Address  ',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: CFCAppColors.textColorLight,
                                ),
                                InkWell(
                                  onTap: () async {
                                    await Clipboard.setData(ClipboardData(text: details.contractAddress));
                                    CFCHelper.showMessage(
                                      message: 'Contract Address copied to clipboard.',
                                      duration: const Duration(seconds: 3),
                                    );
                                  },
                                  child: const Icon(
                                    Icons.copy,
                                    color: CFCAppColors.textColorLight,
                                    size: 15,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            InkWell(
                              onTap: () {
                                CFCHelper.showMessage(
                                  message: details.contractAddress,
                                  duration: const Duration(seconds: 3),
                                );
                              },
                              child: CFCAppText(
                                text: CFCHelper.truncateString(details.contractAddress, 10, 5),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: CFCAppColors.textColorLight,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const CFCAppText(
                                      text: 'NFT ID',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: CFCAppColors.textColorLight,
                                    ),
                                    const SizedBox(height: 5),
                                    CFCAppText(
                                      text: details.nftId,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: CFCAppColors.textColorLight,
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Image.asset(
                                  CFCAssets.cfcLogoWhitePNG,
                                  height: 30,
                                  width: 40,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 20.0);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
