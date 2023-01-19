import 'package:cfc/utils/cfc_utils.dart';
import 'package:flutter/material.dart';

class CFCCard extends StatelessWidget {
  const CFCCard(
      {Key? key,
      required this.child,
      this.padding,
      this.margin,
      this.backgroundColor,
      this.blurRadius,
      this.spreadRadius})
      : super(key: key);

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final double? blurRadius;
  final double? spreadRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor ?? CFCAppColors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: blurRadius ?? 3.0,
            spreadRadius: spreadRadius ?? 3.0,
            offset: const Offset(
              1.0,
              1.0,
            ),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: child,
      ),
    );
  }
}
