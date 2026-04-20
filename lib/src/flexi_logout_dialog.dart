import 'package:flutter/material.dart';
import 'theme.dart';

/// A premium, stylized logout confirmation dialog that follows the 
/// Flexi design system.
///
/// [FlexiLogoutDialog] provides a consistent, clean way to confirm 
/// account logout with a monochrome aesthetic.
class FlexiLogoutDialog extends StatelessWidget {
  /// Callback when the logout button is tapped.
  final VoidCallback onLogout;

  /// The title of the dialog (default: "Logout").
  final String title;

  /// The message to display (default: "Do you want to logout from this account?").
  final String message;

  /// The text for the cancel button (default: "Cancel").
  final String cancelText;

  /// The text for the logout button (default: "Logout").
  final String logoutText;

  /// Optional theme override for this specific dialog.
  final FlexiFormTheme? theme;

  /// Creates a [FlexiLogoutDialog].
  const FlexiLogoutDialog({
    super.key,
    required this.onLogout,
    this.title = "Logout",
    this.message = "Do you want to logout from this account?",
    this.cancelText = "Cancel",
    this.logoutText = "Logout",
    this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final isDark = themeData.brightness == Brightness.dark;
    final appliedFlexiTheme = theme ?? const FlexiFormTheme();
    final primaryColor = appliedFlexiTheme.primaryColor;

    return SimpleDialog(
      contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      titlePadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: appliedFlexiTheme.borderRadius,
        side: BorderSide(color: primaryColor.withValues(alpha: 0.1), width: 1.5),
      ),
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: primaryColor,
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
        ),
      ),
      children: [
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            message,
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
              onPressed: onLogout,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                foregroundColor: Colors.redAccent,
              ),
              child: Text(
                logoutText,
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
    required VoidCallback onLogout,
    String title = "Logout",
    String message = "Do you want to logout from this account?",
    String cancelText = "Cancel",
    String logoutText = "Logout",
    FlexiFormTheme? theme,
  }) {
    return showDialog(
      context: context,
      builder: (context) => FlexiLogoutDialog(
        onLogout: onLogout,
        title: title,
        message: message,
        cancelText: cancelText,
        logoutText: logoutText,
        theme: theme,
      ),
    );
  }
}
