
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'theme.dart';

/// A premium, highly customizable multi-select dropdown widget.
///
/// [FlexiMultiSelectDropdown] provides a modern, animated dropdown experience 
/// with tag-based selection headers and built-in search.
class FlexiMultiSelectDropdown extends StatefulWidget {
  /// The list of items to select from.
  final List<String> items;

  /// The list of currently selected items.
  final List<String> selectedItems;

  /// Callback when the selection changes.
  final Function(List<String> values) onChanged;

  /// The label displayed above the dropdown.
  final String? label;

  /// Hint text shown when no items are selected.
  final String hint;

  /// Whether the field is mandatory (shows '*' indicator).
  final bool isMandatory;

  /// Optional theme override for this specific field.
  final FlexiFormTheme? theme;

  /// Outer margin for the dropdown container.
  final EdgeInsetsGeometry? margin;

  /// Max height of the dropdown overlay.
  final double? overlayHeight;

  /// Creates a [FlexiMultiSelectDropdown] widget.
  const FlexiMultiSelectDropdown({
    super.key,
    required this.items,
    required this.selectedItems,
    required this.onChanged,
    required this.hint,
    this.label,
    this.isMandatory = false,
    this.theme,
    this.margin,
    this.overlayHeight,
  });

  @override
  State<FlexiMultiSelectDropdown> createState() => _FlexiMultiSelectDropdownState();
}

class _FlexiMultiSelectDropdownState extends State<FlexiMultiSelectDropdown> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final isDark = themeData.brightness == Brightness.dark;
    final appliedFlexiTheme = widget.theme ?? const FlexiFormTheme();
    final primaryColor = appliedFlexiTheme.primaryColor;

    return Container(
      margin: widget.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null) ...[
            Padding(
              padding: const EdgeInsets.only(left: 2, bottom: 8),
              child: Row(
                children: [
                  Text(
                    widget.label!,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white70 : Colors.black87,
                    ),
                  ),
                  if (widget.isMandatory) ...[
                    const Text(" *", style: TextStyle(color: Colors.red)),
                  ],
                ],
              ),
            ),
          ],
          CustomDropdown<String>.multiSelect(
            items: widget.items,
            initialItems: widget.selectedItems,
            onListChanged: (values) {
              widget.onChanged(values);
              setState(() {});
            },
            hintText: widget.hint,
            overlayHeight: widget.overlayHeight,
            headerListBuilder: (context, selectedItems, _) {
              if (selectedItems.isEmpty) {
                return Text(
                  widget.hint,
                  style: TextStyle(
                    color: isDark ? Colors.white38 : Colors.grey,
                    fontSize: 14,
                  ),
                );
              }
              return Wrap(
                spacing: 8,
                runSpacing: 4,
                children: selectedItems.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          item,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {
                            final newItems = List<String>.from(selectedItems)..removeAt(index);
                            widget.onChanged(newItems);
                            setState(() {});
                          },
                          child: const Icon(
                            Icons.close_rounded,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
            decoration: CustomDropdownDecoration(
              closedFillColor: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white,
              expandedFillColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
              closedBorder: Border.all(
                color: isDark ? Colors.white10 : Colors.grey.withValues(alpha: 0.3),
                width: 1.5,
              ),
              closedBorderRadius: appliedFlexiTheme.borderRadius,
              expandedBorderRadius: appliedFlexiTheme.borderRadius,
              hintStyle: TextStyle(
                color: isDark ? Colors.white38 : Colors.grey,
                fontSize: 14,
              ),
              listItemStyle: TextStyle(
                color: isDark ? Colors.white70 : Colors.black87,
                fontSize: 14,
              ),
              headerStyle: TextStyle(
                color: isDark ? Colors.white : Colors.black,
                fontSize: 14,
              ),
              searchFieldDecoration: SearchFieldDecoration(
                fillColor: isDark ? Colors.white.withValues(alpha: 0.03) : Colors.grey.withValues(alpha: 0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: primaryColor.withValues(alpha: 0.2)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: primaryColor),
                ),
                hintStyle: TextStyle(
                  color: isDark ? Colors.white38 : Colors.grey,
                  fontSize: 14,
                ),
              ),
              listItemDecoration: ListItemDecoration(
                selectedIconColor: primaryColor,
                selectedIconShape: const CircleBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
