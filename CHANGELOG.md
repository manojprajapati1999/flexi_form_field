## 3.0.4

- **Maintenance**: Synchronized version numbers across `pubspec.yaml` and `README.md`.
- **Version Bump**: Updated package version to `3.0.4`.

## 3.0.3

- **Documentation**: Updated README.md showcase section with new visuals/information.

## 3.0.2

🌍 **Platform Support & Modernization**

- **Multi-Platform Support**: Restored full compatibility for Android, iOS, Web, Windows, macOS, and Linux.
- **SDK Compatibility**: Lowered Dart SDK constraint to `^3.5.0` and gracefully handled `Color.withOpacity` depreciation for older Flutter versions.
- **Dependency Update**: Upgraded `flutter_typeahead` to `^6.0.0` and resolved all breaking changes in the autocomplete widget.
- **Static Analysis**: Achieved a clean bill of health with 0 warnings/errors in `dart analyze`.
- **Exhaustive Documentation**: Completed DartDoc coverage for all public widgets, properties, and builders to improve pub.dev scoring.

## 3.0.1

🛡️ **Maintenance & Quality Improvement**

- **Analyzer Cleanup**: Resolved all primary `dart analyze` warnings, including unused local variables in `FlexiTimer` and `FlexiTextFieldBuilder`.
- **Documentation Overhaul**: Added comprehensive documentation comments (`///`) to core public classes and methods (`FlexiDropdownBuilder`, `FlexiTimer`, etc.).
- **Improved Alignment**: Finalized the 48px standard spacing across all prefix and suffix icon zones for total visual consistency.

## 3.0.0

🚀 **Major Design Overhaul - Premium Monochrome System**

### ✨ Key Highlights:
- **Monochrome Aesthetic**: Completely redesigned all widgets with a high-contrast, professional "Black & White" design system.
- **The 12-Case Design Matrix**: Standardized all input components across 4 border styles (Outline, Rounded, Underline, Filled) and 3 label layouts (External, Internal Floating, Hint only).
- **Unified Icon Geometry**: Every widget now uses a standardized 48px square zone for both `prefixIcon` and `suffixIcon`, ensuring pixel-perfect alignment across different field types.
- **Enhanced Dropdown Experience**:
    - Implemented `selectedItemBuilder` for cleaner selection display.
    - Added high-contrast item separators (dividers) in the dropdown menu.
    - Standardized menu height and elevated UI.
- **Premium Example App**: 
    - Completely redesigned the showcase application.
    - Added a **Glassmorphism Form Demo** showing how the library handles modern, translucent UI designs.
- **SDK Compatibility**: Resolved deprecation warnings and improved reactivity using `ValueKey` patterns where appropriate for legacy support.

## 2.0.1
    update readme.md

## 2.0.0
## 09-01-2026

🚀 Major Release - Expanded Widget Suite & Standardization

New Widgets Added:
✔️ **FlexiButton**: Highly customizable button with gradient, shadow, and border support.
✔️ **FlexiDateTimePicker**: Combined date and time selection in a single flow.
✔️ **FlexiTimePicker**: Dedicated time selection with standard Material picker.
✔️ **FlexiTimer**: A functional timer with start, pause, resume, and stop controls.
✔️ **FlexiAutoComplete**: Searchable autocomplete field with generic type support (requires `flutter_typeahead`).
✔️ **FlexiStepper**: Horizontal animated stepper with auto-scrolling to the active step.
✔️ **FlexiTabBar**: Segmented tab control with customizable background and indicator styles.

Enhancements & Standardization:
✔️ Added `prefixIcon` support across all input widgets (`FlexiDatePicker`, `FlexiTimePicker`, `FlexiDateTimePicker`, `FlexiAutoComplete`).
✔️ Exported `FlexiFormTheme`, `FlexiFieldStyle`, and `FlexiFieldLayout` for better library access.
✔️ Redesigned the example application with a premium, categorized showcase of all widgets.
✔️ Improved documentation and added clear usage examples for all new components.
✔️ Handled keyboard visibility and focus management for a smoother UX in complex forms.

Dependencies:
➕ Added `flutter_typeahead: ^5.2.0`
➕ Added `flutter_keyboard_visibility: ^6.0.0` (for internal keyboard handling)

## 1.0.0

🎉 First stable version of FlexiFormField

Added highly customizable FlexiFormField widget

Built-in validation for:

✔️ Email

✔️ Mobile Number

✔️ GST Number

✔️ Pincode

✔️ Confirm Password

✔️ Minimum Password Length

✔️ Password Format (A-Z, a-z, number, special character)

Added support for input formatters:

✔️ Numbers only

✔️ Uppercase only

✔️ Decimal numbers

✔️ Percentage input

Added UI customizations:

✔️ Prefix/Suffix icons with click events

✔️ Custom borders

✔️ Custom label, styles, colors

✔️ Mandatory field indicator *

✔️ Read-only & disabled mode

Added focus navigation using currentFocusNode → nextFocusNode

Added callbacks:

✔️ onTap

✔️ onTapOutside

✔️ onChange

✔️ onSaved

✔️ onEditingComplete

Added cursor customization (color, height)

Added decoration overrides

Improved error handling with custom validation messages

Added support for maxLine, maxLength, obscure text & obscuring character
