import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Common/utils/size_config.dart';
import '../../Common/widgets/common_container.dart';
import '../../Common/widgets/common_text_form_field.dart';
import '../../Dashboard/pages/dashboard_page.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _mobileNo = TextEditingController();
  final TextEditingController _otp = TextEditingController();

  void _sendOtp() {
    final mobile = _mobileNo.text.trim();

    if (mobile.isEmpty || !RegExp(r'^[0-9]{10}$').hasMatch(mobile)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter valid 10-digit phone number")),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text("OTP sent to your mobile number"),
          duration: Duration(seconds: 2)),
    );
  }

  Future<void> _saveLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLoggedIn", true);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Mobile Number"),
          SizedBox(height: SConfig.sHeight * 0.015),
          CommonTextFormField(
            hintText: "+91 98765 43210",
            keyboardType: TextInputType.number,
            controller: _mobileNo,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Enter mobile number";
              } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                return "Enter valid 10-digit phone number";
              }
              return null;
            },
          ),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  _sendOtp();
                }
              },
              child: Text("Send OTP",
                  style: TextStyle(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w500)),
            ),
          ),
          SizedBox(height: SConfig.sHeight * 0.020),
          const Text("OTP"),
          SizedBox(height: SConfig.sHeight * 0.010),
          CommonTextFormField(
            keyboardType: TextInputType.number,
            maxLength: 6,
            hintText: "Enter 6-digit OTP",
            controller: _otp,
          ),
          SizedBox(height: SConfig.sHeight * 0.030),
          CommonContainer(
            text: "Verify & Login",
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                await _saveLoginStatus();
                // Get.offAll(() => DashboardScreen());
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Center(
              child: Text("OR",
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600)),
            ),
          ),
          CommonContainer(
              text: "Continue with Google",
              color: Colors.white,
              color1: const Color(0xff478ef8),
              onPressed: () {}),
          SizedBox(height: SConfig.sHeight * 0.030),
          CommonContainer(
              text: "Continue with Facebook",
              color: Colors.white,
              color1: const Color(0xff478ef8),
              onPressed: () {}),
        ],
      ),
    );
  }
}
