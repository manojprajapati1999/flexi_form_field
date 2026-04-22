import 'package:flutter/material.dart';
import 'theme.dart';

/// A premium radio button widget that supports labels and follows the 
/// Flexi design system.
///
/// [FlexiRadioButton] provides a stylized radio button with interactive 
/// labels and consistent monochrome aesthetics.
class FlexiRadioButton<T> extends StatelessWidget {
  /// The value this radio button represents.
  final T value;

  /// The currently selected value for the group.
  final T? groupValue;

  /// Callback when the radio button is selected.
  final ValueChanged<T?>? onChanged;

  /// The label displayed next to the radio button.
  final String? label;

  /// Whether the field is mandatory (shows '*' indicator).
  final bool isMandatory;

  /// Space between the radio button and the label (default: 8).
  final double spaceBetween;

  /// Optional theme override for this specific widget.
  final FlexiFormTheme? theme;

  /// Creates a [FlexiRadioButton] widget.
  const FlexiRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.label,
    this.isMandatory = false,
    this.spaceBetween = 8,
    this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final appliedFlexiTheme = theme ?? const FlexiFormTheme();
    final primaryColor = appliedFlexiTheme.primaryColor;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onChanged != null ? () => onChanged!(value) : null,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: Radio<T>(
                value: value,
                // ignore: deprecated_member_use
                groupValue: groupValue,
                // ignore: deprecated_member_use
                onChanged: onChanged,
                activeColor: primaryColor,
                fillColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return primaryColor;
                  }
                  return isDark ? Colors.white38 : Colors.grey.shade400;
                }),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
            ),
            if (label != null && label!.isNotEmpty) ...[
              SizedBox(width: spaceBetween),
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      label!,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white70 : Colors.black87,
                      ),
                    ),
                    if (isMandatory) ...[
                      const Text(
                        " *",
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
