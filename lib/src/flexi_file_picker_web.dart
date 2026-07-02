import 'dart:js_interop';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;
import 'file_picker_compat/file_picker_compat.dart';

/// Web/Wasm implementation of [FlexiFilePicker] using package:web.
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
        final web.HTMLInputElement uploadInput = web.document.createElement('input') as web.HTMLInputElement;
        uploadInput.type = 'file';
        uploadInput.multiple = allowMultiple;

        if (type == FileType.custom && allowedExtensions != null) {
          uploadInput.accept = allowedExtensions!.map((ext) => '.$ext').join(',');
        } else if (type == FileType.image) {
          uploadInput.accept = 'image/*';
        } else if (type == FileType.video) {
          uploadInput.accept = 'video/*';
        } else if (type == FileType.audio) {
          uploadInput.accept = 'audio/*';
        }

        uploadInput.onChange.listen((web.Event event) {
          final filesList = uploadInput.files;
          if (filesList != null && filesList.length > 0) {
            final List<PlatformFile> platformFiles = [];
            int loadedCount = 0;
            final int totalFiles = filesList.length;

            for (int i = 0; i < totalFiles; i++) {
              final web.File? file = filesList.item(i);
              if (file == null) continue;

              final web.FileReader reader = web.FileReader();
              reader.readAsArrayBuffer(file);
              reader.onLoadEnd.listen((web.Event e) {
                Uint8List? bytes;
                try {
                  final result = reader.result;
                  if (result != null) {
                    final arrayBuffer = result as JSArrayBuffer;
                    bytes = arrayBuffer.toDart.asUint8List();
                  }
                } catch (err) {
                  debugPrint("Error reading file bytes: $err");
                }

                platformFiles.add(PlatformFile(
                  name: file.name,
                  size: file.size,
                  bytes: bytes,
                  path: null,
                ));

                loadedCount++;
                if (loadedCount == totalFiles) {
                  onSelect(FilePickerResult(platformFiles));
                }
              });
            }
          } else {
            onSelect(null);
          }
        });

        uploadInput.click();
      },
      child: child,
    );
  }
}
