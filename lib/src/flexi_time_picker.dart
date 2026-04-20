import 'package:flutter/material.dart';
import 'decorators.dart';
import 'enums.dart';
import 'theme.dart';

/// A premium time picker input widget that provides a standard Material time selection
/// experience within the Flexi design system.
///
/// [FlexiTimePicker] simplifies time selection by handling the picker dialog 
/// and formatting the result into the associated controller.
class FlexiTimePicker extends StatelessWidget {
  /// Controller for the selected time text.
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

  /// Whether to show a clear button when a time is selected.
  final bool showClearButton;

  /// The time that is initially selected when the picker opens.
  final TimeOfDay? initialTime;

  /// Optional focus node for the input field.
  final FocusNode? focusNode;

  /// Focus node to request after a time is selected.
  final FocusNode? nextFocusNode;

  /// Internal padding for the input field.
  final EdgeInsetsGeometry? contentPadding;

  /// Outer margin for the form field container.
  final EdgeInsetsGeometry? margin;

  /// Widget shown at the beginning of the input field.
  final Widget? prefixIcon;

  /// Custom validation logic for the input.
  final String? Function(String?)? validator;

  /// Callback when a time is selected.
  final Function(TimeOfDay? time, String? stringTime)? onSelect;

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

  /// Creates a [FlexiTimePicker] for consistent time selection.
  const FlexiTimePicker({
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
    this.initialTime,
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

              fillColor:
                  fillColor ??
                  appliedFlexiTheme.fillColor ??
                  (isDark
                      // ignore: deprecated_member_use
                      ? Colors.white.withValues(alpha: 0.05)
                      : themeData.colorScheme.surface),

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
                        onSelect?.call(null, null);
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
                      Icons.access_time_filled_rounded,
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
                    TimeOfDay? time = await showTimePicker(
                      context: context,
                      initialTime: initialTime ?? TimeOfDay.now(),
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

                    if (time != null) {
                      if (context.mounted) {
                        final formatted = time.format(context);
                        controller.text = formatted;
                        onSelect?.call(time, formatted);
                        if (nextFocusNode != null) {
                          FocusScope.of(context).requestFocus(nextFocusNode);
                        }
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
