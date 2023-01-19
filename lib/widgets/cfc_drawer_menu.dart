import 'package:cfc/utils/cfc_utils.dart';
import 'package:cfc/widgets/cfc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CFCDrawerMenu extends StatelessWidget {
  const CFCDrawerMenu({
    Key? key,
    required this.onTap,
    required this.imagePathSVG,
    required this.title,
  }) : super(key: key);

  final Function() onTap;
  final String imagePathSVG;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: SvgPicture.asset(
        imagePathSVG,
        color: CFCAppColors.iconColorDark,
        height: 25,
        width: 25,
      ),
      title: CFCAppText(
        text: title,
        color: CFCAppColors.textColorDark,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
