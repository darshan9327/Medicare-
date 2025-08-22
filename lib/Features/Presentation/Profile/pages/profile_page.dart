import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicare/Features/Presentation/Profile/pages/profile_information_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Addresses/pages/my_addresses_page.dart';
import '../../Auth/pages/login_signup_page.dart';
import '../../Common/utils/size_config.dart';
import '../../Common/widgets/common_container.dart';
import '../../Help_Support/pages/help_support_page.dart';
import '../../Notification/pages/notification_page.dart';
import '../../Prescription/pages/my_prescription_page.dart';
import '../widgets/ProfilePageWidget/profile_header.dart';
import '../widgets/ProfilePageWidget/profile_options_list.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 30),
              const ProfileHeader(
                name: "John Doe",
                phone: "+91 98765 43210",
              ),
              const SizedBox(height: 30),
              ProfileOptionsList(
                onPersonalInfo: () => Get.to(ProfileInformation()),
                onAddresses: () => Get.to(MyAddressesScreen()),
                onPrescriptions: () => Get.to(MyPrescriptionsScreen()),
                onNotifications: () => Get.to(NotificationsPage()),
                onHelpSupport: () => Get.to(HelpSupportScreen()),
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
}
