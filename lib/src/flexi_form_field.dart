import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'builders/text_field_builder.dart';
import 'enums.dart';
import 'theme.dart';

/// A powerful and flexible text input widget with built-in validation, 
/// rich styling options, and a consistent theming system.
///
/// [FlexiFormField] serves as a drop-in replacement for [TextFormField] while
/// adding standard features like external labels, mandatory indicators, 
/// and pre-configured validation logic.
class FlexiFormField extends StatelessWidget {
  /// The visual style of the input border (e.g., outline, filled, rounded).
  final FlexiFieldStyle fieldStyle;

  /// The placement of the label relative to the input field.
  final FlexiFieldLayout fieldLayout;

  /// An optional container wrapper for the entire form field (e.g., card, outlined).
  final FlexiFieldWrapper wrapper;

  /// Optional theme override for this specific field.
  final FlexiFormTheme? theme;

  /// The label displayed inside the input border (Material style).
  final String? label;

  /// A label displayed outside (above) the input field.
  final String? externalLabel;

  /// Hint text shown when the input is empty.
  final String? hint;

  /// Controller for the text being edited.
  final TextEditingController? controller;

  /// Whether to hide the text being edited (for passwords).
  final bool obscureText;

  /// Whether the field is interactive.
  final bool enabled;

  /// Whether the field is read-only.
  final bool readOnly;

  /// The maximum number of lines for multiline input.
  final int maxLines;

  /// The maximum number of characters allowed.
  final int? maxLength;

  /// The type of keyboard to display.
  final TextInputType? keyboardType;

  /// Custom list of input formatters.
  final List<TextInputFormatter>? inputFormatters;

  /// Whether this field is marked as mandatory (shows '*' indicator).
  final bool isMandatory;

  /// Restricts input to numeric characters.
  final bool isNumber;

  /// Restricts input to decimal/double values.
  final bool isDouble;

  /// Pre-configured validation and formatting for mobile numbers.
  final bool isMobile;

  /// Pre-configured validation for email addresses.
  final bool isEmail;

  /// Pre-configured validation and formatting for pin codes.
  final bool isPinCode;

  /// Pre-configured validation and formatting for percentages.
  final bool isPercentage;

  /// Pre-configured validation for GST numbers.
  final bool isGST;

  /// Automatically converts all input to uppercase.
  final bool uppercaseOnly;

  /// Automatically converts all input to lowercase.
  final bool lowercaseOnly;

  /// Prevents space characters from being entered.
  final bool denySpace;

  /// Whether to validate on every keystroke.
  final bool autoValidate;

  /// Internal padding for the input field.
  final EdgeInsetsGeometry? contentPadding;

  /// Outer margin for the form field container.
  final EdgeInsetsGeometry? margin;

  /// Widget shown at the beginning of the input field.
  final Widget? prefixIcon;

  /// Widget shown at the end of the input field.
  final Widget? suffixIcon;

  /// Constraints for the suffix icon container.
  final BoxConstraints? suffixIconConstraints;

  /// Callback when the field is tapped.
  final VoidCallback? onTap;

  /// Custom validation logic for the input.
  final String? Function(String?)? validator;

  /// Callback when the text changes.
  final ValueChanged<String>? onChanged;

  /// Font size override for the input text.
  final double? fontSize;

  /// Border radius override for the input field.
  final double? borderRadius;

  /// Background fill color override.
  final Color? fillColor;

  /// Color of the cursor.
  final Color? cursorColor;

  /// Height of the cursor.
  final double? cursorHeight;

  /// Alignment logic for the floating label.
  final FloatingLabelAlignment? floatingLabelAlignment;

  /// Full text style override for the input text.
  final TextStyle? style;

  /// Style override for the label text.
  final TextStyle? labelStyle;

  /// Style override for the hint text.
  final TextStyle? hintStyle;

  /// Style override for the floating label.
  final TextStyle? floatingLabelStyle;

  /// Creates a [FlexiFormField] with granular control over its behavior and aesthetics.
  const FlexiFormField({
    super.key,
    this.fieldStyle = FlexiFieldStyle.outline,
    this.fieldLayout = FlexiFieldLayout.floating,
    this.wrapper = FlexiFieldWrapper.none,
    this.theme,
    this.label,
    this.externalLabel,
    this.hint,
    this.controller,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.maxLength,
    this.keyboardType,
    this.inputFormatters,
    this.isMandatory = false,
    this.isNumber = false,
    this.isDouble = false,
    this.isMobile = false,
    this.isEmail = false,
    this.isPinCode = false,
    this.isPercentage = false,
    this.isGST = false,
    this.uppercaseOnly = false,
    this.lowercaseOnly = false,
    this.denySpace = false,
    this.autoValidate = false,
    this.contentPadding,
    this.margin,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixIconConstraints,
    this.onTap,
    this.validator,
    this.onChanged,
    this.fontSize,
    this.borderRadius,
    this.fillColor,
    this.cursorColor,
    this.cursorHeight,
    this.floatingLabelAlignment,
    this.style,
    this.labelStyle,
    this.hintStyle,
    this.floatingLabelStyle,
  });

  @override
  Widget build(BuildContext context) {
    final appliedTheme = theme ?? const FlexiFormTheme();

    Widget field = FlexiTextFieldBuilder.build(
      context: context,
      fieldLayout: fieldLayout,
      controller: controller,
      label: label,
      externalLabel: externalLabel,
      hint: hint,
      style: fieldStyle,
      theme: appliedTheme,
      obscureText: obscureText,
      enabled: enabled,
      readOnly: readOnly,
      maxLines: maxLines,
      maxLength: maxLength,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      isMandatory: isMandatory,
      isNumber: isNumber,
      isDouble: isDouble,
      isMobile: isMobile,
      isEmail: isEmail,
      isPinCode: isPinCode,
      isPercentage: isPercentage,
      isGST: isGST,
      uppercaseOnly: uppercaseOnly,
      lowercaseOnly: lowercaseOnly,
      denySpace: denySpace,
      autoValidate: autoValidate,
      contentPadding: contentPadding,
      margin: margin,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      suffixIconConstraints: suffixIconConstraints,
      onTap: onTap,
      onChanged: onChanged,
      validator: validator,
      // Pass premium styles
      fontSize: fontSize,
      borderRadius: borderRadius,
      fillColor: fillColor,
      cursorColor: cursorColor,
      cursorHeight: cursorHeight,
      floatingLabelAlignment: floatingLabelAlignment,
      textStyle: style,
      labelStyle: labelStyle,
      hintStyle: hintStyle,
      floatingLabelStyle: floatingLabelStyle,
    );

    return _wrap(field, appliedTheme);
  }

  Widget _wrap(Widget child, FlexiFormTheme appliedTheme) {
    switch (wrapper) {
      case FlexiFieldWrapper.card:
        return Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: appliedTheme.borderRadius,
          ),
          child: Padding(padding: const EdgeInsets.all(8), child: child),
        );

      case FlexiFieldWrapper.outlined:
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: appliedTheme.borderRadius,
          ),
          child: child,
        );

      default:
        return child;
    }
  }
}
