import 'package:flutter/material.dart';
import 'theme.dart';

/// A premium, stylized tab bar widget.
///
/// [FlexiTabBar] provides a modern, monochrome tab navigation experience.
/// It is designed to be used in conjunction with [FlexiTabView] or a [PageView].
class FlexiTabBar extends StatelessWidget {
  /// The list of tab labels.
  final List<String> tabs;

  /// Callback when a tab is tapped.
  final Function(int index) onChange;

  /// The currently selected tab index.
  final int currentIndex;

  /// Font size for the tab labels (default: 15).
  final double fontSize;

  /// Outer margin for the tab bar container.
  final EdgeInsetsGeometry? margin;

  /// Optional theme override for this specific widget.
  final FlexiFormTheme? theme;

  /// Creates a [FlexiTabBar] widget.
  const FlexiTabBar({
    super.key,
    required this.tabs,
    required this.onChange,
    required this.currentIndex,
    this.fontSize = 15,
    this.margin,
    this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final appliedFlexiTheme = theme ?? const FlexiFormTheme();
    final primaryColor = appliedFlexiTheme.primaryColor;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return IntrinsicHeight(
      child: Container(
        alignment: Alignment.center,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: isDark ? Colors.white.withValues(alpha: 0.05) : const Color(0XFFDDDFDE),
          borderRadius: appliedFlexiTheme.borderRadius,
        ),
        margin: margin ?? const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: tabs.asMap().entries.map((entry) {
            final index = entry.key;
            final label = entry.value;
            final isSelected = currentIndex == index;

            return Expanded(
              child: InkWell(
                onTap: () => onChange(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  alignment: Alignment.center,
                  height: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor : Colors.transparent,
                    borderRadius: appliedFlexiTheme.borderRadius,
                  ),
                  child: Text(
                    label,
                    style: TextStyle(
                      color: isSelected ? Colors.white : (isDark ? Colors.white70 : Colors.black87),
                      fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
                      fontSize: fontSize,
                      letterSpacing: isSelected ? 0.5 : 0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

/// A companion widget for [FlexiTabBar] that displays the content of the tabs.
///
/// [FlexiTabView] supports optional swipe navigation and integrates seamlessly 
/// with [FlexiTabBar] state.
class FlexiTabView extends StatefulWidget {
  /// The widgets to display for each tab.
  final List<Widget> children;

  /// The currently active tab index.
  final int currentIndex;

  /// Callback when the user swipes to change the tab.
  final ValueChanged<int>? onPageChanged;

  /// Whether to enable swipe navigation (default: true).
  final bool isSwipeEnabled;

  /// Creates a [FlexiTabView] widget.
  const FlexiTabView({
    super.key,
    required this.children,
    required this.currentIndex,
    this.onPageChanged,
    this.isSwipeEnabled = true,
  });

  @override
  State<FlexiTabView> createState() => _FlexiTabViewState();
}

class _FlexiTabViewState extends State<FlexiTabView> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.currentIndex);
  }

  @override
  void didUpdateWidget(FlexiTabView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _pageController.animateToPage(
        widget.currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: widget.isSwipeEnabled ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
      controller: _pageController,
      onPageChanged: widget.onPageChanged,
      children: widget.children,
    );
  }
}
