import 'package:flutter/material.dart';
import 'theme.dart';

/// A premium network image widget with built-in loading and error handling.
///
/// [FlexiNetworkImage] wraps standard [Image.network] and provides a 
/// stylized loading indicator and a fallback placeholder in case of errors.
class FlexiNetworkImage extends StatelessWidget {
  /// The URL of the image to display.
  final String imageUrl;

  /// The scale to use for the image.
  final double scale;

  /// Optional color for the loading indicator (defaults to theme primary).
  final Color? loaderColor;

  /// Outer margin for the container.
  final EdgeInsetsGeometry? margin;

  /// Inner padding for the container.
  final EdgeInsetsGeometry? padding;

  /// Height of the image container.
  final double? height;

  /// Width of the image container.
  final double? width;

  /// Border radius for the image.
  final BorderRadius? borderRadius;

  /// How the image should be inscribed into the box.
  final BoxFit fit;

  /// Optional theme override.
  final FlexiFormTheme? theme;

  /// Creates a [FlexiNetworkImage] widget.
  const FlexiNetworkImage({
    super.key,
    required this.imageUrl,
    this.scale = 1.0,
    this.loaderColor,
    this.margin,
    this.padding,
    this.height,
    this.width,
    this.borderRadius,
    this.fit = BoxFit.cover,
    this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final appliedFlexiTheme = theme ?? const FlexiFormTheme();
    final primaryColor = loaderColor ?? appliedFlexiTheme.primaryColor;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: margin,
      padding: padding,
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? appliedFlexiTheme.borderRadius,
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.network(
        imageUrl,
        scale: scale,
        fit: fit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return SizedBox(
            height: height ?? 150,
            width: width,
            child: Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                    : null,
                color: primaryColor,
                strokeWidth: 2.5,
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: height ?? 150,
            width: width ?? double.infinity,
            color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.grey.withValues(alpha: 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.broken_image_outlined,
                  color: isDark ? Colors.white38 : Colors.grey,
                  size: 32,
                ),
                const SizedBox(height: 8),
                Text(
                  "Failed to load image",
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.white24 : Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
