import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../decorators.dart';
import '../enums.dart';
import '../theme.dart';

/// An internal builder class that handles the complex construction of [TextFormField]s
/// within the Flexi design system.
///
/// [FlexiTextFieldBuilder] abstracts the logic for input decoration, formatting,
/// validation, and layout, ensuring a consistent look and feel across different
/// input types.
class FlexiTextFieldBuilder {
  /// Builds a [Widget] containing a [TextFormField] with the specified styles and behaviors.
  static Widget build({
    required BuildContext context,
    TextEditingController? controller,
    String? label,
    String? externalLabel,
    String? hint,
    required FlexiFieldStyle style,
    required FlexiFieldLayout fieldLayout,
    required FlexiFormTheme theme,

    // basic
    bool obscureText = false,
    bool enabled = true,
    bool readOnly = false,
    int maxLines = 1,
    int? maxLength,

    // keyboard & format
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,

    // flags
    bool isNumber = false,
    bool isDouble = false,
    bool isMobile = false,
    bool isEmail = false,
    bool isPinCode = false,
    bool isPercentage = false,
    bool isGST = false,
    bool uppercaseOnly = false,
    bool lowercaseOnly = false,
    bool denySpace = false,
    bool isMandatory = false,
    bool autoValidate = false,

    // UI extras
    EdgeInsetsGeometry? contentPadding,
    EdgeInsetsGeometry? margin,
    Widget? prefixIcon,
    Widget? suffixIcon,
    BoxConstraints? suffixIconConstraints,

    // Premium Styles
    double? fontSize,
    double? borderRadius,
    Color? fillColor,
    Color? cursorColor,
    double? cursorHeight,
    FloatingLabelAlignment? floatingLabelAlignment,
    TextStyle? textStyle,
    TextStyle? labelStyle,
    TextStyle? hintStyle,
    TextStyle? floatingLabelStyle,

    // callbacks
    ValueChanged<String>? onChanged,
    VoidCallback? onTap,
    FormFieldValidator<String>? validator,
  }) {
    final themeData = Theme.of(context);

    final effectiveLabelStyle = labelStyle ?? theme.labelStyle;
    final effectivePrimaryColor = cursorColor ?? theme.primaryColor;

    final textField = TextFormField(
      controller: controller,
      enabled: enabled,
      readOnly: readOnly,
      obscureText: obscureText,
      maxLines: obscureText ? 1 : maxLines,
      maxLength: maxLength,
      autovalidateMode: autoValidate == true
          ? AutovalidateMode.always
          : AutovalidateMode.disabled,

      style:
          textStyle ??
          effectiveLabelStyle.copyWith(
            fontSize: fontSize ?? 16,
            color: themeData.textTheme.bodyLarge?.color,
          ),
      cursorColor: effectivePrimaryColor,
      cursorHeight: cursorHeight,

      keyboardType: _keyboardType(
        keyboardType,
        isDouble,
        isNumber,
        isMobile,
        isPinCode,
        isPercentage,
        isEmail,
      ),

      inputFormatters:
          inputFormatters ??
          _inputFormatters(
            isDouble,
            isPercentage,
            isMobile,
            isPinCode,
            isGST,
            isNumber,
            uppercaseOnly,
            lowercaseOnly,
            denySpace,
          ),

      onTap: onTap,
      onChanged: onChanged,

      validator:
          validator ??
          _defaultValidator(
            isMandatory,
            isMobile,
            isEmail,
            isPinCode,
            isGST,
            externalLabel ?? label,
            hint,
          ),

      decoration: _decoration(
        context: context,
        label: label,
        hint: hint,
        style: style,
        theme: theme,
        layout: fieldLayout,
        contentPadding: contentPadding,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        suffixIconConstraints: suffixIconConstraints,
        isMandatory: isMandatory,
        borderRadius: borderRadius,
        fillColor: fillColor,
        cursorColor: cursorColor,
        fontSize: fontSize,
        floatingLabelAlignment: floatingLabelAlignment,
        hintStyle: hintStyle,
        floatingLabelStyle: floatingLabelStyle,
      ),
    );

    /// EXTERNAL LABEL Logic
    if (externalLabel != null) {
      return Container(
        margin: margin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 2, bottom: 5),
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      externalLabel,
                      style: TextStyle(
                        color: themeData.textTheme.bodyLarge?.color,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  if (isMandatory) ...[
                    const Text(" *", style: TextStyle(color: Colors.red)),
                  ],
                ],
              ),
            ),
            textField,
          ],
        ),
      );
    }

    /// LABEL ABOVE layout
    if (fieldLayout == FlexiFieldLayout.labelAbove && label != null) {
      return Container(
        margin: margin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const SizedBox(width: 2),
                Text(
                  label,
                  style: effectiveLabelStyle.copyWith(
                    color: themeData.textTheme.bodyLarge?.color,
                  ),
                ),
                if (isMandatory) ...[
                  const SizedBox(width: 2),
                  const Text(
                    '*',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 5),
            textField,
          ],
        ),
      );
    }

    return Container(margin: margin, child: textField);
  }

  static InputDecoration _decoration({
    required BuildContext context,
    String? label,
    String? hint,
    required FlexiFieldStyle style,
    required FlexiFormTheme theme,
    required FlexiFieldLayout layout,
    EdgeInsetsGeometry? contentPadding,
    Widget? prefixIcon,
    Widget? suffixIcon,
    BoxConstraints? suffixIconConstraints,
    bool isMandatory = false,
    double? borderRadius,
    Color? fillColor,
    Color? cursorColor,
    double? fontSize,
    FloatingLabelAlignment? floatingLabelAlignment,
    TextStyle? hintStyle,
    TextStyle? floatingLabelStyle,
  }) {
    final themeData = Theme.of(context);
    final isDark = themeData.brightness == Brightness.dark;

    return InputDecoration(
      isDense: true,
      floatingLabelAlignment: floatingLabelAlignment,
      floatingLabelStyle: floatingLabelStyle,

      /// LABEL (Widget-based)
      label: layout == FlexiFieldLayout.floating && label != null
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    label,
                    style: TextStyle(
                      color: themeData.hintColor,
                      fontSize: fontSize,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                if (isMandatory) ...[
                  Text(
                    " *",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: fontSize,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ],
            )
          : null,

      /// HINT
      hintText: layout == FlexiFieldLayout.labelInline ? label ?? hint : hint,
      hintStyle:
          hintStyle ??
          TextStyle(
            fontSize: 16,
            color: themeData.hintColor,
            overflow: TextOverflow.ellipsis,
          ),

      floatingLabelBehavior: layout == FlexiFieldLayout.floating
          ? FloatingLabelBehavior.auto
          : FloatingLabelBehavior.never,

      filled:
          fillColor != null ||
          theme.fillColor != null ||
          isDark ||
          style == FlexiFieldStyle.filled,
      fillColor:
          fillColor ??
          theme.fillColor ??
          (isDark
              ? Colors.white.withValues(alpha: 0.05) // ignore: deprecated_member_use
              : themeData.colorScheme.surface),

      border: FlexiDecorators.border(
        style,
        theme,
        color: cursorColor,
        borderRadius: borderRadius,
      ),
      focusedBorder: FlexiDecorators.focusedBorder(
        style,
        theme,
        color: cursorColor,
        borderRadius: borderRadius,
      ),
      enabledBorder: FlexiDecorators.enabledBorder(
        style,
        theme,
        color: themeData.dividerColor,
        borderRadius: borderRadius,
      ),
      disabledBorder: FlexiDecorators.disabledBorder(
        style,
        theme,
        color: themeData.disabledColor,
        borderRadius: borderRadius,
      ),
      errorBorder: FlexiDecorators.errorBorder(
        style,
        theme,
        color: themeData.colorScheme.error,
        borderRadius: borderRadius,
      ),
      focusedErrorBorder: FlexiDecorators.errorBorder(
        style,
        theme,
        color: themeData.colorScheme.error,
        borderRadius: borderRadius,
      ),

      labelStyle: theme.labelStyle,
      errorStyle: theme.errorStyle,

      contentPadding:
          contentPadding ??
          EdgeInsets.symmetric(
            horizontal: style == FlexiFieldStyle.underline ? 0 : 16,
            vertical: style == FlexiFieldStyle.underline ? 5 : 10,
          ),

      prefixIcon: prefixIcon,
      prefixIconConstraints: const BoxConstraints(
        minHeight: 24,
        minWidth: 48,
        maxHeight: 48,
        maxWidth: 60,
      ),

      suffixIcon: suffixIcon,
      suffixIconConstraints:
          suffixIconConstraints ??
          const BoxConstraints(
            minHeight: 24,
            minWidth: 48,
            maxHeight: 48,
            maxWidth: 60,
          ),

      counterText: "",
    );
  }

  static TextInputType _keyboardType(
    TextInputType? fallback,
    bool isDouble,
    bool isNumber,
    bool isMobile,
    bool isPin,
    bool isPercentage,
    bool isEmail,
  ) {
    if (isDouble || isPercentage) {
      return const TextInputType.numberWithOptions(decimal: true);
    }
    if (isNumber || isMobile || isPin) {
      return TextInputType.number;
    }
    if (isEmail) {
      return TextInputType.emailAddress;
    }
    return fallback ?? TextInputType.text;
  }

  static List<TextInputFormatter> _inputFormatters(
    bool isDouble,
    bool isPercentage,
    bool isMobile,
    bool isPin,
    bool isGST,
    bool isNumber,
    bool uppercase,
    bool lowercase,
    bool denySpace,
  ) {
    return [
      if (isDouble) FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),

      if (isPercentage)
        FilteringTextInputFormatter.allow(
          RegExp(r'^0*([1-9][0-9]?|100)?(\.\d{0,2})?$|^0*\.\d{0,2}$'),
        ),

      if (isMobile) ...[
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ],

      if (isPin) ...[
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(6),
      ],

      if (isGST) ...[
        LengthLimitingTextInputFormatter(15),
        TextInputFormatter.withFunction(
          (oldValue, newValue) => newValue.copyWith(
            text: newValue.text.toUpperCase(),
            selection: newValue.selection,
          ),
        ),
      ],

      if (isNumber) FilteringTextInputFormatter.digitsOnly,

      if (uppercase)
        TextInputFormatter.withFunction(
          (oldValue, newValue) => newValue.copyWith(
            text: newValue.text.toUpperCase(),
            selection: newValue.selection,
          ),
        ),

      if (lowercase)
        TextInputFormatter.withFunction(
          (oldValue, newValue) => newValue.copyWith(
            text: newValue.text.toLowerCase(),
            selection: newValue.selection,
          ),
        ),

      if (denySpace) FilteringTextInputFormatter.deny(RegExp(r'\s')),
    ];
  }

  static FormFieldValidator<String> _defaultValidator(
    bool isMandatory,
    bool isMobile,
    bool isEmail,
    bool isPin,
    bool isGST,
    String? label,
    String? hint,
  ) {
    return (value) {
      if (isMandatory && (value == null || value.isEmpty)) {
        return 'Enter ${label ?? hint ?? "value"}'.replaceAll("*", "").trim();
      }

      if (value != null && value.isNotEmpty) {
        if (isMobile && value.length != 10) {
          return 'Enter valid mobile number';
        }

        if (isEmail) {
          final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
          if (!regex.hasMatch(value)) {
            return 'Enter valid email address';
          }
        }

        if (isPin && value.length < 6) {
          return 'Enter valid pincode';
        }

        if (isGST) {
          final gstRegex = RegExp(
            r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$',
          );
          if (!gstRegex.hasMatch(value)) {
            return 'Enter valid GST number';
          }
        }
      }

      return null;
    };
  }
}
