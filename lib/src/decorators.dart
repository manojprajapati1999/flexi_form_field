import 'package:flutter/material.dart';
import 'enums.dart';
import 'theme.dart';

class FlexiDecorators {
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
          borderSide: BorderSide(color: color.withValues(alpha: 0.1)),
        );

      case FlexiFieldStyle.rounded:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 30),
          borderSide: BorderSide(color: color.withValues(alpha: 0.1)),
        );

      case FlexiFieldStyle.minimal:
        return InputBorder.none;

      default:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(effectiveRadius),
          borderSide: BorderSide(color: color.withValues(alpha: 0.1)),
        );
    }
  }

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
