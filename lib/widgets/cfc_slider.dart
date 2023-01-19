import 'package:cfc/utils/cfc_utils.dart';
import 'package:cfc/widgets/cfc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart' as inset;
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class CFCSlider extends StatelessWidget {
  const CFCSlider({
    Key? key,
    this.activeTrackHeight = 20,
    this.inactiveTrackHeight = 20,
    this.thumbRadius = 17,
    this.activeTrackColor = CFCAppColors.sliderActiveColor,
    this.inactiveTrackColor,
    this.thumbColor = CFCAppColors.orangeColor,
    required this.value,
    this.onChanged,
    this.min = 1,
    this.max = 6,
    this.titleText,
    required this.startText,
    required this.endText,
  }) : super(key: key);

  final double activeTrackHeight;
  final double inactiveTrackHeight;
  final double thumbRadius;
  final Color activeTrackColor;
  final Color? inactiveTrackColor;
  final Color thumbColor;
  final int value;
  final Function(dynamic)? onChanged;
  final int min;
  final int max;
  final String? titleText;
  final String startText;
  final String endText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(
          visible: titleText != null,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: CFCAppText(
                text: titleText ?? '',
                fontWeight: FontWeight.w600,
                color: CFCAppColors.textColorDark,
              ),
            ),
          ),
        ),
        SfSliderTheme(
          data: SfSliderThemeData(
            activeTrackHeight: activeTrackHeight,
            inactiveTrackHeight: inactiveTrackHeight,
            thumbRadius: thumbRadius,
            activeTrackColor: activeTrackColor,
            inactiveTrackColor: inactiveTrackColor ?? CFCAppColors.sliderInActiveColor,
            thumbColor: CFCAppColors.orangeColor,
          ),
          child: SfSlider(
            value: value,
            onChanged: onChanged,
            min: min,
            max: max,
            showTicks: false,
            showLabels: false,
            thumbIcon: Container(
              height: 17,
              width: 17,
              decoration: inset.BoxDecoration(
                color: CFCAppColors.orangeColor,
                borderRadius: BorderRadius.circular(25.0),
                boxShadow: const [
                  inset.BoxShadow(
                    color: Colors.black38,
                    blurRadius: 5.0,
                    spreadRadius: 2.0,
                    offset: Offset(1.0, 1.0),
                    inset: true,
                  ),
                  inset.BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5.0,
                    spreadRadius: 2.0,
                    offset: Offset(1.0, 1.0),
                    inset: false,
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CFCAppText(
                text: startText,
                color: CFCAppColors.textColorDark,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: CFCAppText(
                    text: endText,
                    color: CFCAppColors.textColorDark,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
