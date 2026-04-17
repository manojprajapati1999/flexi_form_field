import 'package:flutter/material.dart';

import 'builders/dropdown_builder.dart';
import 'enums.dart';
import 'theme.dart';

/// A premium dropdown selection widget with rich styling and built-in layout options.
///
/// [FlexiDropDown] provides a consistent selection experience, supporting various
/// border styles, layouts (floating or external), and container wrappers (cards).
class FlexiDropDown<T> extends StatelessWidget {
  /// The visual style of the input border (e.g., outline, filled, rounded).
  final FlexiFieldStyle fieldStyle;

  /// The placement of the label relative to the dropdown field.
  final FlexiFieldLayout fieldLayout;

  /// An optional container wrapper for the entire dropdown field (e.g., card, outlined).
  final FlexiFieldWrapper wrapper;

  /// Optional theme override for this specific field.
  final FlexiFormTheme? theme;

  /// The label displayed inside the input border (Material style).
  final String? label;

  /// A label displayed outside (above) the input field.
  final String? externalLabel;

  /// Hint text shown when no value is selected.
  final String? hint;

  /// The list of items to display in the dropdown menu.
  final List<DropdownMenuItem<T>>? items;

  /// The currently selected value.
  final T? value;

  /// Callback when the selected value changes.
  final ValueChanged<T?>? onChanged;

  /// Whether the field is interactive.
  final bool enabled;

  /// Whether this field is marked as mandatory (shows '*' indicator).
  final bool isMandatory;

  /// Internal padding for the input field.
  final EdgeInsetsGeometry? contentPadding;

  /// Outer margin for the form field container.
  final EdgeInsetsGeometry? margin;

  /// Widget shown at the beginning of the input field.
  final Widget? prefixIcon;

  /// Widget shown at the end of the input field (typically the dropdown arrow).
  final Widget? suffixIcon;

  /// Constraints for the suffix icon container.
  final BoxConstraints? suffixIconConstraints;

  /// Font size override for the input text.
  final double? fontSize;

  /// Border radius override for the input field.
  final double? borderRadius;

  /// Background fill color override.
  final Color? fillColor;

  /// Color of the cursor.
  final Color? cursorColor;

  /// Alignment logic for the floating label.
  final FloatingLabelAlignment? floatingLabelAlignment;

  /// Full text style override for the selected item text.
  final TextStyle? style;

  /// Style override for the label text.
  final TextStyle? labelStyle;

  /// Style override for the hint text.
  final TextStyle? hintStyle;

  /// Style override for the floating label.
  final TextStyle? floatingLabelStyle;

  /// Creates a [FlexiDropDown] widget with granular control over its aesthetics.
  const FlexiDropDown({
    super.key,
    this.fieldStyle = FlexiFieldStyle.outline,
    this.fieldLayout = FlexiFieldLayout.floating,
    this.wrapper = FlexiFieldWrapper.none,
    this.theme,
    this.label,
    this.externalLabel,
    this.hint,
    this.items,
    this.value,
    this.onChanged,
    this.enabled = true,
    this.isMandatory = false,
    this.contentPadding,
    this.margin,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixIconConstraints,
    this.fontSize,
    this.borderRadius,
    this.fillColor,
    this.cursorColor,
    this.floatingLabelAlignment,
    this.style,
    this.labelStyle,
    this.hintStyle,
    this.floatingLabelStyle,
  });

  @override
  Widget build(BuildContext context) {
    final appliedTheme = theme ?? const FlexiFormTheme();

    Widget field = FlexiDropdownBuilder.build<T>(
      context: context,
      value: value,
      items: items ?? const [],
      label: label,
      externalLabel: externalLabel,
      hint: hint,
      style: fieldStyle,
      fieldLayout: fieldLayout,
      theme: appliedTheme,
      onChanged: onChanged,
      contentPadding: contentPadding,
      margin: margin,
      enabled: enabled,
      isMandatory: isMandatory,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      suffixIconConstraints: suffixIconConstraints,
      // Pass premium styles
      fontSize: fontSize,
      borderRadius: borderRadius,
      fillColor: fillColor,
      cursorColor: cursorColor,
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
