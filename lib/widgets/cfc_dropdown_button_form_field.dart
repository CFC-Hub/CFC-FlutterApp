import 'package:cfc/widgets/cfc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CFCDropdownButtonFormField<T> extends StatelessWidget {
  const CFCDropdownButtonFormField({
    Key? key,
    required this.labelText,
    this.isRequiredField = false,
    required this.itemList,
    required this.value,
    required this.onChanged,
    this.validator,
    this.autoValidateMode,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.suffixIcon,
    this.prefixIcon,
    this.hintText,
  }) : super(key: key);

  final String labelText;
  final String? hintText;
  final bool isRequiredField;
  final List<T> itemList;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final FormFieldValidator<T>? validator;
  final AutovalidateMode? autoValidateMode;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
        isExpanded: true,
        isDense: false,
        autovalidateMode: autoValidateMode,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
          isCollapsed: false,
          border: border ?? CFCWidgetHelper.textFieldBorder,
          enabledBorder: enabledBorder ?? CFCWidgetHelper.textFieldBorder,
          focusedBorder: focusedBorder ?? CFCWidgetHelper.textFieldFocusedBorder,
          hintText: hintText,
          hintStyle: CFCWidgetHelper.inputHintStyle,
          labelText: labelText,
          labelStyle: CFCWidgetHelper.inputLabelStyle,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
        validator: validator,
        style: GoogleFonts.lexendDeca(
          color: Colors.black87,
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
        ),
        value: value,
        onChanged: onChanged,
        items: itemList.map<DropdownMenuItem<T>>(
          (T value) {
            return DropdownMenuItem(
              value: value,
              child: CFCAppText(
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                color: Colors.black87,
                text: value.toString(),
              ),
            );
          },
        ).toList());
  }
}
