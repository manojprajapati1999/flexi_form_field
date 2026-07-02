import 'package:flutter/material.dart';
import 'file_picker_compat/file_picker_compat.dart';

/// Stub implementation of [FlexiFilePicker] that throws [UnsupportedError] on tap.
class FlexiFilePicker extends StatelessWidget {
  /// Callback when a file or multiple files are selected.
  final Function(FilePickerResult? result) onSelect;

  /// The widget that triggers the file picker when tapped.
  final Widget child;

  /// Optional list of allowed file extensions (e.g., ['pdf', 'png']).
  final List<String>? allowedExtensions;

  /// Whether to allow multiple file selection (default: false).
  final bool allowMultiple;

  /// The type of files to pick (default: [FileType.custom] if [allowedExtensions] is provided).
  final FileType type;

  /// Creates a [FlexiFilePicker] widget.
  const FlexiFilePicker({
    super.key,
    required this.onSelect,
    required this.child,
    this.allowedExtensions = const ["pdf", "jpeg", "jpg", "png"],
    this.allowMultiple = false,
    this.type = FileType.custom,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        throw UnsupportedError('File picker is not supported on this platform.');
      },
      child: child,
    );
  }
}
