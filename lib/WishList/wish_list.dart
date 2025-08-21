import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicare/CommonScreens/common_container.dart';
import 'package:medicare/CommonScreens/size_config.dart';
import 'package:medicare/UploadPrescription/upload_prescription.dart';
import '../Controllers/cart_controller.dart';
import '../Controllers/wishlist_controller.dart';
import '../DashboardScreen/ShoppingCart/shopping_cart.dart';
import '../ProductDetails/product_details.dart';

class Wishlist extends StatelessWidget {
  Wishlist({super.key});

  final WishlistController wishlistController = Get.put(WishlistController());
  final CartController cartController = Get.put(CartController());

  void addToCart(Product1 product, BuildContext context) {
    final cartItem = CartItem(
      name: product.name,
      company: product.company,
      price: product.price,
      image: product.image,
      requiresPrescription: product.prescriptionRequired,
      quantity: 1,
    );

    cartController.addToCart(cartItem);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${product.name} added to cart ✅")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Wishlist",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          InkWell(
            onTap: () => Get.to(() => ShoppingCart(showOwnAppBar: true)),
            child: const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.shopping_cart,color: Colors.white)
            ),
          )
        ],
        backgroundColor: const Color(0xff478ef8),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Obx(() {
          if (wishlistController.wishlist.isEmpty) {
            return const Center(
              child: Text("No items in wishlist",
                  style: TextStyle(color: Colors.black54)),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${wishlistController.wishlist.length} items in wishlist",
                  style: const TextStyle(color: Colors.black54)),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: wishlistController.wishlist.length,
                  itemBuilder: (context, index) {
                    final product = wishlistController.wishlist[index];
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
                              child: Center(
                                  child: Text(product.image,
                                      style: const TextStyle(fontSize: 35))),
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
                                        onPressed: () => wishlistController
                                            .removeFromWishlist(product),
                                      ),
                                      SizedBox(width: SConfig.sWidth * 0.020),
                                      CommonContainer(
                                        text: "Add to Cart",
                                        onPressed: () {
                                          if (product.prescriptionRequired) {
                                            Get.to(() => UploadPrescription(
                                              product: Product1(
                                                name: product.name,
                                                company: product.company,
                                                price: product.price,
                                                description:
                                                "No description provided",
                                                image: product.image,
                                                prescriptionRequired: product
                                                    .prescriptionRequired,
                                              ),
                                            ));
                                          } else {
                                            addToCart(product, context);
                                          }
                                        },
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
          );
        }),
      ),
    );
  }
}
