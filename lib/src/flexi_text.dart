
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

/// Modes for the [FlexiText] marquee behavior.
enum MarqueeMode {
  /// Always scroll the text regardless of length.
  always,

  /// Automatically scroll only if the text overflows its container.
  auto,

  /// Never scroll the text.
  disable,
}

/// A premium text widget with intelligent marquee support.
///
/// [FlexiText] behaves like a standard [Text] widget but can automatically 
/// transform into a scrolling marquee if the content overflows.
class FlexiText extends StatefulWidget {
  /// The text to display.
  final String text;

  /// Optional font family.
  final String? fontFamily;

  /// Text color.
  final Color? color;

  /// Font weight.
  final FontWeight? fontWeight;

  /// Font size.
  final double? fontSize;

  /// Text alignment.
  final TextAlign? textAlign;

  /// Line height.
  final double? height;

  /// Maximum number of lines. Note: Marquee only works if maxLines is 1.
  final int? maxLines;

  /// How to handle overflow when not scrolling.
  final TextOverflow? overflow;

  /// Letter spacing.
  final double? letterSpacing;

  /// Word spacing.
  final double? wordSpacing;

  /// Font style (normal/italic).
  final FontStyle? fontStyle;

  /// The marquee behavior mode (default: [MarqueeMode.auto]).
  final MarqueeMode marquee;

  /// Whether the text should break at soft line breaks.
  final bool? softWrap;

  /// Creates a [FlexiText] widget.
  const FlexiText(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.textAlign,
    this.height,
    this.maxLines,
    this.overflow,
    this.letterSpacing,
    this.wordSpacing,
    this.fontFamily,
    this.fontStyle,
    this.marquee = MarqueeMode.auto,
    this.softWrap,
  });

  @override
  State<FlexiText> createState() => _FlexiTextState();
}

class _FlexiTextState extends State<FlexiText> {
  final GlobalKey _textKey = GlobalKey();
  bool _isOverflowing = false;
  bool _hasChecked = false;

  @override
  void initState() {
    super.initState();
    if (widget.marquee != MarqueeMode.disable) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _checkOverflow());
    }
  }

  @override
  void didUpdateWidget(covariant FlexiText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.marquee != MarqueeMode.disable && 
        (oldWidget.text != widget.text || oldWidget.fontSize != widget.fontSize)) {
      _hasChecked = false;
      WidgetsBinding.instance.addPostFrameCallback((_) => _checkOverflow());
    }
  }

  void _checkOverflow() {
    if (_hasChecked || !mounted) return;

    _hasChecked = true;

    if (widget.marquee == MarqueeMode.always) {
      setState(() => _isOverflowing = true);
      return;
    }

    final context = _textKey.currentContext;
    final renderBox = context?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final textStyle = TextStyle(
      fontSize: widget.fontSize,
      fontWeight: widget.fontWeight,
      fontStyle: widget.fontStyle,
      height: widget.height,
      letterSpacing: widget.letterSpacing,
      wordSpacing: widget.wordSpacing,
      fontFamily: widget.fontFamily,
    );

    final textSpan = TextSpan(text: widget.text, style: textStyle);

    final textPainter = TextPainter(
      text: textSpan,
      maxLines: widget.maxLines ?? 1,
      textDirection: Directionality.of(context!),
      textAlign: widget.textAlign ?? TextAlign.start,
    )..layout(maxWidth: renderBox.size.width);

    final didOverflow = textPainter.didExceedMaxLines;

    if (mounted && didOverflow != _isOverflowing) {
      setState(() => _isOverflowing = didOverflow);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: widget.color ?? (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
      fontWeight: widget.fontWeight,
      fontSize: widget.fontSize,
      fontStyle: widget.fontStyle,
      height: widget.height,
      letterSpacing: widget.letterSpacing,
      wordSpacing: widget.wordSpacing,
      fontFamily: widget.fontFamily,
    );

    final shouldMarquee = (widget.maxLines ?? 1) == 1 &&
        _isOverflowing &&
        widget.marquee != MarqueeMode.disable;

    if (shouldMarquee) {
      return SizedBox(
        height: (widget.fontSize ?? 14) * (widget.height ?? 1.2) + 4,
        child: Marquee(
          text: widget.text,
          style: textStyle,
          scrollAxis: Axis.horizontal,
          blankSpace: 30.0,
          velocity: 40.0,
          startAfter: const Duration(seconds: 2),
          pauseAfterRound: const Duration(seconds: 1),
          accelerationDuration: const Duration(seconds: 1),
          accelerationCurve: Curves.linear,
          decelerationDuration: const Duration(milliseconds: 500),
          decelerationCurve: Curves.easeOut,
        ),
      );
    }

    return Text(
      widget.text,
      key: _textKey,
      textAlign: widget.textAlign,
      maxLines: widget.maxLines,
      overflow: widget.overflow ?? TextOverflow.ellipsis,
      softWrap: widget.softWrap,
      style: textStyle,
    );
  }
}
