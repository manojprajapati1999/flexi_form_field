import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'decorators.dart';
import 'enums.dart';
import 'theme.dart';

class FlexiDateTimePicker extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final String? externalLabel;
  final String? hint;
  final String? errorText;
  final bool isMandatory;
  final bool enabled;
  final bool autoValidate;
  final bool showClearButton;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime? initialDate;
  final DateTime? currentDate;
  final TimeOfDay? initialTime;
  final String dateFormat;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? margin;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final Function(DateTime? date, String stringDate)? onSelect;
  final FlexiFormTheme? theme;
  final double? fontSize;
  final double? borderRadius;
  final Color? fillColor;
  final Color? cursorColor;
  final double? cursorHeight;
  final FloatingLabelAlignment? floatingLabelAlignment;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? floatingLabelStyle;
  final FlexiFieldStyle fieldStyle;

  const FlexiDateTimePicker({
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
    this.initialTime,
    this.dateFormat = 'dd-MM-yyyy HH:mm',
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
                      Icons.calendar_month_rounded,
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

                    if (date != null && context.mounted) {
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
                        final finalDateTime = DateTime(
                          date.year,
                          date.month,
                          date.day,
                          time.hour,
                          time.minute,
                        );
                        final formatted = DateFormat(
                          dateFormat,
                        ).format(finalDateTime);
                        controller.text = formatted;
                        onSelect?.call(finalDateTime, formatted);
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
