import 'dart:async';
import 'package:flutter/material.dart';
import 'flexi_button.dart';

/// A premium timer widget with start, pause, resume, and stop functionality.
/// A premium timer widget with start, pause, resume, and stop functionality.
///
/// [FlexiTimer] provides a complete, styled timer interface that can be 
/// integrated into forms or standalone views. It supports custom styling 
/// for the display and control buttons.
class FlexiTimer extends StatefulWidget {
  /// The background color of the timer buttons.
  final Color? buttonColor;

  /// The text color of the timer buttons.
  final Color? buttonTextColor;

  /// The text style for the timer display.
  final TextStyle? timerStyle;

  /// Label for the start button (default: "Start").
  final String startLabel;

  /// Label for the pause button (default: "Pause").
  final String pauseLabel;

  /// Label for the resume button (default: "Resume").
  final String resumeLabel;

  /// Label for the stop button (default: "Stop").
  final String stopLabel;

  /// Internal padding around the timer content.
  final EdgeInsetsGeometry? padding;

  /// Outer margin around the timer container.
  final EdgeInsetsGeometry? margin;

  /// Corner radius for the timer container.
  final double? borderRadius;

  /// Creates a [FlexiTimer] with customizable labels and styles.
  const FlexiTimer({
    super.key,
    this.buttonColor,
    this.buttonTextColor,
    this.timerStyle,
    this.startLabel = "Start",
    this.pauseLabel = "Pause",
    this.resumeLabel = "Resume",
    this.stopLabel = "Stop",
    this.padding,
    this.margin,
    this.borderRadius,
  });

  @override
  State<FlexiTimer> createState() => _FlexiTimerState();
}

class _FlexiTimerState extends State<FlexiTimer> {
  Duration _counter = Duration.zero;
  Timer? _timer;
  bool _isRunning = false;
  bool _isPaused = false;

  void _startTimer() {
    _stopTimer();
    _counter = Duration.zero;
    _isPaused = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _counter += const Duration(seconds: 1);
        });
      }
    });
    setState(() {
      _isRunning = true;
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _isPaused = false;
      _counter = Duration.zero;
    });
  }

  void _pauseTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
      setState(() {
        _isRunning = false;
        _isPaused = true;
      });
    }
  }

  void _resumeTimer() {
    if (!_isRunning && _isPaused) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (mounted) {
          setState(() {
            _counter += const Duration(seconds: 1);
          });
        }
      });
      setState(() {
        _isRunning = true;
        _isPaused = false;
      });
    }
  }

  String formatDuration(Duration d) {
    final hours = d.inHours;
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final isDark = themeData.brightness == Brightness.dark;

    final effectiveBgColor = isDark
        // ignore: deprecated_member_use
        ? Colors.white.withOpacity(0.05)
        : Colors.white;
    final effectiveTextColor = isDark ? Colors.white : Colors.black;
    final radius = widget.borderRadius ?? 16.0;

    return Container(
      padding: widget.padding ?? const EdgeInsets.all(24),
      margin: widget.margin,
      decoration: BoxDecoration(
        color: effectiveBgColor,
        borderRadius: BorderRadius.circular(radius),
        border: isDark ? Border.all(color: Colors.white10) : null,
        boxShadow: isDark
            ? null
            : [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            formatDuration(_counter),
            style:
            widget.timerStyle ??
                TextStyle(
                  fontSize: 54,
                  fontWeight: FontWeight.w200, // Thinner for premium look
                  letterSpacing: 4,
                  color: effectiveTextColor,
                ),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              if (!_isRunning && !_isPaused)
                _buildButton(
                  widget.startLabel,
                  isDark ? Colors.white : Colors.black,
                  _startTimer,
                ),

              if (_isRunning)
                _buildButton(
                  widget.pauseLabel,
                  Colors.amber.shade700,
                  _pauseTimer,
                ),

              if (!_isRunning && _isPaused)
                _buildButton(
                  widget.resumeLabel,
                  isDark ? Colors.white : Colors.black,
                  _resumeTimer,
                ),

              if (_isRunning || _isPaused)
                _buildButton(widget.stopLabel, Colors.red[700]!, _stopTimer),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String label, Color color, VoidCallback onTap) {
    return FlexiButton(
      width: 110,
      height: 40,
      color: color,
      textColor: (color == Colors.white) ? Colors.black : Colors.white,
      onTap: onTap,
      borderRadius: 10,
      fontSize: 14,
      child: Text(label),
    );
  }
}
