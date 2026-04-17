import 'package:flutter/material.dart';

/// A premium, highly customizable button with support for gradients, shadows, 
/// and smooth animations.
///
/// [FlexiButton] follows the monochrome "Black & White" design system by default 
/// but can be tailored with custom colors, shapes, and elevation.
class FlexiButton extends StatelessWidget {
  /// The width of the button. If null, it will shrink to fit its child or expand to fill its parent.
  final double? width;

  /// The height of the button (default: 48.0).
  final double? height;

  /// The background color of the button.
  final Color? color;

  /// The widget to display inside the button (typically a [Text] or [Icon]).
  final Widget child;

  /// The border radius for the button corners (ignored if [shape] is [BoxShape.circle]).
  final double? borderRadius;

  /// Callback when the button is tapped.
  final VoidCallback onTap;

  /// A list of shadows to display behind the button.
  final List<BoxShadow>? boxShadow;

  /// The border to draw around the button.
  final Border? border;

  /// A gradient to use as the background. If provided, [color] is ignored.
  final Gradient? gradient;

  /// Internal padding for the button content.
  final EdgeInsetsGeometry? padding;

  /// Outer margin for the button container.
  final EdgeInsetsGeometry? margin;

  /// How to align the child within the button (default: Center).
  final AlignmentGeometry? alignment;

  /// The shape of the button (default: Rectangle).
  final BoxShape shape;

  /// How to clip the content (default: HardEdge).
  final Clip clipBehavior;

  /// The elevation (shadow) depth of the button.
  final double elevation;

  /// Optional box constraints for the button.
  final BoxConstraints? constraints;

  /// The color of the text/icons inside the button.
  final Color? textColor;

  /// The font size of the text within the button.
  final double? fontSize;

  /// Whether to animate size/color changes (default: true).
  final bool animate;

  /// Creates a [FlexiButton] with premium aesthetics and responsive touch feedback.
  const FlexiButton({
    super.key,
    this.width,
    this.height,
    this.color,
    required this.onTap,
    required this.child,
    this.borderRadius,
    this.boxShadow,
    this.border,
    this.gradient,
    this.padding,
    this.margin,
    this.alignment = Alignment.center,
    this.shape = BoxShape.rectangle,
    this.clipBehavior = Clip.hardEdge,
    this.elevation = 0,
    this.constraints,
    this.textColor,
    this.fontSize,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final isDark = themeData.brightness == Brightness.dark;

    final effectiveBgColor = color ?? (isDark ? Colors.white : Colors.black);
    final effectiveTextColor =
        textColor ?? (isDark ? Colors.black : Colors.white);
    final radius = borderRadius ?? 12.0;

    return Container(
      margin: margin,
      constraints: constraints,
      child: Material(
        color: Colors.transparent,
        elevation: elevation,
        shadowColor: Colors.black26,
        clipBehavior: clipBehavior,
        borderRadius: shape == BoxShape.circle
            ? null
            : BorderRadius.circular(radius),
        child: InkWell(
          onTap: onTap,
          borderRadius: shape == BoxShape.circle
              ? null
              : BorderRadius.circular(radius),
          child: AnimatedContainer(
            duration: animate
                ? const Duration(milliseconds: 200)
                : Duration.zero,
            width: width,
            height: height ?? 48.0,
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
            alignment: alignment,
            decoration: BoxDecoration(
              shape: shape,
              color: color == null && gradient == null
                  ? effectiveBgColor
                  : color,
              gradient: gradient,
              borderRadius: shape == BoxShape.circle
                  ? null
                  : BorderRadius.circular(radius),
              border: border,
              boxShadow: boxShadow,
            ),
            child: DefaultTextStyle(
              style: TextStyle(
                color: effectiveTextColor,
                fontSize: fontSize ?? 16,
                fontWeight: FontWeight.bold,
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
