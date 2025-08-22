import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Cart/pages/shopping_cart_page.dart';
import '../../Common/utils/common_appbar.dart';
import '../../Profile/pages/profile_page.dart';
import '../../Search/pages/search_page.dart';
import '../../Settings/pages/setting_page.dart';
import '../../Wishlist/pages/wish_list_page1.dart';
import 'home_page.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    SearchScreen(),
    ShoppingCart(showOwnAppBar: false),
    ProfilePage(),
  ];

  final List<String> _titles = [
    "MediCare+",
    "Search Results",
    "Shopping Cart",
    "Profile"
  ];

  final List<List<Widget>> _actions = [
    [
      Row(
        children: [
          IconButton(
            onPressed: () => Get.to(WishlistPage()),
            icon: const Icon(Icons.favorite, color: Colors.red),
          ),
          IconButton(
            onPressed: () => Get.to(const ShoppingCart(showOwnAppBar: true)),
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
          ),
        ],
      )
    ],
    [const SizedBox()],
    [const SizedBox()],
    [
      IconButton(
        onPressed: () => Get.to(SettingsScreen()),
        icon: const Icon(Icons.settings),
      )
    ],
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: _titles[_selectedIndex],
        actions: _actions[_selectedIndex],
        leading: false,
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue.shade600,
        items: const [
          BottomNavigationBarItem(icon: Text("🏠", style: TextStyle(fontSize: 20)), label: "Home"),
          BottomNavigationBarItem(icon: Text("🔍", style: TextStyle(fontSize: 20)), label: "Search"),
          BottomNavigationBarItem(icon: Text("🛒", style: TextStyle(fontSize: 20)), label: "Cart"),
          BottomNavigationBarItem(icon: Text("👤", style: TextStyle(fontSize: 20)), label: "Profile"),
        ],
      ),
    );
  }
}