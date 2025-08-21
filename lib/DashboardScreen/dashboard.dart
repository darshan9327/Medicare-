import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicare/CommonScreens/size_config.dart';
import 'package:medicare/DashboardScreen/ProfileScreen/SettingsScreen/setting_screen.dart';
import 'package:medicare/DashboardScreen/ProfileScreen/profile_screen.dart';
import 'package:medicare/WishList/wish_list.dart';
import '../ProductDetails/product_details.dart';
import 'SearchScreen/search_screen.dart';
import 'ShoppingCart/shopping_cart.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}
final List<Map<String, dynamic>> categories = [
  {"name": "Tablets", "emoji": "💊"},
  {"name": "Syrups", "emoji": "🧴"},
  {"name": "Injections", "emoji": "💉"},
  {"name": "First Aid", "emoji": "🩹"},
];

final List<Map<String, dynamic>> medicines = [
  {
    "name": "Paracetamol 500mg",
    "company": "Cipla Ltd.",
    "price": 45.0,
    "prescription": false,
    "emoji": "💊",
    "description": "Used for fever and mild pain relief"
  },
  {
    "name": "Crocin Syrup",
    "company": "GSK",
    "price": 68.5,
    "prescription": true,
    "emoji": "🧴",
    "description": "Used for diabetes management"
  },
  {
    "name": "Band-Aid Pack",
    "company": "Johnson & Johnson",
    "price": 125.0,
    "emoji": "🩹",
    "prescription": false,
    "description": "Used for protect a wound from dirt and bacteria, preventing infection and promoting healing"
  }
];
class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    SearchScreen(),
    ShoppingCart(showOwnAppBar: false,),
    ProfileScreen(),
  ];

  final List<String> _titles = [
    "MediCare+",
    "Search Results",
    "Shopping Cart",
    "Profile",
  ];

  final List<List<Widget>> _actions = [
    [Row(
      children: [
        IconButton(onPressed: () {
          Get.to(Wishlist());
        }, icon: const Icon(Icons.favorite,color: Colors.red,)),
        IconButton(onPressed: () {
          Get.to(ShoppingCart(showOwnAppBar: true,));
        }, icon: const Icon(Icons.shopping_cart_outlined,color: Colors.white,)),
      ],
    )],
    [SizedBox()],
    [SizedBox()],
    [IconButton(onPressed: () {
      Get.to(SettingsScreen());
    }, icon: const Icon(Icons.settings))],
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_selectedIndex],
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xff478ef8),
        actions: _actions[_selectedIndex],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue.shade600,
        items: const [
          BottomNavigationBarItem(icon: Text("🏠",style: TextStyle(fontSize: 20),), label: "Home"),
          BottomNavigationBarItem(icon: Text("🔍",style: TextStyle(fontSize: 20),), label: "Search"),
          BottomNavigationBarItem(icon: Text("🛒",style: TextStyle(fontSize: 20),), label: "Cart"),
          BottomNavigationBarItem(icon: Text("👤",style: TextStyle(fontSize: 20),), label: "Profile"),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10),
                      child: const Text("🔍" ,style: TextStyle(fontSize: 20)),
                    ),
                    hintText: "Search medicines, brands",
                    filled: true,
                    fillColor: Colors.grey[100],
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28),
                      borderSide: BorderSide(color: Colors.grey.shade200,width: 2)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28),
                      borderSide: BorderSide(color: Colors.grey.shade300,width: 2)),
                  ),
                ),
                const SizedBox(height: 20),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 25,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final item = categories[index];
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 6,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(item["emoji"],style: const TextStyle(fontSize: 40),),
                          const SizedBox(height: 8),
                          Text(item["name"],
                              style: const TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),
                const Text("Popular Medicines",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: medicines.length,
                  itemBuilder: (context, index) {
                    final med = medicines[index];
                    return Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        onTap: () {
                          final product = Product1(
                            name: med["name"],
                            company: med["company"],
                            price: double.parse(med["price"].toString()),
                            description: med["description"] ?? "No description available",
                            image: med["emoji"],
                            prescriptionRequired: med["prescription"] ?? false,
                          );

                          Get.to(() => ProductDetailScreen(product: product));
                        },
                        leading: Container(
                          height: SConfig.sHeight * 0.075,
                          width: SConfig.sWidth * 0.160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade100,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(med["emoji"], style: const TextStyle(fontSize: 35)),
                          ),
                        ),
                        title: Text(
                          med["name"],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(med["company"]),
                            Text(
                              "₹${med["price"]}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            if (med["prescription"])
                              Container(
                                margin: const EdgeInsets.only(top: 4),
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.amber[100],
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  "Prescription Required",
                                  style: TextStyle(fontSize: 10, color: Colors.orange),
                                ),
                              ),
                          ],
                        ),
                      )
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}