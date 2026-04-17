import 'package:flutter/material.dart';
import '../decorators.dart';
import '../enums.dart';
import '../theme.dart';

/// A helper builder class for creating a standardized [DropdownButtonFormField] 
/// that follows the Flexi design system.
/// An internal builder class that handles the complex construction of 
/// [DropdownButtonFormField]s within the Flexi design system.
///
/// [FlexiDropdownBuilder] abstracts the logic for layout selection, decoration,
/// and menu styling, ensuring that dropdowns match the established design language.
class FlexiDropdownBuilder {
  /// Builds a [Widget] containing a [DropdownButtonFormField] with the 
  /// specified styles and behaviors.
  static Widget build<T>({
    required BuildContext context,
    required T? value,
    required List<DropdownMenuItem<T>> items,
    required String? label,
    String? externalLabel,
    String? hint,
    required FlexiFieldStyle style,
    required FlexiFieldLayout fieldLayout,
    required FlexiFormTheme theme,
    bool isMandatory = false,
    bool enabled = true,
    EdgeInsetsGeometry? contentPadding,
    EdgeInsetsGeometry? margin,
    Widget? prefixIcon,
    BoxConstraints? prefixIconConstraints,
    Widget? suffixIcon,
    BoxConstraints? suffixIconConstraints,

    // Premium Styles
    double? fontSize,
    double? borderRadius,
    Color? fillColor,
    Color? cursorColor,
    FloatingLabelAlignment? floatingLabelAlignment,
    TextStyle? textStyle,
    TextStyle? labelStyle,
    TextStyle? hintStyle,
    TextStyle? floatingLabelStyle,

    // callbacks
    ValueChanged<T?>? onChanged,
    FormFieldValidator<T>? validator,
  }) {
    final themeData = Theme.of(context);
    final isDark = themeData.brightness == Brightness.dark;

    final effectiveLabelStyle = labelStyle ?? theme.labelStyle;
    final effectiveRadius = borderRadius ?? theme.borderRadius.topLeft.x;

    final dropdown = DropdownButtonFormField<T>(
      // ignore: deprecated_member_use
      value: value,
      items: items.map((item) {
        return DropdownMenuItem<T>(
          value: item.value,
          enabled: item.enabled,
          alignment: item.alignment,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              item.child,
              if (item != items.last) ...[
                const SizedBox(height: 8),
                Divider(
                  color: themeData.dividerColor.withOpacity(0.5), // ignore: deprecated_member_use
                  height: 1,
                  thickness: 0.5,
                ),
              ],
            ],
          ),
        );
      }).toList(),
      onChanged: enabled ? onChanged : null,
      selectedItemBuilder: (context) {
        return items.map((item) {
          return Container(
            alignment: Alignment.centerLeft,
            child: item.child,
          );
        }).toList();
      },
      validator: validator ??
          (val) {
            if (isMandatory && (val == null || val.toString().isEmpty)) {
              return 'Select ${externalLabel ?? label ?? hint ?? "value"}'
                  .replaceAll("*", "")
                  .trim();
            }
            return null;
          },
      style:
          textStyle ??
          effectiveLabelStyle.copyWith(
            fontSize: fontSize ?? 16,
            color: themeData.textTheme.bodyLarge?.color,
          ),
      dropdownColor: isDark ? themeData.colorScheme.surface : Colors.white,
      borderRadius: BorderRadius.circular(effectiveRadius),
      elevation: 4,
      alignment: AlignmentDirectional.centerStart,
      menuMaxHeight: 350,
      decoration: _decoration(
        context: context,
        label: label,
        hint: hint,
        style: style,
        theme: theme,
        layout: fieldLayout,
        contentPadding: contentPadding,
        prefixIcon: prefixIcon,
        prefixIconConstraints: prefixIconConstraints,
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
      isDense: true,
      icon: Container(
        alignment: Alignment.center,
        width: 48,
        height: 48,
        child:
            suffixIcon ??
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: isDark ? Colors.white70 : Colors.black54,
              size: 25,
            ),
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
                      style: TextStyle(color: themeData.textTheme.bodyLarge?.color, fontWeight: FontWeight.w600, overflow: TextOverflow.ellipsis),
                      maxLines: 1,
                    ),
                  ),
                  if (isMandatory) ...[const Text(" *", style: TextStyle(color: Colors.red))],
                ],
              ),
            ),
            dropdown,
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
                Text(label, style: effectiveLabelStyle.copyWith(color: themeData.textTheme.bodyLarge?.color)),
                if (isMandatory) ...[
                  const SizedBox(width: 2),
                  const Text(
                    '*',
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 5),
            dropdown,
          ],
        ),
      );
    }
    return Container(margin: margin, child: dropdown);
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
    BoxConstraints? prefixIconConstraints,
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
      label: layout == FlexiFieldLayout.floating && label != null ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    label,
                    style: TextStyle(color: themeData.hintColor, fontSize: fontSize, overflow: TextOverflow.ellipsis),
                  ),
                ),
                if (isMandatory) ...[
                  Text(
                    " *",
                    style: TextStyle(color: Colors.red, fontSize: fontSize, overflow: TextOverflow.ellipsis),
                  ),
                ],
              ],
            ) : null,
      hintText: layout == FlexiFieldLayout.labelInline ? label ?? hint : hint,
      hintStyle: hintStyle ?? TextStyle(fontSize: 16, color: themeData.hintColor, overflow: TextOverflow.ellipsis),
      floatingLabelBehavior: layout == FlexiFieldLayout.floating ? FloatingLabelBehavior.auto : FloatingLabelBehavior.never,
      filled: fillColor != null || theme.fillColor != null || isDark || style == FlexiFieldStyle.filled,
      // ignore: deprecated_member_use
      fillColor: fillColor ?? theme.fillColor ?? (isDark ? Colors.white.withOpacity(0.05) : themeData.colorScheme.surface),
      border: FlexiDecorators.border(style, theme, color: cursorColor, borderRadius: borderRadius),
      focusedBorder: FlexiDecorators.focusedBorder(style, theme, color: cursorColor, borderRadius: borderRadius),
      enabledBorder: FlexiDecorators.enabledBorder(style, theme, color: themeData.dividerColor, borderRadius: borderRadius),
      disabledBorder: FlexiDecorators.disabledBorder(style, theme, color: themeData.disabledColor, borderRadius: borderRadius),
      errorBorder: FlexiDecorators.errorBorder(style, theme, color: themeData.colorScheme.error, borderRadius: borderRadius),
      focusedErrorBorder: FlexiDecorators.errorBorder(style, theme, color: themeData.colorScheme.error, borderRadius: borderRadius),
      contentPadding: contentPadding ?? EdgeInsets.symmetric(horizontal: style == FlexiFieldStyle.underline ? 0 : 16, vertical: style == FlexiFieldStyle.underline ? 7 : 11),
      prefixIcon: prefixIcon,
      prefixIconConstraints:
          prefixIconConstraints ??
          const BoxConstraints(
            minHeight: 48,
            minWidth: 48,
            maxHeight: 48,
            maxWidth: 60,
          ),
      suffixIconConstraints: suffixIconConstraints ?? const BoxConstraints(minHeight: 20, minWidth: 40, maxHeight: 30, maxWidth: 40),
      counterText: "",
    );
  }
}
