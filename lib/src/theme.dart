import 'package:flutter/material.dart';

/// Theme configuration for the FlexiFormField package.
///
/// This class centralizes all styling properties for consistent look and feel
/// across all Flexi widgets.
class FlexiFormTheme {
  /// The primary color used for highlights, borders, and active states.
  final Color primaryColor;

  /// The border radius applied to card wrappers and input borders.
  final BorderRadius borderRadius;

  /// The text style for input text and labels.
  final TextStyle labelStyle;

  /// The text style for error messages.
  final TextStyle errorStyle;

  /// Optional background fill color for the input fields.
  final Color? fillColor;

  /// Creates a [FlexiFormTheme] with optional custom properties.
  const FlexiFormTheme({
    this.primaryColor = Colors.black,
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.labelStyle = const TextStyle(color: Colors.black87),
    this.errorStyle = const TextStyle(color: Colors.red),
    this.fillColor,
  });
}
