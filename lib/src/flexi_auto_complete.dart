import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'decorators.dart';
import 'enums.dart';
import 'theme.dart';

/// A premium autocomplete input widget that provides suggestions as the user types.
///
/// [FlexiAutoComplete] integrates with a suggestion engine to provide a smooth
/// selection experience. It supports custom item builders, filtering logic, 
/// and rich styling to match the Flexi design system.
class FlexiAutoComplete<T> extends StatefulWidget {
  /// The list of options to suggest to the user.
  final List<T> options;

  /// A function that converts an option into a human-readable string.
  final String Function(T e) itemLabelBuilder;

  /// Controller for the text being edited.
  final TextEditingController controller;

  /// The currently selected value.
  final T? value;

  /// Optional focus node for the input field.
  final FocusNode? focusNode;

  /// Focus node to request after an item is selected.
  final FocusNode? nextFocusNode;

  /// Custom error text to display when validation fails.
  final String? errorText;

  /// Whether to validate the input automatically.
  final bool? autoValidate;

  /// Custom widget to use as the label.
  final Widget? labelWidget;

  /// A label displayed outside (above) the input field.
  final String? externalLabel;

  /// The label displayed inside the input border (Material style).
  final String? label;

  /// Hint text shown when the input is empty.
  final String? hint;

  /// Whether this field is marked as mandatory (shows '*' indicator).
  final bool? isMandatory;

  /// Whether the field is interactive.
  final bool? enabled;

  /// Whether to show a clear button when text is present.
  final bool? showClearButton;

  /// Restricts input to decimal/double values.
  final bool? isDouble;

  /// Restricts input to numeric characters.
  final bool? numberOnly;

  /// Pre-configured validation and formatting for mobile numbers.
  final bool? isMobileNumber;

  /// Callback when the text changes or an item is selected.
  final Function(T? e, String text)? onChanged;

  /// Callback specifically for when an item is selected from the list.
  final Function(T? value)? onSelected;

  /// Outer margin for the form field container.
  final EdgeInsetsGeometry? margin;

  /// Internal padding for the input field.
  final EdgeInsets? contentPadding;

  /// Height override for the input field.
  final double? height;

  /// Whether the input field background is filled.
  final bool? filled;

  /// Background fill color override.
  final Color? fillColor;

  /// Height of the cursor.
  final double? cursorHeight;

  /// Alignment logic for the floating label.
  final FloatingLabelAlignment? floatingLabelAlignment;

  /// Full text style override for the input text.
  final TextStyle? style;

  /// Style override for the label text.
  final TextStyle? labelStyle;

  /// Style override for the hint text.
  final TextStyle? hintStyle;

  /// Style override for the floating label.
  final TextStyle? floatingLabelStyle;

  /// Whether to hide the suggestion list when no matches are found.
  final bool? hideEmptyListBanner;

  /// Border style override.
  final InputBorder? border;

  /// Border style override when focused.
  final InputBorder? focusBorder;

  /// Color of the suffix icon.
  final Color? suffixIconColor;

  /// Color of the cursor.
  final Color? cursorColor;

  /// Font size override for the input text.
  final double? fontSize;

  /// Border radius override for the input field.
  final double? borderRadius;

  /// Widget shown at the beginning of the input field.
  final Widget? prefixIcon;

  /// The visual style of the input border (e.g., outline, filled, rounded).
  final FlexiFieldStyle fieldStyle;

  /// Optional theme override for this specific field.
  final FlexiFormTheme? theme;

  /// Creates a [FlexiAutoComplete] widget for rich selection-from-list experiences.
  const FlexiAutoComplete({
    super.key,
    required this.controller,
    required this.options,
    required this.itemLabelBuilder,
    this.onSelected,
    this.onChanged,
    this.focusNode,
    this.isDouble,
    this.numberOnly,
    this.isMobileNumber,
    this.value,
    this.nextFocusNode,
    this.errorText,
    this.autoValidate,
    this.isMandatory,
    this.enabled,
    this.externalLabel,
    this.label,
    this.margin,
    this.contentPadding,
    this.height,
    this.filled,
    this.fillColor,
    this.cursorHeight,
    this.floatingLabelAlignment,
    this.style,
    this.labelStyle,
    this.floatingLabelStyle,
    this.hideEmptyListBanner,
    this.showClearButton,
    this.border,
    this.focusBorder,
    this.hint,
    this.hintStyle,
    this.suffixIconColor,
    this.cursorColor,
    this.labelWidget,
    this.fontSize,
    this.borderRadius,
    this.prefixIcon,
    this.theme,
    this.fieldStyle = FlexiFieldStyle.outline,
  });

  @override
  State<FlexiAutoComplete<T>> createState() => _FlexiAutoCompleteState<T>();
}

class _FlexiAutoCompleteState<T> extends State<FlexiAutoComplete<T>> {
  final SuggestionsController<T> _suggestionsController =
      SuggestionsController();
  late final FocusNode _internalFocusNode;

  FocusNode get _effectiveFocusNode => widget.focusNode ?? _internalFocusNode;

  @override
  void initState() {
    super.initState();
    if (widget.focusNode == null) {
      _internalFocusNode = FocusNode();
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final isDark = themeData.brightness == Brightness.dark;
    final appliedFlexiTheme = widget.theme ?? const FlexiFormTheme();

    // Derived styles
    final effectiveLabelStyle =
        widget.labelStyle ?? appliedFlexiTheme.labelStyle;
    final effectivePrimaryColor =
        widget.cursorColor ?? appliedFlexiTheme.primaryColor;

    return Container(
      margin: widget.margin,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // External Label
          if (widget.externalLabel != null) ...[
            Padding(
              padding: const EdgeInsets.only(left: 2, bottom: 5),
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      widget.externalLabel!,
                      style: TextStyle(
                        color: themeData.textTheme.bodyLarge?.color,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  if (widget.isMandatory == true) ...[
                    const Text(
                      " *",
                      style: TextStyle(
                        color: Colors.red,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                  ],
                ],
              ),
            ),
          ],

          TypeAheadField<T>(
            hideOnEmpty: widget.hideEmptyListBanner ?? false,
            hideOnError: true,
            hideOnLoading: true,
            focusNode: _effectiveFocusNode,
            hideKeyboardOnDrag: true,
            controller: widget.controller,
            showOnFocus: widget.options.isNotEmpty,
            hideOnUnfocus: true,
            autoFlipMinHeight: 100,
            autoFlipDirection: true,
            animationDuration: const Duration(milliseconds: 500),
            hideOnSelect: true,
            suggestionsController: _suggestionsController,
            builder: (context, currentController, focusNode) {
              return TextFormField(
                onTap: () {
                  _suggestionsController.refresh();
                },
                onTapAlwaysCalled: true,
                controller: currentController,
                focusNode: focusNode,
                keyboardType: widget.isDouble == true
                    ? const TextInputType.numberWithOptions(decimal: true)
                    : widget.numberOnly == true
                    ? TextInputType.number
                    : widget.isMobileNumber == true
                    ? TextInputType.number
                    : TextInputType.text,
                inputFormatters: widget.isDouble == true
                    ? <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*$'),
                        ),
                      ]
                    : widget.isMobileNumber == true
                    ? <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ]
                    : widget.numberOnly == true
                    ? <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ]
                    : null,
                enabled: widget.enabled == false ? false : true,
                style:
                    widget.style ??
                    effectiveLabelStyle.copyWith(
                      fontSize: widget.fontSize ?? 16,
                      color: themeData.textTheme.bodyLarge?.color,
                      overflow: TextOverflow.ellipsis,
                    ),
                cursorHeight: widget.cursorHeight,
                cursorColor: effectivePrimaryColor,
                readOnly: widget.enabled == false || widget.options.isEmpty,
                autovalidateMode: widget.autoValidate == true
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                decoration: InputDecoration(
                  isDense: true,
                  prefixIcon: widget.prefixIcon,
                  prefixIconConstraints: const BoxConstraints(
                    minHeight: 24,
                    minWidth: 48,
                    maxHeight: 48,
                    maxWidth: 60,
                  ),
                  floatingLabelAlignment: widget.floatingLabelAlignment,

                  fillColor:
                      widget.fillColor ??
                      appliedFlexiTheme.fillColor ??
                      (widget.options.isEmpty
                          ? (isDark ? Colors.white10 : Colors.black12)
                          : (isDark
                                // ignore: deprecated_member_use
                                ? Colors.white.withValues(alpha: 0.05)
                                : themeData.colorScheme.surface)),

                  filled:
                      widget.filled ??
                      (widget.fillColor != null ||
                          appliedFlexiTheme.fillColor != null ||
                          isDark ||
                          widget.fieldStyle == FlexiFieldStyle.filled),

                  floatingLabelStyle: widget.floatingLabelStyle,

                  contentPadding:
                      widget.contentPadding ??
                      EdgeInsets.symmetric(
                        horizontal:
                            widget.fieldStyle == FlexiFieldStyle.underline
                            ? 0
                            : 16,
                        vertical: widget.fieldStyle == FlexiFieldStyle.underline
                            ? 5
                            : 10,
                      ),

                  border: FlexiDecorators.border(
                    widget.fieldStyle,
                    appliedFlexiTheme,
                    color: widget.cursorColor,
                    borderRadius: widget.borderRadius,
                  ),
                  focusedBorder: FlexiDecorators.focusedBorder(
                    widget.fieldStyle,
                    appliedFlexiTheme,
                    color: widget.cursorColor,
                    borderRadius: widget.borderRadius,
                  ),
                  enabledBorder: FlexiDecorators.enabledBorder(
                    widget.fieldStyle,
                    appliedFlexiTheme,
                    color: themeData.dividerColor,
                    borderRadius: widget.borderRadius,
                  ),
                  disabledBorder: FlexiDecorators.disabledBorder(
                    widget.fieldStyle,
                    appliedFlexiTheme,
                    color: themeData.disabledColor,
                    borderRadius: widget.borderRadius,
                  ),
                  errorBorder: FlexiDecorators.errorBorder(
                    widget.fieldStyle,
                    appliedFlexiTheme,
                    color: themeData.colorScheme.error,
                    borderRadius: widget.borderRadius,
                  ),
                  focusedErrorBorder: FlexiDecorators.errorBorder(
                    widget.fieldStyle,
                    appliedFlexiTheme,
                    color: themeData.colorScheme.error,
                    borderRadius: widget.borderRadius,
                  ),

                  label: widget.label == null
                      ? null
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Text(
                                widget.label!,
                                style: TextStyle(
                                  color: themeData.hintColor,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: widget.fontSize,
                                ),
                                maxLines: 1,
                              ),
                            ),
                            if (widget.isMandatory == true) ...[
                              Text(
                                " *",
                                style: TextStyle(
                                  color: Colors.red,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: widget.fontSize,
                                ),
                                maxLines: 1,
                              ),
                            ],
                          ],
                        ),

                  hintText: widget.hint,
                  hintStyle:
                      widget.hintStyle ??
                      TextStyle(
                        fontSize: 16,
                        color: themeData.hintColor,
                        overflow: TextOverflow.ellipsis,
                      ),

                  suffixIconConstraints: const BoxConstraints(
                    minHeight: 20,
                    minWidth: 40,
                    maxHeight: 30,
                    maxWidth: 40,
                  ),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (widget.controller.text.isEmpty &&
                          widget.options.isNotEmpty)
                        GestureDetector(
                          onTap: () {
                            if (focusNode.hasFocus) {
                              FocusScope.of(context).unfocus();
                            } else {
                              FocusScope.of(context).requestFocus(focusNode);
                            }
                          },
                          child: Icon(
                            focusNode.hasFocus
                                ? Icons.keyboard_arrow_up_rounded
                                : Icons.keyboard_arrow_down_rounded,
                            color: isDark ? Colors.white70 : Colors.black54,
                            size: 25,
                          ),
                        ),
                      if (widget.controller.text.isNotEmpty &&
                          widget.options.isNotEmpty &&
                          widget.showClearButton != false)
                        GestureDetector(
                          onTap: () {
                            widget.controller.text = "";
                            widget.onChanged?.call(null, "");
                          },
                          child: Icon(
                            Icons.cancel,
                            color: isDark ? Colors.white70 : Colors.black54,
                            size: 20,
                          ),
                        ),
                    ],
                  ),
                ),
                onSaved: (newValue) {
                  if (widget.nextFocusNode != null) {
                    FocusScope.of(context).requestFocus(widget.nextFocusNode);
                  } else {
                    FocusScope.of(context).unfocus();
                  }
                },
                onChanged: (text) {
                  T? result;
                  try {
                    result = widget.options.firstWhere(
                      (element) =>
                          widget
                              .itemLabelBuilder(element)
                              .trim()
                              .toLowerCase() ==
                          text.trim().toLowerCase(),
                    );
                  } catch (e) {
                    result = null;
                  }
                  widget.onChanged?.call(result, text);
                  if (result != null) {
                    if (widget.nextFocusNode != null) {
                      FocusScope.of(context).requestFocus(widget.nextFocusNode);
                    } else {
                      _effectiveFocusNode.unfocus();
                    }
                  }
                },
                validator: (value) {
                  if (widget.isMandatory == true &&
                      (value == null || value.toString().isEmpty)) {
                    return widget.errorText ??
                        "Select ${widget.externalLabel ?? widget.label ?? widget.hint ?? ""}"
                            .replaceAll("*", "");
                  } else if (value != null && value.toString().isNotEmpty) {
                    bool isValid = widget.options.any(
                      (element) =>
                          widget
                              .itemLabelBuilder(element)
                              .trim()
                              .toLowerCase() ==
                          value.trim().toLowerCase(),
                    );
                    if (!isValid) {
                      return widget.errorText ??
                          "Select ${widget.externalLabel ?? widget.label ?? widget.hint ?? ""}"
                              .replaceAll("*", "");
                    }
                  }
                  return null;
                },
              );
            },
            suggestionsCallback: (pattern) {
              return widget.options.where((element) {
                return widget
                    .itemLabelBuilder(element)
                    .toLowerCase()
                    .contains(pattern.toLowerCase());
              }).toList();
            },
            decorationBuilder: (context, child) {
              return Card(
                color: isDark ? themeData.colorScheme.surface : Colors.white,
                elevation: 4,
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    widget.borderRadius ??
                        appliedFlexiTheme.borderRadius.topLeft.x,
                  ),
                  side: isDark
                      ? BorderSide(color: themeData.dividerColor)
                      : BorderSide.none,
                ),
                child: child,
              );
            },
            itemSeparatorBuilder: (context, index) {
              return Divider(
                color: themeData.dividerColor,
                height: 0.5,
                thickness: 0.5,
              );
            },
            itemBuilder: (context, suggestion) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                child: Text(
                  widget.itemLabelBuilder(suggestion),
                  style: TextStyle(
                    fontSize: 16,
                    color: themeData.textTheme.bodyMedium?.color,
                  ),
                ),
              );
            },
            onSelected: (suggestion) {
              widget.controller.text = widget.itemLabelBuilder(suggestion);
              widget.onSelected?.call(suggestion);
              if (widget.nextFocusNode != null) {
                FocusScope.of(context).requestFocus(widget.nextFocusNode);
              } else {
                _effectiveFocusNode.unfocus();
              }
            },
            emptyBuilder: (context) {
              return Container(
                padding: const EdgeInsets.only(left: 15, top: 18, bottom: 18),
                width: double.infinity,
                child: Text(
                  "No Data Found!",
                  style: TextStyle(fontSize: 14, color: themeData.hintColor),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _suggestionsController.dispose();
    if (widget.focusNode == null) {
      _internalFocusNode.dispose();
    }
    super.dispose();
  }
}
