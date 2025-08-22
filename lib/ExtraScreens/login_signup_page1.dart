import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Features/Presentation/Common/utils/size_config.dart';
import '../Features/Presentation/Common/widgets/common_container.dart';
import '../Features/Presentation/Common/widgets/common_text_form_field.dart';
import '../Features/Presentation/Dashboard/pages/dashboard_page.dart';

class LoginSignupScreen1 extends StatefulWidget {
  const LoginSignupScreen1({super.key});

  @override
  State<LoginSignupScreen1> createState() => _LoginSignupScreen1State();
}

class _LoginSignupScreen1State extends State<LoginSignupScreen1> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final TextEditingController _mobileNo = TextEditingController();
  final TextEditingController _otp = TextEditingController();
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _mobileNo1 = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _signupFormKey = GlobalKey<FormState>();

  String? _mobileError;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _mobileNo.dispose();
    _otp.dispose();
    _fullName.dispose();
    _mobileNo1.dispose();
    _email.dispose();
    super.dispose();
  }

  void _sendOtp() {
    final mobile = _mobileNo.text.trim();

    if (mobile.isEmpty || !RegExp(r'^[0-9]{10}$').hasMatch(mobile)) {
      setState(() {
        _mobileError = "Enter valid 10-digit phone number";
      });
      return;
    }

    setState(() {
      _mobileError = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("OTP sent to your mobile number"), duration: Duration(seconds: 2)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Icon(Icons.lock, size: 60, color: Colors.orange),
                const SizedBox(height: 20),
                const Text("Welcome Back", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const Text("Sign in to your account", style: TextStyle(color: Colors.grey)),
                SizedBox(height: SConfig.sHeight * 0.030),

                Container(
                  height: 60,
                  decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
                  child: TabBar(
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorPadding: const EdgeInsets.all(5),
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      boxShadow: [BoxShadow(color: Colors.grey.shade300, spreadRadius: 1, blurRadius: 5)],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.black,
                    tabs: const [Tab(text: "Login"), Tab(text: "Signup")],
                    labelStyle: const TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: SConfig.sHeight * 0.030),
                SizedBox(
                  height: SConfig.sHeight * 0.65,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // ------------------- LOGIN -------------------
                      Form(
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
                                child: Text("Send OTP", style: TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.w500)),
                              ),
                            ),
                            SizedBox(height: SConfig.sHeight * 0.020),
                            const Text("OTP"),
                            SizedBox(height: SConfig.sHeight * 0.010),
                            CommonTextFormField(keyboardType: TextInputType.number, maxLength: 6, hintText: "Enter 6-digit OTP", controller: _otp),
                            SizedBox(height: SConfig.sHeight * 0.030),
                            CommonContainer(
                              text: "Verify & Login",
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await _saveLoginStatus();
                                  Get.offAll(DashboardScreen());
                                }
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 30),
                              child: Center(child: Text("OR", style: TextStyle(fontSize: 16, color: Colors.grey.shade600))),
                            ),
                            CommonContainer(text: "Continue with Google", color: Colors.white, color1: const Color(0xff478ef8), onPressed: () {}),
                            SizedBox(height: SConfig.sHeight * 0.030),
                            CommonContainer(text: "Continue with Facebook", color: Colors.white, color1: const Color(0xff478ef8), onPressed: () {}),
                          ],
                        ),
                      ),

                      // ------------------- SIGNUP -------------------
                      Form(
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
                              controller: _mobileNo1,
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
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
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
                                  await _saveLoginStatus();
                                  Get.offAll(DashboardScreen());
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Signup successful")));
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _saveLoginStatus() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool("isLoggedIn", true);
}
