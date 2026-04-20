
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'theme.dart';

/// A premium, highly customizable switch widget.
///
/// [FlexiSwitch] provides a modern, animated toggle experience with 
/// built-in support for "On/Off" labels and theme-aware styling.
class FlexiSwitch extends StatefulWidget {
  /// The current value of the switch.
  final bool value;

  /// Callback when the switch is toggled.
  final ValueChanged<bool>? onToggle;

  /// The height of the switch (default: 28).
  final double height;

  /// The width of the switch (default: 60).
  final double width;

  /// Whether to show "On/Off" text (default: true).
  final bool showOnOff;

  /// Text shown when active (default: "On").
  final String activeText;

  /// Text shown when inactive (default: "Off").
  final String inactiveText;

  /// Optional theme override for this specific widget.
  final FlexiFormTheme? theme;

  /// Creates a [FlexiSwitch] widget.
  const FlexiSwitch({
    super.key,
    required this.value,
    this.onToggle,
    this.height = 28.0,
    this.width = 60.0,
    this.showOnOff = true,
    this.activeText = "On",
    this.inactiveText = "Off",
    this.theme,
  });

  @override
  State<FlexiSwitch> createState() => _FlexiSwitchState();
}

class _FlexiSwitchState extends State<FlexiSwitch> {
  @override
  Widget build(BuildContext context) {
    final appliedFlexiTheme = widget.theme ?? const FlexiFormTheme();
    final primaryColor = appliedFlexiTheme.primaryColor;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return FlutterSwitch(
      width: widget.width,
      height: widget.height,
      valueFontSize: 12.0,
      toggleSize: 20.0,
      value: widget.value,
      borderRadius: 20.0,
      padding: 4.0,
      showOnOff: widget.showOnOff,
      activeText: widget.activeText,
      inactiveText: widget.inactiveText,
      activeColor: primaryColor,
      activeToggleColor: Colors.white,
      activeIcon: Icon(Icons.check, color: primaryColor, size: 14),
      inactiveColor: isDark ? Colors.white10 : Colors.grey.shade200,
      inactiveTextColor: isDark ? Colors.white38 : Colors.grey,
      inactiveToggleColor: Colors.grey.shade400,
      inactiveSwitchBorder: Border.all(
        color: isDark ? Colors.white12 : Colors.grey.shade300,
        width: 1,
      ),
      onToggle: (value) {
        if (widget.onToggle != null) {
          widget.onToggle!(value);
        }
      },
    );
  }
}
