import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../decorators.dart';
import '../enums.dart';
import '../theme.dart';

/// A builder class that constructs a themed date picker field for [FlexiDatePicker].
class FlexiDateBuilder {
  /// Builds a [TextFormField] optimized for date input with the specified [style] and [theme].
  static Widget build({
    required BuildContext context,
    required TextEditingController controller,
    String? label,
    required FlexiFieldStyle style,
    required FlexiFormTheme theme,

    // 🔹 Optional controls
    bool isMandatory = false,
    bool enabled = true,
    DateTime? firstDate,
    DateTime? lastDate,
    DateTime? initialDate,
    String dateFormat = 'dd-MM-yyyy',
    Function(DateTime? date, String formatted)? onSelect,
    String? Function(String?)? validator,
    bool showClearButton = true,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      enabled: enabled,

      decoration: InputDecoration(
        labelText: isMandatory && label != null ? '$label *' : label,

        border: FlexiDecorators.border(style, theme),
        focusedBorder: FlexiDecorators.border(style, theme),
        enabledBorder: FlexiDecorators.border(style, theme),
        disabledBorder: FlexiDecorators.border(style, theme),

        suffixIcon: controller.text.isEmpty || !showClearButton
            ? const Icon(Icons.calendar_month_outlined)
            : GestureDetector(
                onTap: () {
                  controller.clear();
                  onSelect?.call(null, '');
                },
                child: const Icon(Icons.cancel, size: 18),
              ),
      ),

      validator:
          validator ??
          (value) {
            if (isMandatory && (value == null || value.isEmpty)) {
              return 'Select $label';
            }
            return null;
          },

      onTap: !enabled
          ? null
          : () async {
              final date = await showDatePicker(
                context: context,
                firstDate: firstDate ?? DateTime(1900),
                lastDate: lastDate ?? DateTime(2100),
                initialDate: initialDate ?? DateTime.now(),
              );

              if (date != null) {
                final formatted = DateFormat(dateFormat).format(date);
                controller.text = formatted;
                onSelect?.call(date, formatted);
              }
            },
    );
  }
}
