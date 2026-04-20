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
  bool _checkValue = false;
  List<String> _selectedFruits = [];
  String _gender = 'Male';
  bool _switchValue = false;
  int _tabIndex = 0;
  bool _isSwipeEnabled = true;

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
    return [
      ..._build12Cases(
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
      ),
      const SizedBox(height: 30),
      _sectionHeader("Multi-Select Dropdown"),
      FlexiMultiSelectDropdown(
        label: "Favorite Fruits",
        hint: "Select multiple fruits",
        items: const ["Apple", "Banana", "Cherry", "Date", "Elderberry", "Fig", "Grape"],
        selectedItems: _selectedFruits,
        onChanged: (values) => setState(() => _selectedFruits = values),
        theme: _appTheme,
        isMandatory: true,
      ),
    ];
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
      _sectionHeader("Premium Text & Marquee"),
      const FlexiText(
        "This is a standard FlexiText widget. It behaves like a normal text.",
        fontSize: 14,
      ),
      const SizedBox(height: 15),
      const FlexiText(
        "This text is too long for a single line on most screens, so it will automatically start scrolling using the marquee effect once it detects an overflow condition in auto mode.",
        fontSize: 16,
        fontWeight: FontWeight.w900,
        marquee: MarqueeMode.auto,
      ),
      const SizedBox(height: 15),
      const FlexiText(
        "FORCE SCROLLING TEXT",
        fontSize: 18,
        fontWeight: FontWeight.w900,
        color: Colors.red,
        marquee: MarqueeMode.always,
      ),
      const SizedBox(height: 30),
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
        onChange: (int index) {  },
      ),
      const SizedBox(height: 30),
      _sectionHeader("Selection"),
      FlexiCheckBox(
        value: _checkValue,
        label: "Accept Terms & Conditions",
        isMandatory: true,
        onChanged: (v) => setState(() => _checkValue = v ?? false),
        theme: _appTheme,
      ),
      const SizedBox(height: 10),
      FlexiCheckBox(
        value: !_checkValue,
        label: "Subscribe to Newsletter",
        onChanged: (v) => setState(() => _checkValue = !(v ?? false)),
        theme: _appTheme,
      ),
      const SizedBox(height: 30),
      _sectionHeader("Gallery & Sliders"),
      FlexiButton(
        onTap: () {
          FlexiImageSlider.show(
            context,
            images: [
              "https://picsum.photos/id/10/800/800",
              "https://picsum.photos/id/20/800/800",
              "https://picsum.photos/id/30/800/800",
              "https://picsum.photos/id/40/800/800",
            ],
            theme: _appTheme,
          );
        },
        color: Colors.blueGrey,
        child: const Text("OPEN IMAGE SLIDER"),
      ),
      const SizedBox(height: 30),
      _sectionHeader("Dialogs"),
      FlexiButton(
        onTap: () {
          FlexiDeleteDialog.show(
            context,
            itemName: "User Profile",
            onDelete: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Deleted successfully")),
              );
            },
            theme: _appTheme,
          );
        },
        color: Colors.redAccent,
        child: const Text("SHOW DELETE DIALOG"),
      ),
      const SizedBox(height: 30),
      _sectionHeader("File Management"),
      FlexiFilePicker(
        onSelect: (result) {
          if (result != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Selected: ${result.files.first.name}"),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
              width: 2,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.cloud_upload_outlined, color: Theme.of(context).primaryColor),
              const SizedBox(width: 12),
              Text(
                "UPLOAD DOCUMENTS",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 30),
      _sectionHeader("Media Selection"),
      FlexiImagePicker(
        onSelect: (image) {
          if (image != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Image captured: ${image.name}"),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        theme: _appTheme,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.camera_enhance_rounded, color: Colors.white),
              const SizedBox(width: 12),
              Text(
                "TAKE A PHOTO",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 15),
      FlexiButton(
        onTap: () {
          FlexiLogoutDialog.show(
            context,
            onLogout: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Logged out successfully")),
              );
            },
            theme: _appTheme,
          );
        },
        color: Colors.black,
        child: const Text("SHOW LOGOUT DIALOG"),
      ),
      const SizedBox(height: 30),
      _sectionHeader("Media Rendering"),
      const FlexiNetworkImage(
        imageUrl: "https://picsum.photos/800/400",
        height: 200,
        width: double.infinity,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      const SizedBox(height: 10),
      const Text(
        "Random Image from Picsum",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 12, color: Colors.grey),
      ),
      const SizedBox(height: 30),
      _sectionHeader("Selection Controls"),
      Row(
        children: [
          FlexiRadioButton<String>(
            label: "Male",
            value: "Male",
            groupValue: _gender,
            onChanged: (v) => setState(() => _gender = v!),
            theme: _appTheme,
          ),
          const SizedBox(width: 20),
          FlexiRadioButton<String>(
            label: "Female",
            value: "Female",
            groupValue: _gender,
            onChanged: (v) => setState(() => _gender = v!),
            theme: _appTheme,
          ),
          const SizedBox(width: 20),
          FlexiRadioButton<String>(
            label: "Other",
            value: "Other",
            groupValue: _gender,
            onChanged: (v) => setState(() => _gender = v!),
            theme: _appTheme,
          ),
        ],
      ),
      const SizedBox(height: 30),
      _sectionHeader("Loading Indicators"),
      const FlexiScreenLoader(size: 40),
      const SizedBox(height: 10),
      const Text(
        "Platform-aware loader (Cupertino on iOS)",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 12, color: Colors.grey),
      ),
      const SizedBox(height: 30),
      _sectionHeader("Toggle Controls"),
      Row(
        children: [
          FlexiSwitch(
            value: _switchValue,
            onToggle: (v) => setState(() => _switchValue = v),
            theme: _appTheme,
          ),
          const SizedBox(width: 20),
          Text(
            "Notifications: ${_switchValue ? 'ON' : 'OFF'}",
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
      const SizedBox(height: 30),
      _sectionHeader("Tabs & Navigation"),
      Row(
        children: [
          const Text("Enable Swipe:", style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(width: 10),
          FlexiSwitch(
            value: _isSwipeEnabled,
            width: 50,
            height: 24,
            onToggle: (v) => setState(() => _isSwipeEnabled = v),
            theme: _appTheme,
          ),
        ],
      ),
      const SizedBox(height: 10),
      FlexiTabBar(
        tabs: const ["Tab 1", "Tab 2", "Tab 3"],
        currentIndex: _tabIndex,
        onChange: (index) => setState(() => _tabIndex = index),
        theme: _appTheme,
      ),
      SizedBox(
        height: 100,
        child: FlexiTabView(
          currentIndex: _tabIndex,
          isSwipeEnabled: _isSwipeEnabled,
          onPageChanged: (index) => setState(() => _tabIndex = index),
          children: [
            Container(
              color: Colors.grey.withValues(alpha: 0.05),
              alignment: Alignment.center,
              child: const Text("Content of Tab 1"),
            ),
            Container(
              color: Colors.grey.withValues(alpha: 0.05),
              alignment: Alignment.center,
              child: const Text("Content of Tab 2"),
            ),
            Container(
              color: Colors.grey.withValues(alpha: 0.05),
              alignment: Alignment.center,
              child: const Text("Content of Tab 3"),
            ),
          ],
        ),
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
