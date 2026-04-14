import 'package:flutter/material.dart';

class FlexiButton extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;
  final Widget child;
  final double? borderRadius;
  final VoidCallback onTap;
  final List<BoxShadow>? boxShadow;
  final Border? border;
  final Gradient? gradient;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final AlignmentGeometry? alignment;
  final BoxShape shape;
  final Clip clipBehavior;
  final double elevation;
  final BoxConstraints? constraints;

  // Premium styles
  final Color? textColor;
  final double? fontSize;
  final bool animate;

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
