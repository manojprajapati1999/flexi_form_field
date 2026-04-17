import 'package:flutter/material.dart';

/// A premium, segmented tab bar widget with smooth transitions and rich styling.
///
/// [FlexiTabBar] provides a modern alternative to traditional tab bars, 
/// featuring a capsule-like design with animated selection indicators 
/// and support for custom gradients.
class FlexiTabBar extends StatelessWidget {
  /// The list of labels for each tab.
  final List<String> tabs;

  /// Callback when the user selects a tab.
  final Function(int index) onChanged;

  /// The index of the currently selected tab.
  final int currentIndex;

  /// Color of the active tab indicator.
  final Color? activeColor;

  /// Color of the inactive tabs.
  final Color? inactiveColor;

  /// Background color of the entire tab bar container.
  final Color? backgroundColor;

  /// Text color for the active tab label.
  final Color? activeTextColor;

  /// Text color for the inactive tab labels.
  final Color? inactiveTextColor;

  /// Optional gradient for the active tab indicator.
  final Gradient? activeGradient;

  /// Font size for the tab labels.
  final double? fontSize;

  /// Outer margin for the tab bar container.
  final EdgeInsetsGeometry? margin;

  /// Internal padding for the tab bar container.
  final EdgeInsetsGeometry? padding;

  /// Border radius for the tab bar corners.
  final double? borderRadius;

  /// Height override for the tab bar.
  final double? height;

  /// Creates a [FlexiTabBar] with premium aesthetics and smooth animations.
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
        // ignore: deprecated_member_use
        (isDark ? Colors.white.withOpacity(0.1) : Colors.grey.shade200);

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
                            // ignore: deprecated_member_use
                            color: Colors.black.withOpacity(0.1),
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
