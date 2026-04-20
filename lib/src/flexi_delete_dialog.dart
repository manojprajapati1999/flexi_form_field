import 'package:flutter/material.dart';
import 'theme.dart';

/// A premium, stylized delete confirmation dialog that follows the 
/// Flexi design system.
///
/// [FlexiDeleteDialog] provides a consistent, clean way to confirm 
/// destructive actions with a monochrome aesthetic.
class FlexiDeleteDialog extends StatelessWidget {
  /// The name of the item being deleted (e.g., "this record").
  final String itemName;

  /// Callback when the delete button is tapped.
  final VoidCallback onDelete;

  /// The title of the dialog (default: "Delete").
  final String title;

  /// The message template (default: "Do you want to delete this {itemName}?").
  final String? message;

  /// The text for the cancel button (default: "Cancel").
  final String cancelText;

  /// The text for the delete button (default: "Delete").
  final String deleteText;

  /// Optional theme override for this specific dialog.
  final FlexiFormTheme? theme;

  /// Creates a [FlexiDeleteDialog].
  const FlexiDeleteDialog({
    super.key,
    required this.itemName,
    required this.onDelete,
    this.title = "Delete",
    this.message,
    this.cancelText = "Cancel",
    this.deleteText = "Delete",
    this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final isDark = themeData.brightness == Brightness.dark;
    final appliedFlexiTheme = theme ?? const FlexiFormTheme();

    final errorColor = Colors.redAccent;

    return SimpleDialog(
      contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      shape: RoundedRectangleBorder(
        borderRadius: appliedFlexiTheme.borderRadius,
      ),
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      children: [
        Row(
          children: [
            Icon(
              Icons.delete_forever_rounded,
              color: errorColor,
              size: 28,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: isDark ? Colors.white : Colors.black,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            message ?? "Do you want to delete this $itemName?",
            style: TextStyle(
              fontSize: 16,
              color: isDark ? Colors.white70 : Colors.black54,
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: Text(
                cancelText,
                style: TextStyle(
                  color: isDark ? Colors.white60 : Colors.black45,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 8),
            TextButton(
              onPressed: onDelete,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                foregroundColor: errorColor,
              ),
              child: Text(
                deleteText,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Helper method to show the dialog.
  static Future<void> show(
    BuildContext context, {
    required String itemName,
    required VoidCallback onDelete,
    String title = "Delete",
    String? message,
    String cancelText = "Cancel",
    String deleteText = "Delete",
    FlexiFormTheme? theme,
  }) {
    return showDialog(
      context: context,
      builder: (context) => FlexiDeleteDialog(
        itemName: itemName,
        onDelete: onDelete,
        title: title,
        message: message,
        cancelText: cancelText,
        deleteText: deleteText,
        theme: theme,
      ),
    );
  }
}
