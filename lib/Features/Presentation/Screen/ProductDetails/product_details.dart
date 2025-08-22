import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicare/CommonScreens/common_container.dart';
import '../../../../Controllers/cart_controller.dart';
import '../../../../Controllers/wishlist_controller.dart';
import '../ShoppingCart/shopping_cart.dart';
import '../UploadPrescription/upload_prescription.dart';
import '../WishList/wish_list.dart';

class Product1 {
  final String name;
  final String company;
  final double price;
  final String description;
  final String image;
  final bool prescriptionRequired;

  Product1({
    required this.name,
    required this.company,
    required this.price,
    required this.description,
    required this.image,
    this.prescriptionRequired = false,
  });
}

class ProductDetailScreen extends StatefulWidget {
  final Product1 product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {

  final CartController cartController = Get.put(CartController());
  final WishlistController wishlistController = Get.put(WishlistController());
  bool isInWishlist = false;
  bool isInCart = false;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details",
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xff478ef8),
        actions: [
          IconButton(onPressed: () {
            Get.to(Wishlist());
          }, icon: const Icon(Icons.favorite,color: Colors.red,)),
          IconButton(onPressed: () {
            Get.to(ShoppingCart(showOwnAppBar: true,));
          }, icon: const Icon(Icons.shopping_cart,color: Colors.white)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(20)),
                child: Text(product.image, style: TextStyle(fontSize: 75)),
              ),
            ),
            const SizedBox(height: 16),
            Text(product.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(product.company, style: TextStyle(color: Colors.grey.shade600)),
            const SizedBox(height: 8),
            Row(
              children: [
                Text("₹${product.price.toStringAsFixed(2)}", style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.green)),
                const SizedBox(width: 10),
                if (product.prescriptionRequired)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: Colors.amber.shade100, borderRadius: BorderRadius.circular(6)),
                    child: const Text("Prescription Required", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w600)),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            const Text("Description", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(20)),
              child: Text(product.description, style: const TextStyle(fontSize: 14, height: 1.4)),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                CommonContainer(
                  color: Colors.white,
                  color1: Colors.blue,
                  text: isInWishlist ? "Remove Wishlist" : "Add to Wishlist",
                  onPressed: () {
                    setState(() {
                      if (isInWishlist) {
                        wishlistController.removeFromWishlist(product);
                        isInWishlist = false;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("${product.name} removed from wishlist"),
                          duration: Duration(seconds: 1),
                          ),
                        );
                      } else {
                        wishlistController.addToWishlist(product);
                        isInWishlist = true;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("${product.name} added to wishlist"),
                          duration: Duration(seconds: 1),
                          ),
                        );
                      }
                    });
                  },
                ),
                Spacer(),
                CommonContainer(
                  text: isInCart ? "Remove from Cart" : "Add to Cart",
                  onPressed: () {
                    setState(() {
                      final cartController = Get.find<CartController>();

                      if (isInCart) {
                        cartController.removeFromCart(
                          CartItem(
                            name: product.name,
                            company: product.company,
                            price: product.price,
                            image: product.image,
                            requiresPrescription: product.prescriptionRequired,
                          ),
                        );
                        isInCart = false;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("${product.name} removed from cart")),
                        );
                      } else {
                        if (product.prescriptionRequired) {
                          Get.to(() => UploadPrescription(product: product));
                        } else {
                          cartController.addToCart(
                            CartItem(
                              name: product.name,
                              company: product.company,
                              price: product.price,
                              image: product.image,
                              requiresPrescription: product.prescriptionRequired,
                            ),
                          );
                          isInCart = true;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("${product.name} added to cart")),
                          );
                        }
                      }
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
