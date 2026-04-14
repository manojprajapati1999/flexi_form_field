import 'dart:ui';
import 'package:flexi_form_field/flexi_form_field.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flexi Widgets Showcase',
      themeMode: _themeMode,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          primary: Colors.black,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        dividerColor: Colors.grey.shade300,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primaryColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          primary: Colors.white,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF121212),
        dividerColor: Colors.white24,
      ),
      home: ExampleScreen(onThemeToggle: _toggleTheme, currentMode: _themeMode),
    );
  }
}

class ExampleScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final ThemeMode currentMode;

  const ExampleScreen({
    super.key,
    required this.onThemeToggle,
    required this.currentMode,
  });

  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  int _currentStep = 0;

  final List<String> _categories = [
    "Form Demo",
    "Text Field",
    "Dropdown",
    "Date Picker",
    "Time Picker",
    "Auto-Complete",
    "Others",
  ];

  FlexiFormTheme get _appTheme {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return FlexiFormTheme(
      primaryColor: Theme.of(context).primaryColor,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      fillColor: isDark
          ? Colors.white.withValues(alpha: 0.05)
          : Colors.grey[200],
      labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black87),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Flexi Premium Showcase",
          style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: -0.5),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: widget.onThemeToggle,
            icon: Icon(
              widget.currentMode == ThemeMode.light
                  ? Icons.dark_mode_rounded
                  : Icons.light_mode_rounded,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            FlexiStepper(
              currentStep: _currentStep,
              stepTitles: _categories,
              onStepChange: (index) => setState(() => _currentStep = index),
              borderRadius: 12,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: ListView(
                  key: ValueKey(_currentStep),
                  padding: const EdgeInsets.all(20),
                  physics: const BouncingScrollPhysics(),
                  children: _buildStepContent(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return [_buildFormDemo()];
      case 1:
        return _buildTextFieldShowcase();
      case 2:
        return _buildDropdownShowcase();
      case 3:
        return _buildDatePickerShowcase();
      case 4:
        return _buildTimePickerShowcase();
      case 5:
        return _buildAutoCompleteShowcase();
      case 6:
        return _buildOthersShowcase();
      default:
        return [const Text("Select a category")];
    }
  }

  // --- Helpers for 12 Cases ---
  List<Widget> _build12Cases({
    required String title,
    required Widget Function(
      FlexiFieldStyle style,
      String? label,
      String? extLabel,
      String? hint,
      FlexiFieldLayout layout,
    )
    builder,
  }) {
    return [
      _sectionHeader(title),

      // 1. Rounded
      _styleSubHeader("Rounded Border"),
      builder(
        FlexiFieldStyle.rounded,
        null,
        "1.1 External Label",
        "Type here...",
        FlexiFieldLayout.floating,
      ),
      const SizedBox(height: 15),
      builder(
        FlexiFieldStyle.rounded,
        "1.2 Internal Label",
        null,
        "Floating label",
        FlexiFieldLayout.floating,
      ),
      const SizedBox(height: 15),
      builder(
        FlexiFieldStyle.rounded,
        null,
        null,
        "1.3 Hint Only",
        FlexiFieldLayout.labelInline,
      ),
      const SizedBox(height: 30),

      // 2. Simple
      _styleSubHeader("Simple Border (Outline)"),
      builder(
        FlexiFieldStyle.outline,
        null,
        "2.1 External Label",
        "Type here...",
        FlexiFieldLayout.floating,
      ),
      const SizedBox(height: 15),
      builder(
        FlexiFieldStyle.outline,
        "2.2 Internal Label",
        null,
        "Floating label",
        FlexiFieldLayout.floating,
      ),
      const SizedBox(height: 15),
      builder(
        FlexiFieldStyle.outline,
        null,
        null,
        "2.3 Hint Only",
        FlexiFieldLayout.labelInline,
      ),
      const SizedBox(height: 30),

      // 3. Underline
      _styleSubHeader("Underline Border"),
      builder(
        FlexiFieldStyle.underline,
        null,
        "3.1 External Label",
        "Type here...",
        FlexiFieldLayout.floating,
      ),
      const SizedBox(height: 15),
      builder(
        FlexiFieldStyle.underline,
        "3.2 Internal Label",
        null,
        "Floating label",
        FlexiFieldLayout.floating,
      ),
      const SizedBox(height: 15),
      builder(
        FlexiFieldStyle.underline,
        null,
        null,
        "3.3 Hint Only",
        FlexiFieldLayout.labelInline,
      ),
      const SizedBox(height: 30),

      // 4. Filled
      _styleSubHeader("Filled (No Border)"),
      builder(
        FlexiFieldStyle.filled,
        null,
        "4.1 External Label",
        "Type here...",
        FlexiFieldLayout.floating,
      ),
      const SizedBox(height: 15),
      builder(
        FlexiFieldStyle.filled,
        "4.2 Internal Label",
        null,
        "Floating label",
        FlexiFieldLayout.floating,
      ),
      const SizedBox(height: 15),
      builder(
        FlexiFieldStyle.filled,
        null,
        null,
        "4.3 Hint Only",
        FlexiFieldLayout.labelInline,
      ),
      const SizedBox(height: 30),
    ];
  }

  // --- 0. FORM DEMO (Redesigned with Transparent Card & Internal Labels) ---
  Widget _buildFormDemo() {
    final isDark = widget.currentMode == ThemeMode.dark;
    final countries = [
      "United States",
      "India",
      "Germany",
      "Japan",
      "Brazil",
      "Canada",
      "Australia",
    ];

    return Column(
      children: [
        _sectionHeader("Premium Registration"),
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.05)
                    : Colors.white.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.1)
                      : Colors.black.withValues(alpha: 0.05),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(28.0),
              child: Column(
                children: [
                  FlexiFormField(
                    label: "Full Name",
                    hint: "Enter your legal name",
                    prefixIcon: const Icon(
                      Icons.person_outline_rounded,
                      size: 20,
                    ),
                    theme: _appTheme,
                    isMandatory: true,
                  ),
                  const SizedBox(height: 18),
                  FlexiFormField(
                    label: "Email Address",
                    hint: "yourname@example.com",
                    prefixIcon: const Icon(
                      Icons.alternate_email_rounded,
                      size: 20,
                    ),
                    theme: _appTheme,
                    isEmail: true,
                    isMandatory: true,
                  ),
                  const SizedBox(height: 18),
                  FlexiDropDown<String>(
                    label: "Gender Selection",
                    hint: "Choose your gender",
                    prefixIcon: const Icon(
                      Icons.people_outline_rounded,
                      size: 20,
                    ),
                    items: const [
                      DropdownMenuItem(value: "M", child: Text("Male")),
                      DropdownMenuItem(value: "F", child: Text("Female")),
                      DropdownMenuItem(value: "O", child: Text("Other")),
                    ],
                    onChanged: (v) {},
                    theme: _appTheme,
                    isMandatory: true,
                  ),
                  const SizedBox(height: 18),
                  FlexiAutoComplete<String>(
                    controller: TextEditingController(),
                    label: "Country",
                    hint: "Where are you from?",
                    options: countries,
                    prefixIcon: const Icon(Icons.public_rounded, size: 20),
                    itemLabelBuilder: (c) => c,
                    theme: _appTheme,
                  ),
                  const SizedBox(height: 18),
                  FlexiDatePicker(
                    controller: TextEditingController(),
                    label: "Date of Birth",
                    hint: "Select your birthday",
                    prefixIcon: const Icon(
                      Icons.calendar_today_rounded,
                      size: 20,
                    ),
                    theme: _appTheme,
                  ),
                  const SizedBox(height: 18),
                  FlexiTimePicker(
                    controller: TextEditingController(),
                    label: "Consultation Time",
                    hint: "Pick a preferred time",
                    prefixIcon: const Icon(Icons.access_time_rounded, size: 20),
                    theme: _appTheme,
                  ),
                  const SizedBox(height: 28),
                  FlexiButton(
                    width: double.infinity,
                    onTap: () {},
                    child: const Text(
                      "CREATE ACCOUNT",
                      style: TextStyle(
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // --- 1. TEXT FIELD SHOWCASE ---
  List<Widget> _buildTextFieldShowcase() {
    return _build12Cases(
      title: "Text Field Variations",
      builder: (style, label, ext, hint, layout) => FlexiFormField(
        fieldStyle: style,
        label: label,
        externalLabel: ext,
        hint: hint,
        fieldLayout: layout,
        theme: _appTheme,
      ),
    );
  }

  // --- 2. DROPDOWN SHOWCASE ---
  List<Widget> _buildDropdownShowcase() {
    final items = [
      const DropdownMenuItem(value: 1, child: Text("Option 1")),
      const DropdownMenuItem(value: 2, child: Text("Option 2")),
    ];
    return _build12Cases(
      title: "Dropdown Variations",
      builder: (style, label, ext, hint, layout) => FlexiDropDown<int>(
        fieldStyle: style,
        label: label,
        externalLabel: ext,
        hint: hint,
        fieldLayout: layout,
        items: items,
        onChanged: (v) {},
        theme: _appTheme,
      ),
    );
  }

  // --- 3. DATE PICKER SHOWCASE ---
  List<Widget> _buildDatePickerShowcase() {
    return _build12Cases(
      title: "Date Picker Variations",
      builder: (style, label, ext, hint, layout) => FlexiDatePicker(
        controller: TextEditingController(),
        fieldStyle: style,
        label: label,
        externalLabel: ext,
        hint: hint,
        theme: _appTheme,
      ),
    );
  }

  // --- 4. TIME PICKER SHOWCASE ---
  List<Widget> _buildTimePickerShowcase() {
    return _build12Cases(
      title: "Time Picker Variations",
      builder: (style, label, ext, hint, layout) => FlexiTimePicker(
        controller: TextEditingController(),
        fieldStyle: style,
        label: label,
        externalLabel: ext,
        hint: hint,
        theme: _appTheme,
      ),
    );
  }

  // --- 5. AUTO-COMPLETE SHOWCASE ---
  List<Widget> _buildAutoCompleteShowcase() {
    final opts = ["Apple", "Apricot", "Banana"];
    return _build12Cases(
      title: "Auto-Complete Variations",
      builder: (style, label, ext, hint, layout) => FlexiAutoComplete<String>(
        controller: TextEditingController(),
        fieldStyle: style,
        label: label,
        externalLabel: ext,
        hint: hint,
        options: opts,
        itemLabelBuilder: (i) => i,
        theme: _appTheme,
      ),
    );
  }

  // --- 6. OTHERS SHOWCASE ---
  List<Widget> _buildOthersShowcase() {
    return [
      _sectionHeader("Timer"),
      const FlexiTimer(borderRadius: 16),
      const SizedBox(height: 30),
      _sectionHeader("Buttons"),
      FlexiButton(onTap: () {}, child: const Text("PRIMARY")),
      const SizedBox(height: 30),
      _sectionHeader("Navigation"),
      FlexiTabBar(
        tabs: const ["Active", "Completed"],
        currentIndex: 0,
        onChanged: (i) {},
        borderRadius: 8,
      ),
    ];
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 4),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 20,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 16,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _styleSubHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 13,
          color: Theme.of(context).primaryColor.withValues(alpha: 0.7),
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
