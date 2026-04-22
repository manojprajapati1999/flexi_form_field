import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'theme.dart';

/// A premium, platform-aware loading indicator.
///
/// [FlexiScreenLoader] displays a [CupertinoActivityIndicator] on iOS 
/// and a [CircularProgressIndicator] on other platforms, ensuring a 
/// native and premium feel across devices.
class FlexiScreenLoader extends StatelessWidget {
  /// Optional color for the loader (defaults to theme primary).
  final Color? color;

  /// Optional size for the loader.
  final double? size;

  /// Optional stroke width for the circular indicator (Android).
  final double strokeWidth;

  /// Optional theme override.
  final FlexiFormTheme? theme;

  /// Creates a [FlexiScreenLoader] widget.
  const FlexiScreenLoader({
    super.key,
    this.color,
    this.size,
    this.strokeWidth = 3.0,
    this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final appliedFlexiTheme = theme ?? const FlexiFormTheme();
    final primaryColor = color ?? appliedFlexiTheme.primaryColor;

    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: defaultTargetPlatform == TargetPlatform.iOS
            ? CupertinoActivityIndicator(
                color: primaryColor,
                radius: (size ?? 20) / 2,
              )
            : CircularProgressIndicator(
                color: primaryColor,
                strokeWidth: strokeWidth,
              ),
      ),
    );
  }
}
