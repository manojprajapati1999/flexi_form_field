# flexi_form_field (v3.0.3)

A flexible and highly customizable Flutter form widget suite with built-in validation, rich styling options, and a consistent theming system. Drop-in replacements for common Flutter form UI with minimal boilerplate.

## 🖼 Showcase

<table>
  <tr>
    <th>Form Demo</th>
    <th>Text Fields</th>
    <th>Auto-Complete</th>
    <th>Date Pickers</th>
    <th>Components</th>
  </tr>
  <tr>
    <td><img src="https://raw.githubusercontent.com/manojprajapati1999/flexi_form_field/main/assets/images/form_demo.jpg" width="180"/></td>
    <td><img src="https://raw.githubusercontent.com/manojprajapati1999/flexi_form_field/main/assets/images/text_field.jpg" width="180"/></td>
    <td><img src="https://raw.githubusercontent.com/manojprajapati1999/flexi_form_field/main/assets/images/auto_complete.jpg" width="180"/></td>
    <td><img src="https://raw.githubusercontent.com/manojprajapati1999/flexi_form_field/main/assets/images/date_picker.jpg" width="180"/></td>
    <td><img src="https://raw.githubusercontent.com/manojprajapati1999/flexi_form_field/main/assets/images/other.jpg" width="180"/></td>
  </tr>
</table>

---

## Widgets

| Widget | Description |
|---|---|
| `FlexiFormField` | Customizable text input with built-in validators and formatters |
| `FlexiDropDown<T>` | Generic type-safe dropdown selector |
| `FlexiDatePicker` | Date picker with formatted output |
| `FlexiTimePicker` | Material time picker |
| `FlexiDateTimePicker` | Combined date + time selection in a single flow |
| `FlexiAutoComplete<T>` | Generic searchable autocomplete field |
| `FlexiButton` | Customizable button with gradient, shadow, and border support |
| `FlexiStepper` | Horizontal animated stepper with auto-scroll |
| `FlexiTabBar` | Segmented tab control with animated indicator |
| `FlexiTimer` | Functional timer with start, pause, resume, and stop |

---

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  flexi_form_field: ^3.0.3
```

Then run:

```bash
flutter pub get
```

Import in your Dart file:

```dart
import 'package:flexi_form_field/flexi_form_field.dart';
```

---

## Theming

All widgets accept an optional `FlexiFormTheme` to maintain a consistent look across your form.

```dart
final myTheme = FlexiFormTheme(
  primaryColor: Colors.indigo,
  borderRadius: BorderRadius.all(Radius.circular(12)),
  labelStyle: TextStyle(color: Colors.black87),
  errorStyle: TextStyle(color: Colors.red),
  fillColor: Colors.grey[100],
);
```

### FlexiFormTheme Properties

| Property | Type | Default | Description |
|---|---|---|---|
| `primaryColor` | `Color` | `Colors.black` | Active border, cursor, and highlight color |
| `borderRadius` | `BorderRadius` | `10` radius | Applied to borders and card wrappers |
| `labelStyle` | `TextStyle` | Black87 | Style for labels and input text |
| `errorStyle` | `TextStyle` | Red | Style for validation error messages |
| `fillColor` | `Color?` | `null` | Background fill color for input fields |

---

## Enums

### FlexiFieldStyle — Border style

| Value | Description |
|---|---|
| `outline` | Standard outline border (default) |
| `filled` | Filled background, no border |
| `underline` | Underline only |
| `rounded` | Fully rounded border (radius 30) |
| `minimal` | No border |

### FlexiFieldLayout — Label position

| Value | Description |
|---|---|
| `floating` | Floating label inside border (Material default) |
| `labelAbove` | Label placed above the input |
| `labelInline` | Label inline with the field |

### FlexiFieldWrapper — Container style

| Value | Description |
|---|---|
| `none` | No wrapper (default) |
| `card` | Wrapped in a Material `Card` |
| `outlined` | Wrapped in an outlined `Container` |

---

## FlexiFormField

A powerful text input widget with built-in validators and input formatters.

```dart
FlexiFormField(
  label: "Email Address",
  hint: "you@example.com",
  prefixIcon: Icon(Icons.alternate_email_rounded, size: 20),
  isEmail: true,
  isMandatory: true,
  theme: myTheme,
)
```

### Properties

| Property | Type | Default | Description |
|---|---|---|---|
| `label` | `String?` | — | Floating / inline label |
| `externalLabel` | `String?` | — | Label displayed above the field |
| `hint` | `String?` | — | Hint/placeholder text |
| `controller` | `TextEditingController?` | — | Controller for reading/setting value |
| `fieldStyle` | `FlexiFieldStyle` | `outline` | Border style |
| `fieldLayout` | `FlexiFieldLayout` | `floating` | Label layout |
| `wrapper` | `FlexiFieldWrapper` | `none` | Container wrapper |
| `theme` | `FlexiFormTheme?` | — | Custom theme override |
| `isMandatory` | `bool` | `false` | Marks field required, shows `*` |
| `isEmail` | `bool` | `false` | Validates email format |
| `isMobile` | `bool` | `false` | Validates 10-digit mobile number |
| `isPinCode` | `bool` | `false` | Validates 6-digit pin code |
| `isGST` | `bool` | `false` | Validates GST number format |
| `isNumber` | `bool` | `false` | Restricts input to integers |
| `isDouble` | `bool` | `false` | Restricts input to decimal numbers |
| `isPercentage` | `bool` | `false` | Restricts input to percentage values |
| `uppercaseOnly` | `bool` | `false` | Forces uppercase input |
| `lowercaseOnly` | `bool` | `false` | Forces lowercase input |
| `denySpace` | `bool` | `false` | Prevents whitespace characters |
| `autoValidate` | `bool` | `false` | Validates on every change |
| `obscureText` | `bool` | `false` | Hides text (passwords) |
| `enabled` | `bool` | `true` | Enables or disables the field |
| `readOnly` | `bool` | `false` | Makes the field read-only |
| `maxLines` | `int` | `1` | Maximum number of lines |
| `maxLength` | `int?` | — | Maximum character count |
| `keyboardType` | `TextInputType?` | — | Keyboard type |
| `inputFormatters` | `List<TextInputFormatter>?` | — | Custom input formatters |
| `prefixIcon` | `Widget?` | — | Widget shown at the start |
| `suffixIcon` | `Widget?` | — | Widget shown at the end |
| `validator` | `String? Function(String?)?` | — | Custom validation function |
| `onChanged` | `ValueChanged<String>?` | — | Called on text change |
| `onTap` | `VoidCallback?` | — | Called on field tap |
| `fillColor` | `Color?` | — | Background fill color override |
| `borderRadius` | `double?` | — | Border radius override |
| `cursorColor` | `Color?` | — | Cursor color override |
| `cursorHeight` | `double?` | — | Cursor height override |
| `fontSize` | `double?` | — | Text font size override |
| `style` | `TextStyle?` | — | Full input text style override |
| `labelStyle` | `TextStyle?` | — | Label text style override |
| `hintStyle` | `TextStyle?` | — | Hint text style override |
| `contentPadding` | `EdgeInsetsGeometry?` | — | Internal padding |
| `margin` | `EdgeInsetsGeometry?` | — | Outer margin |

### Examples

**Email field with mandatory validation:**
```dart
FlexiFormField(
  label: "Email",
  isEmail: true,
  isMandatory: true,
  prefixIcon: Icon(Icons.email_outlined, size: 20),
  theme: myTheme,
)
```

**Filled-style password field:**
```dart
FlexiFormField(
  label: "Password",
  fieldStyle: FlexiFieldStyle.filled,
  obscureText: true,
  isMandatory: true,
  fillColor: Colors.grey[100],
)
```

**Numbers-only field with external label:**
```dart
FlexiFormField(
  externalLabel: "Phone Number",
  hint: "Enter 10-digit number",
  isMobile: true,
  isMandatory: true,
  keyboardType: TextInputType.phone,
)
```

**Multiline text area:**
```dart
FlexiFormField(
  label: "Notes",
  maxLines: 5,
  fieldStyle: FlexiFieldStyle.outline,
)
```

---

## FlexiDropDown\<T\>

A generic type-safe dropdown built on the same styling system.

```dart
FlexiDropDown<String>(
  label: "Gender",
  hint: "Choose...",
  isMandatory: true,
  items: const [
    DropdownMenuItem(value: "M", child: Text("Male")),
    DropdownMenuItem(value: "F", child: Text("Female")),
    DropdownMenuItem(value: "O", child: Text("Other")),
  ],
  onChanged: (value) => print(value),
  theme: myTheme,
)
```

Shares the same `fieldStyle`, `fieldLayout`, `wrapper`, `theme`, `isMandatory`, `prefixIcon`, `suffixIcon`, `label`, `externalLabel`, `hint`, `fillColor`, `borderRadius`, `fontSize`, and style override properties as `FlexiFormField`.

---

## FlexiDatePicker

Opens the Material date dialog on tap and writes the formatted date to the controller.

```dart
final dateController = TextEditingController();

FlexiDatePicker(
  controller: dateController,
  label: "Date of Birth",
  hint: "Select a date",
  dateFormat: 'dd-MM-yyyy',      // Default
  isMandatory: true,
  showClearButton: true,
  firstDate: DateTime(1900),
  lastDate: DateTime.now(),
  prefixIcon: Icon(Icons.calendar_today_rounded, size: 20),
  onSelect: (DateTime? date, String formatted) {
    print('Selected: $formatted');
  },
  theme: myTheme,
)
```

### Key Properties

| Property | Type | Default | Description |
|---|---|---|---|
| `controller` | `TextEditingController` | **required** | Receives the formatted date string |
| `dateFormat` | `String` | `'dd-MM-yyyy'` | Any `intl` date format pattern |
| `firstDate` | `DateTime?` | `DateTime(1900)` | Earliest selectable date |
| `lastDate` | `DateTime?` | `DateTime(2100)` | Latest selectable date |
| `initialDate` | `DateTime?` | `DateTime.now()` | Initially highlighted date |
| `showClearButton` | `bool` | `true` | Shows × button when value is set |
| `onSelect` | `Function(DateTime?, String)?` | — | Callback with both the parsed and formatted values |
| `focusNode` / `nextFocusNode` | `FocusNode?` | — | Focus navigation support |

---

## FlexiTimePicker

Opens the Material time dialog on tap.

```dart
final timeController = TextEditingController();

FlexiTimePicker(
  controller: timeController,
  label: "Meeting Time",
  hint: "Select a time",
  isMandatory: true,
  showClearButton: true,
  initialTime: TimeOfDay(hour: 9, minute: 0),
  prefixIcon: Icon(Icons.access_time_rounded, size: 20),
  onSelect: (TimeOfDay? time, String? formatted) {
    print('Selected: $formatted');
  },
  theme: myTheme,
)
```

---

## FlexiDateTimePicker

Chains a date picker immediately followed by a time picker in a single tap.

```dart
final dtController = TextEditingController();

FlexiDateTimePicker(
  controller: dtController,
  label: "Appointment",
  hint: "Select date & time",
  dateFormat: 'dd-MM-yyyy HH:mm',   // Default
  isMandatory: true,
  prefixIcon: Icon(Icons.calendar_month_rounded, size: 20),
  onSelect: (DateTime? dt, String formatted) {
    print('Appointment: $formatted');
  },
  theme: myTheme,
)
```

---

## FlexiAutoComplete\<T\>

A generic searchable autocomplete backed by `flutter_typeahead`.

```dart
final searchController = TextEditingController();
final List<String> countries = ["India", "USA", "Germany", "Japan"];

FlexiAutoComplete<String>(
  controller: searchController,
  label: "Country",
  hint: "Start typing...",
  options: countries,
  itemLabelBuilder: (country) => country,
  isMandatory: true,
  prefixIcon: Icon(Icons.public_rounded, size: 20),
  onSelected: (String? selected) {
    print('Selected: $selected');
  },
  onChanged: (String? value, String text) {},
  theme: myTheme,
)
```

### Key Properties

| Property | Type | Description |
|---|---|---|
| `options` | `List<T>` | Full list of suggestions |
| `itemLabelBuilder` | `String Function(T)` | Converts item to display string |
| `onSelected` | `Function(T?)?` | Called when a suggestion is tapped |
| `onChanged` | `Function(T?, String)?` | Called on every text change |
| `showClearButton` | `bool?` | Show clear icon when text is present |
| `hideEmptyListBanner` | `bool?` | Hides the "no results" banner |
| `numberOnly` | `bool?` | Restricts input to numeric characters |
| `isDouble` | `bool?` | Restricts input to decimal numbers |
| `isMobileNumber` | `bool?` | Restricts to mobile-style numeric input |

---

## FlexiButton

A highly customizable button with gradient, shadow, animation, and shape support.

```dart
FlexiButton(
  width: double.infinity,
  height: 52,
  onTap: () => submitForm(),
  child: Text("SUBMIT"),
)
```

**Gradient button:**
```dart
FlexiButton(
  width: double.infinity,
  gradient: LinearGradient(
    colors: [Colors.purple, Colors.deepPurple],
  ),
  borderRadius: 16,
  onTap: () {},
  child: Text("GET STARTED"),
)
```

**Outlined button:**
```dart
FlexiButton(
  color: Colors.transparent,
  border: Border.all(color: Colors.black, width: 1.5),
  textColor: Colors.black,
  onTap: () {},
  child: Text("SECONDARY"),
)
```

### Properties

| Property | Type | Default | Description |
|---|---|---|---|
| `onTap` | `VoidCallback` | **required** | Tap handler |
| `child` | `Widget` | **required** | Button content (typically `Text`) |
| `width` | `double?` | — | Button width (`double.infinity` for full width) |
| `height` | `double?` | `48` | Button height |
| `color` | `Color?` | Theme-aware | Background color |
| `gradient` | `Gradient?` | — | Gradient background (overrides `color`) |
| `border` | `Border?` | — | Custom border |
| `boxShadow` | `List<BoxShadow>?` | — | Shadow list |
| `borderRadius` | `double?` | `12` | Corner radius |
| `shape` | `BoxShape` | `rectangle` | `rectangle` or `circle` |
| `elevation` | `double` | `0` | Material elevation |
| `textColor` | `Color?` | Theme-aware | Default text color for child |
| `fontSize` | `double?` | `16` | Default font size for child |
| `animate` | `bool` | `true` | Enables 200ms press animation |
| `padding` | `EdgeInsetsGeometry?` | — | Internal padding |
| `margin` | `EdgeInsetsGeometry?` | — | Outer margin |
| `alignment` | `AlignmentGeometry?` | `center` | Content alignment |

---

## FlexiStepper

A horizontal scrollable stepper that auto-scrolls to the active step.

```dart
int _currentStep = 0;

FlexiStepper(
  currentStep: _currentStep,
  stepTitles: ["Basic Info", "Contact", "Address", "Review"],
  onStepChange: (index) => setState(() => _currentStep = index),
  borderRadius: 12,
  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
)
```

### Properties

| Property | Type | Default | Description |
|---|---|---|---|
| `currentStep` | `int` | **required** | Index of the active step |
| `stepTitles` | `List<String>` | **required** | Labels for each step |
| `onStepChange` | `Function(int)?` | — | Called when a step chip is tapped |
| `activeColor` | `Color?` | Theme-aware | Background of active step chip |
| `inactiveColor` | `Color?` | Theme-aware | Border color of inactive chips |
| `activeTextColor` | `Color?` | Theme-aware | Text color of active chip |
| `inactiveTextColor` | `Color?` | Theme-aware | Text color of inactive chips |
| `height` | `double` | `36` | Height of the stepper row |
| `borderRadius` | `double?` | `12` | Chip corner radius |
| `scrollDuration` | `Duration` | `500ms` | Auto-scroll animation duration |
| `scrollCurve` | `Curve` | `easeInOut` | Auto-scroll animation curve |
| `textStyle` | `TextStyle?` | — | Text style for step labels |
| `padding` / `margin` | `EdgeInsetsGeometry?` | — | Spacing |

---

## FlexiTabBar

An animated segmented control for switching between views.

```dart
int _tab = 0;

FlexiTabBar(
  tabs: ["Active", "Completed", "Archived"],
  currentIndex: _tab,
  onChanged: (index) => setState(() => _tab = index),
  borderRadius: 12,
)
```

**With gradient active indicator:**
```dart
FlexiTabBar(
  tabs: ["Day", "Week", "Month"],
  currentIndex: _tab,
  onChanged: (i) => setState(() => _tab = i),
  activeGradient: LinearGradient(
    colors: [Colors.purple, Colors.deepPurple],
  ),
)
```

### Properties

| Property | Type | Default | Description |
|---|---|---|---|
| `tabs` | `List<String>` | **required** | Tab labels |
| `currentIndex` | `int` | **required** | Active tab index |
| `onChanged` | `Function(int)` | **required** | Called when a tab is tapped |
| `activeColor` | `Color?` | Theme-aware | Active tab background color |
| `backgroundColor` | `Color?` | Theme-aware | Container background color |
| `activeTextColor` | `Color?` | Theme-aware | Active tab text color |
| `inactiveTextColor` | `Color?` | Theme-aware | Inactive tab text color |
| `activeGradient` | `Gradient?` | — | Gradient for active indicator (overrides `activeColor`) |
| `borderRadius` | `double?` | `12` | Corner radius |
| `height` | `double?` | — | Fixed height |
| `fontSize` | `double?` | `14` | Tab label font size |
| `padding` / `margin` | `EdgeInsetsGeometry?` | — | Spacing |

---

## FlexiTimer

A self-contained countdown-style timer with start, pause, resume, and stop controls.

```dart
FlexiTimer(
  borderRadius: 16,
  startLabel: "Start",
  pauseLabel: "Pause",
  resumeLabel: "Resume",
  stopLabel: "Stop",
)
```

### Properties

| Property | Type | Default | Description |
|---|---|---|---|
| `buttonColor` | `Color?` | — | Override for all button colors |
| `buttonTextColor` | `Color?` | — | Override for all button text colors |
| `timerStyle` | `TextStyle?` | 54px thin | Style for the time display |
| `startLabel` | `String` | `"Start"` | Start button label |
| `pauseLabel` | `String` | `"Pause"` | Pause button label |
| `resumeLabel` | `String` | `"Resume"` | Resume button label |
| `stopLabel` | `String` | `"Stop"` | Stop button label |
| `borderRadius` | `double?` | `16` | Container corner radius |
| `padding` / `margin` | `EdgeInsetsGeometry?` | — | Spacing |

---

## Dependencies

| Package | Purpose |
|---|---|
| `intl: ^0.20.2` | Date formatting for `FlexiDatePicker` and `FlexiDateTimePicker` |
| `flutter_typeahead: ^6.0.0` | Suggestion list engine for `FlexiAutoComplete` |

---

## Platform Support

Android · iOS · macOS · Windows · Linux · Web

---

## License

MIT License — see [LICENSE](LICENSE) for details.

---

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a full version history.

---

## Repository

[github.com/manojprajapati1999/flexi_form_field](https://github.com/manojprajapati1999/flexi_form_field)

## 👨‍💻 Author
**Manoj Patadiya**
📧 Email: patadiyamanoj4@gmail.com
