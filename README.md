## TextFormFieldPackage

A highly customizable and reusable Flutter TextFormField widget with built-in validations and formatting for common input types like mobile number, email, GST number, password, pincode, percentage, uppercase text, and more.

This package helps you reduce boilerplate code and speed up form creation in Flutter applications.

✨ Features

✔️ Mandatory field indicator (*)

✔️ Mobile number validation

✔️ Email validation

✔️ Pincode validation

✔️ GST number validation

✔️ Confirm password validation

✔️ Minimum password length support

✔️ Uppercase text formatter

✔️ Numeric-only and decimal input support

✔️ Percentage input formatter

✔️ Prefix & suffix icon with tap events

✔️ Custom styling (border, colors, label, hint, error style, padding)

✔️ Focus navigation (current → next field)

✔️ Fully customizable InputDecoration

✔️ Supports TextInputFormatter, TextInputType, maxLength, maxLines

✔️ onTap, onTapOutside, onChange, onSaved, onEditingComplete callbacks

---
## 📦 Installation
Add this to your **pubspec.yaml**:

```yaml
dependencies:
flexi_form_field: ^1.0.0
```

---
## 🔧 Import
```dart
import 'package:flexi_form_field/flexi_form_field.dart';
```

## Basic Example

TextFormFieldPackage(
  label: "Name",
  hintText: "Enter your name",
  isMandatory: true,
)

📱 Mobile Number Example

TextFormFieldPackage(
  label: "Mobile Number",
  isMandatory: true,
  isMobileNumber: true,
  mobileNumberErrorMassage: "Enter valid mobile number!",
)

📧 Email Example

TextFormFieldPackage(
  label: "Email",
  isEmail: true,
  isMandatory: true,
)

🔐 Password + Confirm Password Example

String password = "";

TextFormFieldPackage(
  label: "Password",
  obscureText: true,
  minPasswordLength: 6,
  onChange: (v) => password = v ?? "",
);

TextFormFieldPackage(
  label: "Confirm Password",
  obscureText: true,
  isConfirmPassword: true,
  passWord: password,
);

🧮 Number / Decimal / Percentage Examples

TextFormFieldPackage(
  label: "Age",
  isNumberOnly: true,
  maxLength: 3,
)

* Decimal Number

TextFormFieldPackage(
  label: "Amount",
  isDouble: true,
)

* Percentage Input

TextFormFieldPackage(
  label: "Discount (%)",
  isPercentage: true,
)

🏷 Uppercase Text Example

TextFormFieldPackage(
  label: "PAN Number",
  isUpperCase: true,
)

🧾 GST Number Example

TextFormFieldPackage(
  label: "GST Number",
  isGSTNumber: true,
)

🎨 Customization Options

border, focusedBorder, borderRadius

labelStyle, floatingLabelStyle, errorStyle

cursorColor, cursorHeight

contentPadding, margin

prefixIcon, suffixIcon with tap callbacks

keyboardType, inputFormatters

fillColor, filled

🔌 Callbacks

| Callback              | Description                     |
| --------------------- | ------------------------------- |
| `onTap`               | Called when field is tapped     |
| `onTapOutside`        | Called when click outside field |
| `onChange`            | Fires on every text update      |
| `onSaved`             | Used in `Form` save             |
| `onEditingComplete`   | Called on field submit          |
| `onSuffixIconPressed` | Called on suffix icon click     |
| `onPrefixIconPressed` | Called on prefix icon click     |


🧩 Focus Navigation

TextFormFieldPackage(
  currentFocusNode: currentNode,
  nextFocusNode: nextNode,
)

📌 Validation Rules

The widget supports built-in validations:

* Mandatory field

* Mobile number (first digit must be 6,7,8,9)

* Mobile number regex (10–12 digits)

* Email format

* Pincode (6 digits)

* GST number regex

* Password match

* Minimum password length

* Password format validation

* 1 Uppercase

* 1 Lowercase

* 1 Special character

* 1 Number

📝 License

This package is available under the MIT License.

