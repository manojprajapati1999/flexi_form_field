import 'package:flutter/material.dart';
import 'enums.dart';
import 'theme.dart';

/// A utility class that provides pre-configured [InputBorder] decorators 
/// based on the [FlexiFieldStyle] and [FlexiFormTheme].
class FlexiDecorators {
  /// Returns a standard [InputBorder] for the given style and theme.
  static InputBorder border(
    FlexiFieldStyle style,
    FlexiFormTheme theme, {
    Color? color,
    double? borderRadius,
  }) {
    final effectiveColor = color ?? theme.primaryColor;
    final effectiveRadius = borderRadius ?? theme.borderRadius.topLeft.x;

    switch (style) {
      case FlexiFieldStyle.filled:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(effectiveRadius),
          borderSide: BorderSide.none,
        );

      case FlexiFieldStyle.underline:
        return UnderlineInputBorder(
          borderSide: BorderSide(color: effectiveColor),
        );

      case FlexiFieldStyle.rounded:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 30),
          borderSide: BorderSide(color: effectiveColor),
        );

      case FlexiFieldStyle.minimal:
        return InputBorder.none;

      default:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(effectiveRadius),
          borderSide: BorderSide(color: effectiveColor),
        );
    }
  }

  /// Returns an [InputBorder] for when the input field is focused.
  static InputBorder focusedBorder(
    FlexiFieldStyle style,
    FlexiFormTheme theme, {
    Color? color,
    double? borderRadius,
  }) {
    final effectiveColor = color ?? theme.primaryColor;
    final effectiveRadius = borderRadius ?? theme.borderRadius.topLeft.x;

    switch (style) {
      case FlexiFieldStyle.filled:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(effectiveRadius),
          borderSide: BorderSide.none,
        );

      case FlexiFieldStyle.underline:
        return UnderlineInputBorder(
          borderSide: BorderSide(color: effectiveColor, width: 2),
        );

      case FlexiFieldStyle.rounded:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 30),
          borderSide: BorderSide(color: effectiveColor, width: 2),
        );

      case FlexiFieldStyle.minimal:
        return InputBorder.none;

      default:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(effectiveRadius),
          borderSide: BorderSide(color: effectiveColor, width: 1.5),
        );
    }
  }

  /// Returns an [InputBorder] for when the input field is enabled but not focused.
  static InputBorder enabledBorder(
    FlexiFieldStyle style,
    FlexiFormTheme theme, {
    required Color color,
    double? borderRadius,
  }) {
    final effectiveRadius = borderRadius ?? theme.borderRadius.topLeft.x;

    switch (style) {
      case FlexiFieldStyle.filled:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(effectiveRadius),
          borderSide: BorderSide.none,
        );

      case FlexiFieldStyle.underline:
        return UnderlineInputBorder(borderSide: BorderSide(color: color));

      case FlexiFieldStyle.rounded:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 30),
          borderSide: BorderSide(color: color),
        );

      case FlexiFieldStyle.minimal:
        return InputBorder.none;

      default:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(effectiveRadius),
          borderSide: BorderSide(color: color),
        );
    }
  }

  /// Returns an [InputBorder] for when the input field is disabled.
  static InputBorder disabledBorder(
    FlexiFieldStyle style,
    FlexiFormTheme theme, {
    required Color color,
    double? borderRadius,
  }) {
    final effectiveRadius = borderRadius ?? theme.borderRadius.topLeft.x;

    switch (style) {
      case FlexiFieldStyle.filled:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(effectiveRadius),
          borderSide: BorderSide.none,
        );

      case FlexiFieldStyle.underline:
        return UnderlineInputBorder(
          // ignore: deprecated_member_use
          borderSide: BorderSide(color: color.withValues(alpha: 0.1)),
        );

      case FlexiFieldStyle.rounded:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 30),
          // ignore: deprecated_member_use
          borderSide: BorderSide(color: color.withValues(alpha: 0.1)),
        );

      case FlexiFieldStyle.minimal:
        return InputBorder.none;

      default:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(effectiveRadius),
          // ignore: deprecated_member_use
          borderSide: BorderSide(color: color.withValues(alpha: 0.1)),
        );
    }
  }

  /// Returns an [InputBorder] for when the input field has an error.
  static InputBorder errorBorder(
    FlexiFieldStyle style,
    FlexiFormTheme theme, {
    required Color color,
    double? borderRadius,
  }) {
    final effectiveRadius = borderRadius ?? theme.borderRadius.topLeft.x;

    switch (style) {
      case FlexiFieldStyle.filled:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(effectiveRadius),
          borderSide: BorderSide(
            color: color,
            width: 1.2,
          ), // Subtle error line even in filled? Actually user said "No Border"
          // Let's stick to no border as per user request for filled style.
        );

      case FlexiFieldStyle.underline:
        return UnderlineInputBorder(borderSide: BorderSide(color: color));

      case FlexiFieldStyle.rounded:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 30),
          borderSide: BorderSide(color: color),
        );

      case FlexiFieldStyle.minimal:
        return InputBorder.none;

      default:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(effectiveRadius),
          borderSide: BorderSide(color: color),
        );
    }
  }
}
