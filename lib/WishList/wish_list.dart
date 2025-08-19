import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicare/CommonScreens/common_container.dart';
import 'package:medicare/CommonScreens/size_config.dart';
import 'package:medicare/UploadPrescription/upload_prescription.dart';
import '../Controllers/cart_controller.dart';
import '../DashboardScreen/ShoppingCart/shopping_cart.dart';

class Product {
  final String name;
  final String company;
  final double price;
  final String emoji;
  final bool prescriptionRequired;

  Product({
    required this.name,
    required this.company,
    required this.price,
    required this.emoji,
    this.prescriptionRequired = false,
  });
}

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  final CartController cartController = Get.put(CartController());


  List<Product> wishlist = [
    Product(
      name: "Paracetamol 500mg",
      company: "Cipla Ltd.",
      price: 45.0,
      emoji: "💊",
      prescriptionRequired: false,
    ),
    Product(
      name: "Crocin Syrup",
      company: "GSK",
      price: 68.5,
      emoji: "🧴",
      prescriptionRequired: true,
    ),
    Product(
      name: "Band-Aid Pack",
      company: "Johnson & Johnson",
      price: 125.0,
      emoji: "🩹",
      prescriptionRequired: false,
    ),
  ];

  void removeFromWishlist(int index) {
    setState(() {
      wishlist.removeAt(index);
    });
  }

  void addToCart(Product product) {
    final cartItem = CartItem(
      name: product.name,
      company: product.company,
      price: product.price,
      quantity: 1,
      image: product.emoji,
      requiresPrescription: product.prescriptionRequired,
    );

    cartController.addToCart(cartItem);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${product.name} added to cart")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Wishlist", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          InkWell(
            onTap: (){
              Get.to(ShoppingCart(showOwnAppBar: true));
            },
            child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text("🛒", style: TextStyle(fontSize: 25))
            ),
          )],
        backgroundColor: Color(0xff478ef8),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${wishlist.length} items in wishlist",
                style: const TextStyle(color: Colors.black54)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: wishlist.length,
                itemBuilder: (context, index) {
                  final product = wishlist[index];
                  return Card(
                    color: Colors.white,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: SConfig.sHeight * 0.070,
                            width: SConfig.sWidth * 0.140,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(child: Text(product.emoji, style: const TextStyle(fontSize: 35))),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(product.name,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text(product.company,
                                    style: const TextStyle(
                                        color: Colors.black54)),
                                const SizedBox(height: 6),
                                Text("₹${product.price.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                        color: Colors.green,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                if (product.prescriptionRequired)
                                  Container(
                                    margin: const EdgeInsets.only(top: 6),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.orange[100],
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: const Text(
                                      "Prescription Required",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.orange),
                                    ),
                                  ),
                                SizedBox(height: SConfig.sHeight * 0.010),
                                Row(
                                  children: [
                                    CommonContainer(
                                      color: Colors.white,
                                      color1: Colors.blue,
                                      text: "Remove",
                                      onPressed: () => removeFromWishlist(index),
                                    ),
                                    SizedBox(width: SConfig.sWidth * 0.020),
                                    CommonContainer(
                                      text: "Add to Cart",
                                      onPressed: () {
                                        if(product.prescriptionRequired){
                                          Get.to(UploadPrescription());
                                        }
                                        else{addToCart(product);}},
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
