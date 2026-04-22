
import 'package:flutter/foundation.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_manager/permission_manager.dart';

/// A premium file picker widget that handles permissions automatically.
///
/// [FlexiFilePicker] wraps a child widget (typically a button or card) 
/// and triggers a file selection dialog after ensuring necessary 
/// permissions are granted using the [PermissionManager].
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
      onTap: () async {
        bool hasPermission = false;

        if (defaultTargetPlatform == TargetPlatform.android) {
          final deviceInfo = await DeviceInfoPlugin().androidInfo;

          if (deviceInfo.version.sdkInt > 32) {
            // Android 13+ requires specific media permissions
            final status = await PermissionManager.request(PermissionManagerPermission.mediaImages);
            hasPermission = status == PermissionManagerStatus.granted;
          } else {
            // Below Android 13 requires storage permission
            final status = await PermissionManager.request(PermissionManagerPermission.storage);
            hasPermission = status == PermissionManagerStatus.granted;
          }

          if (!hasPermission) {
            // Check if permanently denied
            final currentStatus = await (deviceInfo.version.sdkInt > 32 
                ? PermissionManager.check(PermissionManagerPermission.mediaImages)
                : PermissionManager.check(PermissionManagerPermission.storage));
            
            if (currentStatus == PermissionManagerStatus.permanentlyDenied) {
               if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Please allow storage permission in settings"),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                await PermissionManager.openAppSettings();
              }
            }
          }
        } else {
          // iOS and others usually handle permissions via the OS dialog during picking
          hasPermission = true;
        }

        if (hasPermission) {
          try {
            final result = await FilePicker.pickFiles(
              allowMultiple: allowMultiple,
              allowedExtensions: type == FileType.custom ? allowedExtensions : null,
              type: type,
            );
            onSelect(result);
          } catch (e) {
            debugPrint("Error picking files: $e");
          }
        }
      },
      child: child,
    );
  }
}
