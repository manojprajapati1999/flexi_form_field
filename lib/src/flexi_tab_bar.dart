import 'package:flutter/material.dart';

class FlexiTabBar extends StatelessWidget {
  final List<String> tabs;
  final Function(int index) onChanged;
  final int currentIndex;

  // Colors
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? backgroundColor;
  final Color? activeTextColor;
  final Color? inactiveTextColor;
  final Gradient? activeGradient;

  // Layout
  final double? fontSize;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final double? height;

  const FlexiTabBar({
    super.key,
    required this.tabs,
    required this.onChanged,
    required this.currentIndex,
    this.activeColor,
    this.inactiveColor,
    this.backgroundColor,
    this.activeTextColor,
    this.inactiveTextColor,
    this.activeGradient,
    this.fontSize,
    this.margin,
    this.padding,
    this.borderRadius,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final isDark = themeData.brightness == Brightness.dark;

    final effectiveActiveColor =
        activeColor ?? (isDark ? Colors.white : Colors.black);
    final effectiveBgColor =
        backgroundColor ??
        (isDark ? Colors.white.withValues(alpha: 0.1) : Colors.grey.shade200);

    final effectiveActiveText =
        activeTextColor ?? (isDark ? Colors.black : Colors.white);
    final effectiveInactiveText = inactiveTextColor ?? themeData.hintColor;

    final radius = borderRadius ?? 12.0;

    return Container(
      height: height,
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: padding ?? const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: effectiveBgColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Row(
        children: tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final label = entry.value;
          final isActive = currentIndex == index;

          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: isActive
                      ? (activeGradient == null ? effectiveActiveColor : null)
                      : Colors.transparent,
                  gradient: isActive ? activeGradient : null,
                  borderRadius: BorderRadius.circular(
                    radius - 2,
                  ), // slightly smaller for nested look
                  boxShadow: isActive && !isDark
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  label,
                  style: TextStyle(
                    color: isActive
                        ? effectiveActiveText
                        : effectiveInactiveText,
                    fontSize: fontSize ?? 14,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
