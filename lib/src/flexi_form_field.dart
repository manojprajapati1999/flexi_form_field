import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A highly customizable and feature-rich wrapper around Flutter's
/// `TextFormField`, providing built-in validation, formatting, focus
/// navigation, input constraints, and UI enhancements.
///
/// This widget is designed for reusable form handling in apps where
/// fields like mobile number, email, password, GST number, percentage,
/// pincode, uppercase inputs, numeric inputs, and mandatory fields
/// are frequently used.
///
/// ### Features
///
/// - Mobile number validation (10 digits)
/// - Email validation
/// - GST number validation (15 characters, structured)
/// - Password confirmation
/// - Automatic uppercase conversion
/// - Number-only, decimal, percentage input formats
/// - Auto focus movement to next field
/// - Custom prefix/suffix icon handling
/// - Mandatory field indicator
/// - Flexible decoration styles
///
/// ### Example:
/// ```dart
/// TextFormFieldPackage(
///   label: "Email",
///   isEmail: true,
///   isMandatory: true,
/// )
/// ```
class FlexiFormField extends StatefulWidget {
  /// Hint text displayed inside the field.
  final String? hintText;

  /// Controller to manage the text input.
  final TextEditingController? controller;

  /// Padding inside the text field.
  final EdgeInsetsGeometry? contentPadding;

  /// External margin around the widget.
  final EdgeInsets? margin;

  /// Custom border radius for the input field.
  final BorderRadius? borderRadius;

  /// Custom validator function.
  final String? Function(String? value)? validator;

  /// Called when the field is tapped.
  final void Function()? onTap;

  /// Called when user taps outside the field.
  final void Function(PointerDownEvent event)? onTapOutSide;

  /// Called when the text changes.
  final void Function(String? value)? onChange;

  /// Called when the field is saved.
  final void Function(String? value)? onSaved;

  /// Called when editing is completed.
  final void Function()? onEditingComplete;

  /// Full decoration override for input.
  final InputDecoration? decoration;

  /// Custom widget used as label.
  final Widget? labelWidget;

  /// Label as text.
  final String? label;

  /// Initial value of the field.
  final String? initialValue;

  /// Whether the field is mandatory.
  final bool? isMandatory;

  /// Whether the field validates double values.
  final bool? isDouble;

  /// Whether the field validates GST number.
  final bool? isGSTNumber;

  /// Whether the field is read-only.
  final bool? readOnly;

  /// Whether the field validates mobile numbers.
  final bool? isMobileNumber;

  /// Whether the field validates email addresses.
  final bool? isEmail;

  /// Whether the field validates percentage values.
  final bool? isPercentage;

  /// Whether the field validates pin code.
  final bool? isPinCode;

  /// Whether only numbers are allowed.
  final bool? isNumberOnly;

  /// Converts input to uppercase.
  final bool? isUpperCase;

  /// Whether this field is for confirm-password.
  final bool? isConfirmPassword;

  /// Align label with hint text.
  final bool? alignLabelWithHint;

  /// Error message for mandatory field.
  final String? validationErrorMassage;

  /// Error message for invalid mobile number.
  final String? mobileNumberErrorMassage;

  /// Error message for invalid email.
  final String? emailErrorMassage;

  /// Password used for confirm-password validation.
  final String? passWord;

  /// Keyboard type override.
  final TextInputType? keyboardType;

  /// Input formatters for restricting input.
  final List<TextInputFormatter>? inputFormatters;

  /// Maximum allowed character count.
  final int? maxLength;

  /// Maximum number of lines in input.
  final int? maxLine;

  /// Minimum password length for validation.
  final int? minPasswordLength;

  /// Widget displayed at the end of the field.
  final Widget? suffixIcon;

  /// Widget displayed at the start of the field.
  final Widget? prefixIcon;

  /// Whether the text is obscured (password).
  final bool? obscureText;

  /// Enables auto validation mode.
  final bool? autoValidMode;

  /// Enables password format validation.
  final bool? checkPasswordFormat;

  /// Current focus node.
  final FocusNode? currentFocusNode;

  /// Next focus node to shift to on submit.
  final FocusNode? nextFocusNode;

  /// Character used to replace hidden text.
  final String? obscuringCharacter;

  /// Style for error message.
  final TextStyle? errorStyle;

  /// Style for main input text.
  final TextStyle? style;

  /// Style for label text.
  final TextStyle? labelStyle;

  /// Style for floating label.
  final TextStyle? floatingLabelStyle;

  /// Maximum lines allowed for error.
  final int? errorMaxLines;

  /// Color of focused border.
  final Color? focusedBorderColor;

  /// Background fill color.
  final Color? fillColor;

  /// Custom border style.
  final InputBorder? border;

  /// Border used when field is focused.
  final InputBorder? focusedBorder;

  /// Whether the field is enabled.
  final bool? enabled;

  /// Whether the field should be filled.
  final bool? filled;

  /// Height of blinking cursor.
  final double? cursorHeight;

  /// Alignment for floating label.
  final FloatingLabelAlignment? floatingLabelAlignment;

  /// Cursor color.
  final Color? cursorColor;

  /// Callback when suffix icon is pressed.
  final VoidCallback? onSuffixIconPressed;

  /// Callback when prefix icon is pressed.
  final VoidCallback? onPrefixIconPressed;

  /// Constructor with all configurable parameters.
  const FlexiFormField({
    super.key,
    this.hintText,
    this.controller,
    this.decoration,
    this.contentPadding,
    this.borderRadius,
    this.validator,
    this.label,
    this.isMandatory,
    this.isMobileNumber,
    this.validationErrorMassage,
    this.mobileNumberErrorMassage,
    this.emailErrorMassage,
    this.isEmail,
    this.keyboardType,
    this.inputFormatters,
    this.isPinCode,
    this.maxLength,
    this.onTap,
    this.initialValue,
    this.readOnly,
    this.onChange,
    this.isDouble,
    this.isNumberOnly,
    this.isUpperCase,
    this.isConfirmPassword,
    this.passWord,
    this.maxLine = 1,
    this.suffixIcon,
    this.prefixIcon,
    this.obscureText,
    this.margin,
    this.autoValidMode,
    this.currentFocusNode,
    this.nextFocusNode,
    this.onSaved,
    this.obscuringCharacter,
    this.minPasswordLength,
    this.checkPasswordFormat,
    this.errorStyle,
    this.errorMaxLines,
    this.focusedBorderColor,
    this.style,
    this.labelStyle,
    this.border,
    this.focusedBorder,
    this.enabled,
    this.fillColor,
    this.filled,
    this.onEditingComplete,
    this.cursorHeight,
    this.floatingLabelStyle,
    this.floatingLabelAlignment,
    this.onTapOutSide,
    this.isPercentage,
    this.labelWidget,
    this.isGSTNumber,
    this.alignLabelWithHint,
    this.cursorColor,
    this.onSuffixIconPressed,
    this.onPrefixIconPressed,
  });

  @override
  State<FlexiFormField> createState() => _FlexiFormFieldState();
}

/// State class handling input behavior, validation, and UI updates.
class _FlexiFormFieldState extends State<FlexiFormField> {
  @override
  Widget build(BuildContext context) {
    // Evaluating flags to avoid null checks repeatedly
    widget.isMandatory ?? false;
    widget.isMobileNumber ?? false;
    widget.isEmail ?? false;
    widget.isPinCode ?? false;

    return Container(
      alignment: Alignment.centerLeft,
      margin: widget.margin,

      /// Main TextFormField UI
      child: TextFormField(
        autocorrect: true,
        readOnly: widget.readOnly ?? false,
        initialValue: widget.initialValue,
        enabled: widget.enabled,
        obscureText: widget.obscureText ?? false,

        /// Intelligent keyboard selection based on field type
        keyboardType: widget.isDouble == true
            ? const TextInputType.numberWithOptions(decimal: true)
            : widget.isNumberOnly == true
            ? TextInputType.number
            : widget.isMobileNumber == true
            ? TextInputType.number
            : widget.isPinCode == true
            ? TextInputType.number
            : widget.isPercentage == true
            ? const TextInputType.numberWithOptions(decimal: true)
            : widget.isEmail == true
            ? TextInputType.emailAddress
            : widget.keyboardType ?? TextInputType.text,

        /// Built-in input formatters for advanced use cases
        inputFormatters: widget.isDouble == true
            ? <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
              ]
            : widget.isPercentage == true
            ? <TextInputFormatter>[
                FilteringTextInputFormatter.allow(
                  RegExp(r'^0*([1-9][0-9]?|100)?(\.\d{0,2})?$|^0*\.\d{0,2}$'),
                ),
              ]
            : widget.isMobileNumber == true
            ? <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ]
            : widget.isGSTNumber == true
            ? [
                TextInputFormatter.withFunction((oldValue, newValue) {
                  return newValue.copyWith(
                    text: newValue.text.toUpperCase(),
                    selection: newValue.selection,
                  );
                }),
                LengthLimitingTextInputFormatter(15),
              ]
            : widget.isPinCode == true
            ? <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(6),
              ]
            : widget.isNumberOnly == true
            ? <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(widget.maxLength),
              ]
            : widget.isUpperCase == true
            ? [
                TextInputFormatter.withFunction(
                  (oldValue, newValue) =>
                      newValue.copyWith(text: newValue.text.toUpperCase()),
                ),
              ]
            : widget.inputFormatters ?? [],

        /// Maximum length (disabled when number-only)
        maxLength: widget.isNumberOnly == true ? null : widget.maxLength,

        maxLines: widget.obscureText == true ? 1 : widget.maxLine,

        onTap: widget.onTap,
        onTapOutside: widget.onTapOutSide,
        onChanged: widget.onChange,
        onEditingComplete: widget.onEditingComplete,
        onSaved: widget.onSaved,

        obscuringCharacter: widget.obscuringCharacter ?? '*',

        controller: widget.controller,
        focusNode: widget.currentFocusNode,

        cursorColor: widget.cursorColor ?? Colors.black,
        cursorHeight: widget.cursorHeight,

        style:
            widget.style ??
            const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),

        /// Auto validation mode
        autovalidateMode: widget.autoValidMode == null
            ? AutovalidateMode.disabled
            : widget.autoValidMode == true
            ? AutovalidateMode.always
            : AutovalidateMode.disabled,

        /// Input decoration with advanced customization
        decoration: InputDecoration(
          alignLabelWithHint:
              widget.alignLabelWithHint ??
              (widget.prefixIcon != null ? false : true),
          errorStyle: widget.errorStyle,
          floatingLabelStyle: widget.floatingLabelStyle,
          floatingLabelAlignment: widget.floatingLabelAlignment,
          errorMaxLines: widget.errorMaxLines,

          /// Label builder
          label:
              widget.labelWidget ??
              (widget.label == null
                  ? null
                  : Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: widget.label,
                            style:
                                widget.labelStyle ??
                                const TextStyle(color: Colors.grey),
                          ),
                          if (widget.isMandatory == true)
                            const TextSpan(
                              text: ' *',
                              style: TextStyle(color: Colors.red),
                            ),
                        ],
                      ),
                    )),

          /// Background fill color
          filled: widget.filled ?? true,
          fillColor: widget.readOnly == true
              ? Colors.grey.withValues(alpha: 0.1)
              : widget.enabled == false
              ? Colors.black12
              : widget.fillColor ?? Colors.white38,

          labelStyle:
              widget.labelStyle ??
              const TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                overflow: TextOverflow.ellipsis,
              ),

          hintStyle:
              widget.labelStyle ??
              const TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),

          /// Border styles
          border:
              widget.border ??
              OutlineInputBorder(
                borderRadius:
                    widget.borderRadius ?? BorderRadius.circular(10.68),
                borderSide: BorderSide(
                  color: widget.focusedBorderColor ?? Colors.black87,
                  width: 1.5,
                ),
              ),

          focusedBorder:
              widget.focusedBorder ??
              OutlineInputBorder(
                borderRadius:
                    widget.borderRadius ?? BorderRadius.circular(10.68),
                borderSide: BorderSide(
                  color: widget.focusedBorderColor ?? Colors.black87,
                  width: 1.5,
                ),
              ),

          enabledBorder:
              widget.border ??
              OutlineInputBorder(
                borderRadius:
                    widget.borderRadius ?? BorderRadius.circular(10.68),
                borderSide: const BorderSide(
                  color: Color(0XFFD9D9D9),
                  width: 0.5,
                ),
              ),

          disabledBorder:
              widget.border ??
              OutlineInputBorder(
                borderRadius:
                    widget.borderRadius ?? BorderRadius.circular(10.68),
                borderSide: const BorderSide(
                  color: Color(0XFFD9D9D9),
                  width: 0.5,
                ),
              ),

          /// Hint with mandatory symbol
          hintText: widget.isMandatory == true && widget.hintText != null
              ? "${widget.hintText}*"
              : widget.hintText,

          contentPadding:
              widget.contentPadding ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

          /// Prefix icon with custom tap handler
          prefixIcon: widget.prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 12, right: 4),
                  child: GestureDetector(
                    onTap: widget.onPrefixIconPressed ?? () {},
                    child: widget.prefixIcon,
                  ),
                )
              : null,

          prefixIconConstraints: const BoxConstraints(
            minWidth: 24,
            maxHeight: 40,
            maxWidth: 70,
            minHeight: 24,
          ),

          /// Suffix icon with custom tap handler
          suffixIcon: widget.suffixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: widget.onSuffixIconPressed ?? () {},
                    child: widget.suffixIcon,
                  ),
                )
              : null,

          suffixIconConstraints: const BoxConstraints(
            minWidth: 24,
            maxHeight: 40,
            maxWidth: 70,
            minHeight: 24,
          ),

          isDense: true,
        ),

        /// Shift focus automatically to next field
        onFieldSubmitted: (value) {
          if (widget.currentFocusNode != null && widget.nextFocusNode != null) {
            widget.currentFocusNode!.unfocus();
            FocusScope.of(context).requestFocus(widget.nextFocusNode!);
          }
        },

        /// Built-in validation logic for multiple input types
        validator:
            widget.validator ??
            (value) {
              // GST Number validation
              if (value != null &&
                  value.isNotEmpty &&
                  widget.isGSTNumber == true) {
                final gstRegex = RegExp(
                  r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$',
                );
                if (!gstRegex.hasMatch(value)) {
                  return 'Enter a valid GST number!';
                }
              }

              // Mobile number validation
              if (value != null &&
                  value.isNotEmpty &&
                  widget.isMobileNumber == true) {
                if (!['6', '7', '8', '9'].contains(value[0])) {
                  return widget.mobileNumberErrorMassage ??
                      "Enter a valid mobile number!";
                }
              }

              if (value != null &&
                  value.isNotEmpty &&
                  widget.isMobileNumber == true) {
                String mobilePattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                RegExp regex = RegExp(mobilePattern);
                if (!regex.hasMatch(value)) {
                  return 'Enter a valid mobile number!';
                }
              }

              // Email validation
              if (value != null && value.isNotEmpty && widget.isEmail == true) {
                String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                RegExp regex = RegExp(emailPattern);
                if (!regex.hasMatch(value)) {
                  return 'Enter a valid email address!';
                }
              }

              // Pincode validation
              if (value != null &&
                  value.isNotEmpty &&
                  widget.isPinCode == true) {
                if (value.length < 6) {
                  return 'Enter a valid pincode!';
                }
              }

              // Confirm password validation
              if (value != null &&
                  value.isNotEmpty &&
                  widget.isConfirmPassword == true) {
                if (widget.passWord != value) {
                  return 'Password and confirm-password should same!';
                }
              }

              // Minimum password length
              if (value != null &&
                  value.isNotEmpty &&
                  widget.minPasswordLength != null) {
                if (value.length < widget.minPasswordLength!) {
                  return 'Enter ${widget.minPasswordLength} digit password!';
                }
              }

              // Password format validation
              if (value != null &&
                  value.isNotEmpty &&
                  widget.checkPasswordFormat == true) {
                String passwordPattern =
                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[!@#\$%^&*(),.?":{}|<>])';
                RegExp regex = RegExp(passwordPattern);
                if (!regex.hasMatch(value)) {
                  return "Enter at least 1 uppercase letter, 1 lowercase letter, 1 special character and 1 number!";
                }
              }

              // Mandatory field validation
              if (widget.isMandatory == true) {
                if (value == null || value.isEmpty) {
                  return widget.validationErrorMassage ??
                      'Enter ${widget.label ?? widget.hintText ?? ""}';
                }
              }

              return null;
            },
      ),
    );
  }
}
