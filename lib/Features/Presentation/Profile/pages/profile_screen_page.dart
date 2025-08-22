import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicare/Features/Presentation/Profile/pages/profile_information_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Addresses/pages/my_addresses_page.dart';
import '../../Auth/pages/login_signup_page.dart';
import '../../Common/utils/size_config.dart';
import '../../Common/widgets/common_container.dart';
import '../../Help_Support/pages/help_support_page.dart';
import '../../Prescription/pages/my_prescription_page.dart';
import '../../Notification/pages/notifications_page.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              CircleAvatar(radius: 45, backgroundColor: Colors.blue[100], child: Text("👤", style: TextStyle(color: Colors.purple, fontSize: 35))),
              const SizedBox(height: 15),
              const Text("John Doe", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              const Text("+91 98765 43210", style: TextStyle(color: Colors.grey, fontSize: 16)),

              const SizedBox(height: 30),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 6, offset: const Offset(0, 3))],
                ),
                child: Column(
                  children: [
                    _buildProfileOption(
                      text: '👤',
                      title: "Personal Information",
                      subtitle: "Name, Email, Phone",
                      onTap: () {
                        Get.to(ProfileInformation());
                      },
                    ),
                    _divider(),
                    _buildProfileOption(
                      text: '📍',
                      title: "My Addresses",
                      subtitle: "Manage delivery addresses",
                      onTap: () {
                        Get.to(MyAddressesScreen());
                      },
                    ),
                    _divider(),
                    _buildProfileOption(
                      text: '📋',
                      title: "My Prescriptions",
                      subtitle: "Uploaded prescriptions",
                      onTap: () {
                        Get.to(MyPrescriptionsScreen());
                      },
                    ),
                    _divider(),
                    _buildProfileOption(
                      text: '🔔',
                      title: "Notifications",
                      subtitle: "Manage preferences",
                      onTap: () {
                        Get.to(NotificationsScreen());
                      },
                    ),
                    _divider(),
                    _buildProfileOption(
                      text: '❓',
                      title: "Help & Support",
                      subtitle: "FAQs, Contact us",
                      onTap: () {
                        Get.to(HelpSupportScreen());
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: SConfig.sHeight * 0.030),
              CommonContainer(
                text: "Logout",
                color: Colors.white,
                color1: Colors.red,
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.clear();

                  Get.offAll(() => LoginSignupScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption({required String text, required String title, required String subtitle, required VoidCallback onTap}) {
    return ListTile(
      leading: Padding(
        padding: EdgeInsets.only(right: 10),
        child: CircleAvatar(backgroundColor: Colors.grey[100], radius: 25, child: Text(text, style: TextStyle(fontSize: 17))),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      onTap: onTap,
    );
  }

  Widget _divider() {
    return Divider(color: Colors.grey[100], height: 7, thickness: 1);
  }
}
