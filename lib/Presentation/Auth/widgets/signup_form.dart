import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Common/utils/size_config.dart';
import '../../Common/widgets/common_container.dart';
import '../../Common/widgets/common_text_form_field.dart';
import '../../Dashboard/pages/dashboard_page.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _signupFormKey = GlobalKey<FormState>();
  final _fullName = TextEditingController();
  final _mobileNo = TextEditingController();
  final _email = TextEditingController();

  Future<void> _saveLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLoggedIn", true);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _signupFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Full Name"),
          const SizedBox(height: 5),
          CommonTextFormField(
            controller: _fullName,
            hintText: "Enter your name",
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Full name is required";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          const Text("Mobile Number"),
          const SizedBox(height: 5),
          CommonTextFormField(
            controller: _mobileNo,
            hintText: "+91 98765 43210",
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || !RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                return "Enter valid 10-digit number";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          const Text("Email"),
          const SizedBox(height: 5),
          CommonTextFormField(
            controller: _email,
            hintText: "Enter your Email Id",
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Email is required";
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(value)) {
                return "Enter valid email";
              }
              return null;
            },
          ),

          SizedBox(height: SConfig.sHeight * 0.050),

          CommonContainer(
            text: "Signup",
            onPressed: () async {
              if (_signupFormKey.currentState!.validate()) {
                final messenger = ScaffoldMessenger.of(context);
                await _saveLoginStatus();
                // Get.offAll(() => DashboardScreen());

                messenger.showSnackBar(const SnackBar(content: Text("Signup successful")));
              }
            },
          ),
        ],
      ),
    );
  }
}
