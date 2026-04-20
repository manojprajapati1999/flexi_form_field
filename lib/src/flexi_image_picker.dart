
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'theme.dart';

/// A premium image picker widget that provides a stylized choice between 
/// camera and gallery.
///
/// [FlexiImagePicker] wraps a child widget and opens a modern, monochrome 
/// dialog to select an image source when tapped.
class FlexiImagePicker extends StatefulWidget {
  /// Callback when an image is selected.
  final Function(XFile? image) onSelect;

  /// The widget that triggers the image picker when tapped.
  final Widget child;

  /// The title of the selection dialog (default: "Choose Image").
  final String title;

  /// Label for the camera option (default: "Camera").
  final String cameraLabel;

  /// Label for the gallery option (default: "Gallery").
  final String galleryLabel;

  /// Optional theme override for this specific widget.
  final FlexiFormTheme? theme;

  /// Creates a [FlexiImagePicker] widget.
  const FlexiImagePicker({
    super.key,
    required this.onSelect,
    required this.child,
    this.title = "Choose Image",
    this.cameraLabel = "Camera",
    this.galleryLabel = "Gallery",
    this.theme,
  });

  @override
  State<FlexiImagePicker> createState() => _FlexiImagePickerState();
}

class _FlexiImagePickerState extends State<FlexiImagePicker> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    Navigator.pop(context);
    try {
      final XFile? image = await _picker.pickImage(source: source);
      widget.onSelect(image);
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final isDark = themeData.brightness == Brightness.dark;
    final appliedFlexiTheme = widget.theme ?? const FlexiFormTheme();
    final primaryColor = appliedFlexiTheme.primaryColor;

    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => SimpleDialog(
            clipBehavior: Clip.hardEdge,
            contentPadding: const EdgeInsets.all(16),
            titlePadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: appliedFlexiTheme.borderRadius,
              side: BorderSide(color: primaryColor.withValues(alpha: 0.1), width: 1.5),
            ),
            title: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: primaryColor,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close_rounded, size: 24, color: Colors.white),
                  ),
                ],
              ),
            ),
            children: [
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _buildOption(
                      icon: Icons.camera_alt_rounded,
                      label: widget.cameraLabel,
                      onTap: () => _pickImage(ImageSource.camera),
                      primaryColor: primaryColor,
                      isDark: isDark,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildOption(
                      icon: Icons.image_rounded,
                      label: widget.galleryLabel,
                      onTap: () => _pickImage(ImageSource.gallery),
                      primaryColor: primaryColor,
                      isDark: isDark,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      child: widget.child,
    );
  }

  Widget _buildOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required Color primaryColor,
    required bool isDark,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05),
            width: 1.5,
          ),
          color: isDark ? Colors.white.withValues(alpha: 0.03) : Colors.grey.withValues(alpha: 0.02),
        ),
        child: Column(
          children: [
            Icon(icon, color: primaryColor, size: 32),
            const SizedBox(height: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
