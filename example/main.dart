import 'package:flutter/material.dart';
import 'package:flexi_form_field/flexi_form_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flexi Form Field',
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final _formKey = GlobalKey<FormState>();
  bool autoValidate = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  TextEditingController gstPercentageController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController remarkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flexi Form Field Example")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              FlexiFormField(
                isMandatory: true,
                validationErrorMassage: "Enter name!",
                autoValidMode: autoValidate,
                hintText: 'Name',
                controller: nameController,
              ),

              const SizedBox(height: 20),

              FlexiFormField(
                isMobileNumber: true,
                isMandatory: true,
                validationErrorMassage: "Enter mobile number!",
                autoValidMode: autoValidate,
                hintText: 'Mobile',
                controller: mobileController,
              ),

              const SizedBox(height: 20),

              FlexiFormField(
                isEmail: true,
                isMandatory: true,
                validationErrorMassage: "Enter email!",
                autoValidMode: autoValidate,
                hintText: 'Email',
                controller: emailController,
              ),

              const SizedBox(height: 20),

              FlexiFormField(
                isGSTNumber: true,
                isMandatory: true,
                validationErrorMassage: "Enter GST number!",
                autoValidMode: autoValidate,
                hintText: 'GST Number',
                controller: gstController,
              ),

              const SizedBox(height: 20),

              FlexiFormField(
                isPercentage: true,
                isMandatory: true,
                validationErrorMassage: "Enter GST Percentage!",
                autoValidMode: autoValidate,
                hintText: 'GST %',
                controller: gstPercentageController,
              ),

              const SizedBox(height: 20),

              FlexiFormField(
                isPinCode: true,
                isMandatory: true,
                validationErrorMassage: "Enter Pincode!",
                autoValidMode: autoValidate,
                hintText: 'Pincode',
                controller: pincodeController,
              ),

              const SizedBox(height: 20),

              FlexiFormField(
                maxLine: 3,
                hintText: 'Remark',
                controller: remarkController,
              ),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Validation Success!')),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
