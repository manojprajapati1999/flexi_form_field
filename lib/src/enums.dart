/// Defines the type of field to be rendered.
enum FlexiFieldType {
  /// Standard text input field.
  text,

  /// Dropdown selection field.
  dropdown,

  /// Date selection field.
  date,

  /// Time selection field.
  time,

  /// Toggle or switch field.
  switcher,
}

/// Defines the visual style of the input border.
enum FlexiFieldStyle {
  /// Standard outline border.
  outline,

  /// Filled background with no border.
  filled,

  /// Underline border only.
  underline,

  /// Fully rounded border.
  rounded,

  /// Minimal or no border style.
  minimal,
}

/// Defines how the label is positioned relative to the input field.
enum FlexiFieldLayout {
  /// Label is placed above the input field.
  labelAbove,

  /// Label is placed inline with the input field.
  labelInline,

  /// Label floats inside the border (Material standard).
  floating,
}

/// Defines the outer container style for the field.
enum FlexiFieldWrapper {
  /// No special wrapper.
  none,

  /// Wrapped in a Material Card.
  card,

  /// Wrapped in an additional container with an outline.
  outlined,
}
