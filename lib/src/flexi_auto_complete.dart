import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'decorators.dart';
import 'enums.dart';
import 'theme.dart';

class FlexiAutoComplete<T> extends StatefulWidget {
  final List<T> options;
  final String Function(T e) itemLabelBuilder;
  final TextEditingController controller;
  final T? value;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final String? errorText;
  final bool? autoValidate;
  final Widget? labelWidget;
  final String? externalLabel;
  final String? label;
  final String? hint;
  final bool? isMandatory;
  final bool? enabled;
  final bool? showClearButton;
  final bool? isDouble;
  final bool? numberOnly;
  final bool? isMobileNumber;
  final Function(T? e, String text)? onChanged;
  final Function(T? value)? onSelected;
  final EdgeInsetsGeometry? margin;
  final EdgeInsets? contentPadding;
  final double? height;
  final bool? filled;
  final Color? fillColor;
  final double? cursorHeight;
  final FloatingLabelAlignment? floatingLabelAlignment;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? floatingLabelStyle;
  final bool? hideEmptyListBanner;
  final InputBorder? border;
  final InputBorder? focusBorder;
  final Color? suffixIconColor;
  final Color? cursorColor;
  final double? fontSize;
  final double? borderRadius;
  final Widget? prefixIcon;
  final FlexiFieldStyle fieldStyle;

  /// Optional theme override for this specific field.
  final FlexiFormTheme? theme;

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
            hideWithKeyboard: true,
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
