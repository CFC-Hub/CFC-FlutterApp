import 'package:cfc/utils/cfc_utils.dart';
import 'package:cfc/widgets/cfc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CFCTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String labelText;
  final TextInputType keyboardType;
  final Icon? icon;
  final bool enabled;
  final bool enableInteractiveSelection;
  final bool selected;
  final double leftContentPadding;
  final double rightContentPadding;
  final double topContentPadding;
  final double bottomContentPadding;
  final TextCapitalization textCapitalization;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;
  final TextInputAction? textInputAction;
  final bool readOnly;
  final TextStyle? errorStyle;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final String requiredLabel;
  final bool isRequiredField;
  final AutovalidateMode? autoValidateMode;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final int? maxLines;
  final int? minLines;
  final bool obscureText;

  const CFCTextFormField({
    Key? key,
    this.controller,
    this.hintText,
    required this.labelText,
    required this.keyboardType,
    this.icon,
    this.enabled = true,
    this.selected = false,
    this.leftContentPadding = 12.0,
    this.rightContentPadding = 12.0,
    this.topContentPadding = 18.0,
    this.bottomContentPadding = 18.0,
    this.textCapitalization = TextCapitalization.none,
    this.validator,
    this.enableInteractiveSelection = false,
    this.onChanged,
    this.textInputAction,
    this.readOnly = false,
    this.errorStyle,
    this.onTap,
    this.suffixIcon,
    this.prefixIcon,
    this.inputFormatters,
    this.requiredLabel = ' *',
    this.isRequiredField = false,
    this.autoValidateMode,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.maxLines = 1,
    this.minLines,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: autoValidateMode,
      inputFormatters: inputFormatters,
      readOnly: readOnly,
      enabled: enabled,
      onChanged: onChanged,
      onTap: onTap,
      obscureText: obscureText,
      textCapitalization: textCapitalization,
      style: GoogleFonts.lexendDeca(
        color: CFCAppColors.textColorDark,
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
      ),
      textAlignVertical: TextAlignVertical.center,
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        fillColor: Colors.transparent,
        icon: icon,
        filled: true,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        border: border ?? CFCWidgetHelper.textFieldBorder,
        enabledBorder: enabledBorder ?? CFCWidgetHelper.textFieldBorder,
        focusedBorder: focusedBorder ?? CFCWidgetHelper.textFieldFocusedBorder,
        contentPadding: EdgeInsets.fromLTRB(
          leftContentPadding,
          topContentPadding,
          rightContentPadding,
          bottomContentPadding,
        ),
        hintText: hintText,
        hintStyle: CFCWidgetHelper.inputHintStyle,
        labelText: labelText,
        labelStyle: CFCWidgetHelper.inputLabelStyle,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        errorStyle: errorStyle,
      ),
      maxLines: maxLines,
      minLines: minLines,
    );
  }
}
