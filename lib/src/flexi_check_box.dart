import 'package:flutter/material.dart';
import 'theme.dart';

/// A premium, highly customizable checkbox widget that follows the 
/// Flexi design system.
///
/// [FlexiCheckBox] provides a clean, monochrome look with support for 
/// labels, custom colors, and interactive feedback.
class FlexiCheckBox extends StatelessWidget {
  /// Whether the checkbox is checked.
  final bool value;

  /// The label displayed next to the checkbox.
  final String? label;

  /// Callback when the value of the checkbox changes.
  final ValueChanged<bool?>? onChanged;

  /// The color of the checkbox when it is checked.
  final Color? activeColor;

  /// The color of the checkmark inside the checkbox.
  final Color? checkColor;

  /// The color of the label text.
  final Color? labelColor;

  /// The font size of the label text.
  final double? fontSize;

  /// The style of the label text.
  final TextStyle? labelStyle;

  /// Optional theme override for this specific field.
  final FlexiFormTheme? theme;

  /// Outer margin for the checkbox container.
  final EdgeInsetsGeometry? margin;

  /// Whether to show a mandatory '*' indicator next to the label.
  final bool isMandatory;

  /// Creates a [FlexiCheckBox] widget.
  const FlexiCheckBox({
    super.key,
    required this.value,
    this.label,
    this.onChanged,
    this.activeColor,
    this.checkColor,
    this.labelColor,
    this.fontSize,
    this.labelStyle,
    this.theme,
    this.margin,
    this.isMandatory = false,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final isDark = themeData.brightness == Brightness.dark;
    final appliedFlexiTheme = theme ?? const FlexiFormTheme();

    final effectiveActiveColor = activeColor ?? appliedFlexiTheme.primaryColor;
    final effectiveCheckColor = checkColor ?? (isDark ? Colors.black : Colors.white);
    final effectiveLabelColor = labelColor ?? (isDark ? Colors.white70 : Colors.black87);

    final effectiveLabelStyle = (labelStyle ?? appliedFlexiTheme.labelStyle).copyWith(
      color: effectiveLabelColor,
      fontSize: fontSize ?? 14,
      fontWeight: FontWeight.w600,
    );

    return Container(
      margin: margin,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 24,
            width: 24,
            child: Checkbox(
              value: value,
              onChanged: onChanged,
              activeColor: effectiveActiveColor,
              checkColor: effectiveCheckColor,
              side: BorderSide(
                color: effectiveLabelColor.withValues(alpha: 0.5),
                width: 1.5,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          if (label != null && label!.trim().isNotEmpty) ...[
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onChanged != null ? () => onChanged!(!value) : null,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label!,
                    style: effectiveLabelStyle,
                  ),
                  if (isMandatory) ...[
                    const Text(
                      " *",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
