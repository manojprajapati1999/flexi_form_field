import 'package:flutter/material.dart';

/// A premium horizontally-scrolling stepper widget.
///
/// [FlexiStepper] provides a sleek way to navigate through multiple steps in 
/// a process. It supports smooth scrolling, automatic alignment, and 
/// rich customization for active and inactive states.
class FlexiStepper extends StatefulWidget {
  /// The index of the currently active step.
  final int currentStep;

  /// The list of titles for each step in the process.
  final List<String> stepTitles;

  /// Callback when a step is tapped by the user.
  final Function(int index)? onStepChange;

  /// Color of the active step indicator.
  final Color? activeColor;

  /// Color of the inactive step indicators.
  final Color? inactiveColor;

  /// Text color for the active step label.
  final Color? activeTextColor;

  /// Text color for the inactive step labels.
  final Color? inactiveTextColor;

  /// The height of the stepper container (default: 36).
  final double height;

  /// The duration of the scroll animation when changing steps (default: 500ms).
  final Duration scrollDuration;

  /// The curve used for the scroll animation (default: EasingInOut).
  final Curve scrollCurve;

  /// The text style for the step labels.
  final TextStyle? textStyle;

  /// The border radius for the step indicators.
  final double? borderRadius;

  /// Internal padding for the stepper container.
  final EdgeInsetsGeometry? padding;

  /// Outer margin for the stepper container.
  final EdgeInsetsGeometry? margin;

  /// Creates a [FlexiStepper] widget with advanced scrolling and premium aesthetics.
  const FlexiStepper({
    super.key,
    required this.currentStep,
    required this.stepTitles,
    this.onStepChange,
    this.activeColor,
    this.inactiveColor,
    this.activeTextColor,
    this.inactiveTextColor,
    this.height = 36,
    this.scrollDuration = const Duration(milliseconds: 500),
    this.scrollCurve = Curves.easeInOut,
    this.textStyle,
    this.borderRadius,
    this.padding,
    this.margin,
  });

  @override
  State<FlexiStepper> createState() => _FlexiStepperState();
}

class _FlexiStepperState extends State<FlexiStepper> {
  final List<GlobalKey> _itemKeys = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _generateKeys();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToItem(widget.currentStep, animate: false);
    });
  }

  @override
  void didUpdateWidget(covariant FlexiStepper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.stepTitles.length != widget.stepTitles.length) {
      _generateKeys();
    }
    if (oldWidget.currentStep != widget.currentStep) {
      _scrollToItem(widget.currentStep);
    }
  }

  void _generateKeys() {
    _itemKeys.clear();
    _itemKeys.addAll(
      List.generate(widget.stepTitles.length, (_) => GlobalKey()),
    );
  }

  void _scrollToItem(int index, {bool animate = true}) {
    if (index < 0 || index >= _itemKeys.length) return;

    final keyContext = _itemKeys[index].currentContext;
    if (keyContext != null) {
      final box = keyContext.findRenderObject() as RenderBox;
      final itemPosition = box.localToGlobal(Offset.zero);

      final listPosition = context.findRenderObject() as RenderBox;
      final listGlobal = listPosition.localToGlobal(Offset.zero);

      final dx = itemPosition.dx - listGlobal.dx;
      final targetOffset =
          _scrollController.offset +
          dx -
          (listPosition.size.width / 2) +
          (box.size.width / 2);

      final clampedOffset = targetOffset.clamp(
        0.0,
        _scrollController.position.maxScrollExtent,
      );

      if (animate) {
        _scrollController.animateTo(
          clampedOffset,
          duration: widget.scrollDuration,
          curve: widget.scrollCurve,
        );
      } else {
        _scrollController.jumpTo(clampedOffset);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final isDark = themeData.brightness == Brightness.dark;

    final effectiveActiveColor =
        widget.activeColor ?? (isDark ? Colors.white : Colors.black);
    final effectiveInactiveColor =
        widget.inactiveColor ??
        (isDark ? Colors.white24 : Colors.grey.shade300);

    final effectiveActiveText =
        widget.activeTextColor ?? (isDark ? Colors.black : Colors.white);
    final effectiveInactiveText =
        widget.inactiveTextColor ?? themeData.hintColor;

    final effectiveRadius = widget.borderRadius ?? 12.0;

    return Container(
      height: widget.height,
      margin: widget.margin,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: widget.stepTitles.length,
        scrollDirection: Axis.horizontal,
        padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 16),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final isActive = widget.currentStep == index;

          return IntrinsicWidth(
            key: _itemKeys[index],
            child: GestureDetector(
              onTap: () => widget.onStepChange?.call(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                margin: EdgeInsets.only(right: 8, left: index == 0 ? 0 : 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(effectiveRadius),
                  color: isActive ? effectiveActiveColor : Colors.transparent,
                  border: Border.all(
                    width: isActive ? 0 : 1.2,
                    color: isActive
                        ? Colors.transparent
                        : effectiveInactiveColor,
                  ),
                ),
                child: Text(
                  "(${index + 1}) ${widget.stepTitles[index]}",
                  style:
                      widget.textStyle?.copyWith(
                        color: isActive
                            ? effectiveActiveText
                            : effectiveInactiveText,
                        fontWeight: isActive
                            ? FontWeight.bold
                            : FontWeight.w500,
                      ) ??
                      TextStyle(
                        fontSize: 13,
                        fontWeight: isActive
                            ? FontWeight.bold
                            : FontWeight.w500,
                        color: isActive
                            ? effectiveActiveText
                            : effectiveInactiveText,
                      ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
