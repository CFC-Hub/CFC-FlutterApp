import 'package:cfc/utils/cfc_utils.dart';
import 'package:cfc/widgets/cfc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpAndFAQ extends StatelessWidget {
  const HelpAndFAQ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: CFCConstant.leadingWidth,
        title: const CFCAppText(
          text: 'Help and FAQ',
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
    );
  }
}
