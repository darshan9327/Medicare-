import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Cart/controllers/cart_controller.dart';
import '../../Cart/pages/shopping_cart_page.dart';
import '../../Common/utils/common_appbar.dart';
import '../../Common/utils/size_config.dart';
import '../../Wishlist/controllers/wishlist_controller.dart';
import '../../Wishlist/pages/wish_list_page1.dart';
import '../widgets/product_action_buttons.dart';
import '../widgets/product_description.dart';
import '../widgets/product_image.dart';
import '../widgets/product_price_section.dart';

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

class ProductDetailPage extends StatefulWidget {
  final Product1 product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final cartController = Get.find<CartController>();
  final wishlistController = Get.put(WishlistController());

  bool isInWishlist = false;
  bool isInCart = false;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      appBar: CommonAppBar(title: "Product Details",
        actions: [
          IconButton(
            onPressed: () {
              Get.to(WishlistPage());
            },
            icon: const Icon(Icons.favorite, color: Colors.red),
          ),
          Stack(
            children: [
              SizedBox(
                height: SConfig.sHeight,
                child: IconButton(
                  onPressed: () {
                    Get.to(() => ShoppingCart(showOwnAppBar: true));
                  },
                  icon: const Icon(Icons.shopping_cart,
                      color: Colors.white, size: 28),
                ),
              ),
              Positioned(
                right: 6,
                top: 6,
                child: Obx(() {
                  final count = cartController.cartItems.length;
                  return count > 0
                      ? Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: Text(
                      "$count",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                      : const SizedBox();
                }),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImage(image: product.image),
            const SizedBox(height: 16),
            Text(product.name,
                style:
                const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(product.company,
                style: TextStyle(color: Colors.grey.shade600)),
            const SizedBox(height: 8),
            ProductPriceSection(product: product),
            const SizedBox(height: 20),
            ProductDescription(description: product.description),
            const SizedBox(height: 30),
            ProductActionButtons(
              product: product,
              isInCart: isInCart,
              isInWishlist: isInWishlist,
              onWishlistToggle: (inWishlist) {
                setState(() => isInWishlist = inWishlist);
              },
              onCartToggle: (inCart) {
                setState(() => isInCart = inCart);
              },
            ),
          ],
        ),
      ),
    );
  }
}
