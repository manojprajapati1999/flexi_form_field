import 'package:flutter/material.dart';

import 'builders/dropdown_builder.dart';
import 'enums.dart';
import 'theme.dart';

class FlexiDropDown<T> extends StatelessWidget {
  final FlexiFieldStyle fieldStyle;
  final FlexiFieldLayout fieldLayout;
  final FlexiFieldWrapper wrapper;
  final FlexiFormTheme? theme;
  final String? label;
  final String? externalLabel;
  final String? hint;
  final List<DropdownMenuItem<T>>? items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final bool enabled;
  final bool isMandatory;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? margin;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final BoxConstraints? suffixIconConstraints;

  // Premium granular styles
  final double? fontSize;
  final double? borderRadius;
  final Color? fillColor;
  final Color? cursorColor;
  final FloatingLabelAlignment? floatingLabelAlignment;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? floatingLabelStyle;

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
