import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicare/ExtraScreens/product_details_page1.dart';
import 'package:medicare/Features/Presentation/Common/utils/common_appbar.dart';
import '../../Cart/controllers/cart_controller.dart';
import '../../Cart/pages/shopping_cart_page.dart';
import '../../Wishlist/controllers/wishlist_controller.dart';
import '../../Wishlist/pages/wish_list_page1.dart';
import '../widgets/product_image.dart';
import '../widgets/product_price_section.dart';
import '../widgets/product_description.dart';
import '../widgets/product_action_buttons.dart';

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
  final cartController = Get.put(CartController());
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
          IconButton(
            onPressed: () {
              Get.to(ShoppingCart(showOwnAppBar: true));
            },
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
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
