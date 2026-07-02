## 4.0.3

- **WASM Compatibility**: Resolved WASM/WebAssembly runtime compatibility issues by introducing conditional exports/imports (`stub` fallback architecture) for platform-specific dependencies like `dart:io` and `file_picker`.
- **Dependencies**: Expanded dependency constraints to allow the latest major versions of `animated_custom_dropdown` (`>=3.1.1 <5.0.0`) and `device_info_plus` (`>=12.4.0 <14.0.0`) to avoid pub.dev scoring penalties.
- **Direct Dependencies**: Added `web: ^1.0.0` as a direct dependency for modern, Wasm-compatible web APIs.
- **Static Analysis**: Resolved all unused imports and type conflicts to ensure 0 errors/warnings under strict analysis rules.

## 4.0.2

- **Breaking Change**: Increased minimum Dart SDK constraint to `^3.10.0` to support modern dependency requirements.
- **Dependencies**: Force-upgraded all core dependencies to their absolute latest versions (`device_info_plus: ^13.1.0`, `file_picker: ^11.0.2`, `image_picker: ^1.2.1`, `marquee: ^2.3.0`, `flutter_lints: ^6.0.0`).
- **Web & Multi-Platform**: Fully resolved `dart:io` incompatibilities across all library exports, ensuring 100% clean multi-platform support including Web.
- **Maintenance**: Refactored `FlexiFilePicker` to utilize the new static `FilePicker` API introduced in version 11.0.0.
- **Static Analysis**: Silenced deprecation warnings for `Radio` widgets in environments running Flutter 3.35+ while maintaining backward compatibility for current stable versions.
- **Optimized for Pub.dev**: Added topics and enhanced metadata for better discoverability and health scores.

## 4.0.1

- **Fix**: Resolved duplicate export warning for `src/flexi_tab_bar.dart` in the main entry point.
- **Maintenance**: Migrated all deprecated `.withOpacity()` calls to the modern `.withValues()` method for enhanced color precision and future-proofing.
- **Stability**: Standardized internal analysis to achieve 0 warnings and improved pub.dev health score.

## 4.0.0

🚀 **Massive Widget Expansion - Premium Productivity Suite**

### ✨ New Widgets Added:
- **FlexiMultiSelectDropdown**: Highly customizable multi-select dropdown with animated transitions, search capabilities, and interactive tag-based selection UI.
- **FlexiImageSlider**: Premium full-screen image carousel for viewing multiple images (Remote/Local) with smooth animations and integrated dots indicator.
- **FlexiText**: Intelligent text widget with marquee support. Automatically detects overflow and scrolls text in `auto` mode, or can be forced with `always` mode.
- **FlexiTabBar & FlexiTabView**: A modern, integrated tab navigation system with optional "Swipe to Change" functionality.
- **FlexiFilePicker**: Standardized file selection widget with built-in Android 13+ permission handling (SDK 33 support).
- **FlexiImagePicker**: Stylized camera/gallery selection dialog with premium monochrome aesthetics.
- **FlexiSwitch**: Animated, highly customizable toggle switch with integrated "On/Off" labels.
- **FlexiRadioButton**: Accessible and stylish radio buttons with interactive labels (clicking the text toggles the radio).
- **FlexiCheckBox**: Premium checkbox implementation with clean, high-contrast states.
- **FlexiScreenLoader**: Platform-aware loading indicators (Cupertino on iOS, Material on Android) that respect the library theme.
- **FlexiDeleteDialog**: A modern confirmation dialog specifically designed for delete actions.
- **FlexiLogoutDialog**: A specialized logout confirmation dialog with a branded, high-contrast header.

### 🛠️ Dependencies & Improvements:
- **New Dependencies**: Added `animated_custom_dropdown`, `carousel_slider`, `marquee`, and `flutter_switch`.
- **Permission Management**: Standardized Android permission logic using `permission_manager`.
- **Refined Example App**: Updated the showcase application with new sections for Media, Selection, and Advanced Dropdowns.
- **Theming**: All new widgets fully integrate with `FlexiFormTheme` for out-of-the-box monochrome consistency.

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
