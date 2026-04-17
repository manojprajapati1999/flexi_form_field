import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'decorators.dart';
import 'enums.dart';
import 'theme.dart';

/// A premium date picker input widget that provides a standard Material date selection
/// experience within the Flexi design system.
///
/// [FlexiDatePicker] handles date formatting, validation, and provides 
/// rich styling options for the input field and external labels.
class FlexiDatePicker extends StatelessWidget {
  /// Controller for the selected date text.
  final TextEditingController controller;

  /// The label displayed inside the input border (Material style).
  final String? label;

  /// A label displayed outside (above) the input field.
  final String? externalLabel;

  /// Hint text shown when the input is empty.
  final String? hint;

  /// Custom error text to display when validation fails.
  final String? errorText;

  /// Whether this field is marked as mandatory (shows '*' indicator).
  final bool isMandatory;

  /// Whether the field is interactive.
  final bool enabled;

  /// Whether to validate the input automatically.
  final bool autoValidate;

  /// Whether to show a clear button when a date is selected.
  final bool showClearButton;

  /// The earliest date the user is permitted to pick.
  final DateTime? firstDate;

  /// The latest date the user is permitted to pick.
  final DateTime? lastDate;

  /// The date that is initially selected when the picker opens.
  final DateTime? initialDate;

  /// The date that is considered "today" in the picker.
  final DateTime? currentDate;

  /// The format used to display the date (default: 'dd-MM-yyyy').
  final String dateFormat;

  /// Optional focus node for the input field.
  final FocusNode? focusNode;

  /// Focus node to request after a date is selected.
  final FocusNode? nextFocusNode;

  /// Internal padding for the input field.
  final EdgeInsetsGeometry? contentPadding;

  /// Outer margin for the form field container.
  final EdgeInsetsGeometry? margin;

  /// Widget shown at the beginning of the input field.
  final Widget? prefixIcon;

  /// Custom validation logic for the input.
  final String? Function(String?)? validator;

  /// Callback when a date is selected.
  final Function(DateTime? date, String stringDate)? onSelect;

  /// Optional theme override for this specific field.
  final FlexiFormTheme? theme;

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

  /// The visual style of the input border (e.g., outline, filled, rounded).
  final FlexiFieldStyle fieldStyle;

  /// Creates a [FlexiDatePicker] widget for standard and consistent date selection.
  const FlexiDatePicker({
    super.key,
    required this.controller,
    this.label,
    this.externalLabel,
    this.hint,
    this.errorText,
    this.isMandatory = false,
    this.enabled = true,
    this.autoValidate = false,
    this.showClearButton = true,
    this.firstDate,
    this.lastDate,
    this.initialDate,
    this.currentDate,
    this.dateFormat = 'dd-MM-yyyy',
    this.focusNode,
    this.nextFocusNode,
    this.contentPadding,
    this.margin,
    this.prefixIcon,
    this.validator,
    this.onSelect,
    this.theme,
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
    this.fieldStyle = FlexiFieldStyle.outline,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final isDark = themeData.brightness == Brightness.dark;
    final appliedFlexiTheme = theme ?? const FlexiFormTheme();

    final effectiveLabelStyle = labelStyle ?? appliedFlexiTheme.labelStyle;
    final effectivePrimaryColor = cursorColor ?? appliedFlexiTheme.primaryColor;

    return Container(
      margin: margin,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // External Label
          if (externalLabel != null) ...[
            Padding(
              padding: const EdgeInsets.only(left: 2, bottom: 5),
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      externalLabel!,
                      style: TextStyle(
                        color: themeData.textTheme.bodyLarge?.color,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w600,
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
          ],

          TextFormField(
            controller: controller,
            readOnly: true,
            enabled: enabled,
            focusNode: focusNode,
            autovalidateMode: autoValidate
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            style:
                style ??
                effectiveLabelStyle.copyWith(
                  fontSize: fontSize ?? 16,
                  color: themeData.textTheme.bodyLarge?.color,
                ),
            cursorColor: effectivePrimaryColor,
            cursorHeight: cursorHeight,
            decoration: InputDecoration(
              isDense: true,
              prefixIcon: prefixIcon,
              prefixIconConstraints: const BoxConstraints(
                minHeight: 24,
                minWidth: 48,
                maxHeight: 48,
                maxWidth: 60,
              ),
              floatingLabelAlignment: floatingLabelAlignment,

              fillColor: fillColor ?? appliedFlexiTheme.fillColor ?? (isDark ? Colors.white.withOpacity(0.05) : themeData.colorScheme.surface), // ignore: deprecated_member_use

              filled:
                  fillColor != null ||
                  appliedFlexiTheme.fillColor != null ||
                  isDark ||
                  fieldStyle == FlexiFieldStyle.filled,

              floatingLabelStyle: floatingLabelStyle,
              contentPadding:
                  contentPadding ??
                  EdgeInsets.symmetric(
                    horizontal: fieldStyle == FlexiFieldStyle.underline
                        ? 0
                        : 16,
                    vertical: fieldStyle == FlexiFieldStyle.underline ? 5 : 10,
                  ),

              border: FlexiDecorators.border(
                fieldStyle,
                appliedFlexiTheme,
                color: cursorColor,
                borderRadius: borderRadius,
              ),
              focusedBorder: FlexiDecorators.focusedBorder(
                fieldStyle,
                appliedFlexiTheme,
                color: cursorColor,
                borderRadius: borderRadius,
              ),
              enabledBorder: FlexiDecorators.enabledBorder(
                fieldStyle,
                appliedFlexiTheme,
                color: themeData.dividerColor,
                borderRadius: borderRadius,
              ),
              disabledBorder: FlexiDecorators.disabledBorder(
                fieldStyle,
                appliedFlexiTheme,
                color: themeData.disabledColor,
                borderRadius: borderRadius,
              ),
              errorBorder: FlexiDecorators.errorBorder(
                fieldStyle,
                appliedFlexiTheme,
                color: themeData.colorScheme.error,
                borderRadius: borderRadius,
              ),
              focusedErrorBorder: FlexiDecorators.errorBorder(
                fieldStyle,
                appliedFlexiTheme,
                color: themeData.colorScheme.error,
                borderRadius: borderRadius,
              ),

              label: label == null
                  ? null
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            label!,
                            style: TextStyle(
                              color: themeData.hintColor,
                              overflow: TextOverflow.ellipsis,
                              fontSize: fontSize,
                            ),
                            maxLines: 1,
                          ),
                        ),
                        if (isMandatory) ...[
                          Text(
                            " *",
                            style: TextStyle(
                              color: Colors.red,
                              overflow: TextOverflow.ellipsis,
                              fontSize: fontSize,
                            ),
                            maxLines: 1,
                          ),
                        ],
                      ],
                    ),

              hintText: hint,
              hintStyle:
                  hintStyle ??
                  TextStyle(
                    fontSize: 16,
                    color: themeData.hintColor,
                    overflow: TextOverflow.ellipsis,
                  ),

              suffixIconConstraints: const BoxConstraints(
                minHeight: 24,
                minWidth: 48,
                maxHeight: 48,
                maxWidth: 60,
              ),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (controller.text.isNotEmpty && showClearButton)
                    GestureDetector(
                      onTap: () {
                        controller.clear();
                        onSelect?.call(null, "");
                      },
                      child: Icon(
                        Icons.cancel,
                        color: isDark ? Colors.white70 : Colors.black54,
                        size: 20,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(
                      Icons.calendar_today_rounded,
                      color: isDark ? Colors.white70 : Colors.black54,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            onTap: !enabled
                ? null
                : () async {
                    DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: initialDate ?? DateTime.now(),
                      firstDate: firstDate ?? DateTime(1900),
                      lastDate: lastDate ?? DateTime(2100),
                      currentDate: currentDate,
                      builder: (context, child) {
                        return Theme(
                          data: themeData.copyWith(
                            colorScheme: themeData.colorScheme.copyWith(
                              primary: effectivePrimaryColor,
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );

                    if (date != null) {
                      if (!context.mounted) return;
                      final formatted = DateFormat(dateFormat).format(date);
                      controller.text = formatted;
                      onSelect?.call(date, formatted);
                      if (nextFocusNode != null) {
                        if (!context.mounted) return;
                        FocusScope.of(context).requestFocus(nextFocusNode);
                      }
                    }
                  },
            validator:
                validator ??
                (value) {
                  if (isMandatory && (value == null || value.isEmpty)) {
                    return errorText ??
                        "Select ${externalLabel ?? label ?? hint ?? ""}"
                            .replaceAll("*", "")
                            .trim();
                  }
                  return null;
                },
          ),
        ],
      ),
    );
  }
}
