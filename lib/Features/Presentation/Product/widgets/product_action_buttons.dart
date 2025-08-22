import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Cart/controllers/cart_controller.dart';
import '../../Common/widgets/common_container.dart';
import '../../Prescription/pages/upload_prescription_page.dart';
import '../../Wishlist/controllers/wishlist_controller.dart';
import '../pages/product_details_page.dart';

class ProductActionButtons extends StatelessWidget {
  final Product1 product;
  final bool isInWishlist;
  final bool isInCart;
  final Function(bool) onWishlistToggle;
  final Function(bool) onCartToggle;

  const ProductActionButtons({
    super.key,
    required this.product,
    required this.isInWishlist,
    required this.isInCart,
    required this.onWishlistToggle,
    required this.onCartToggle,
  });

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final wishlistController = Get.find<WishlistController>();

    return Row(
      children: [
        CommonContainer(
          color: Colors.white,
          color1: Colors.blue,
          text: isInWishlist ? "Remove Wishlist" : "Add to Wishlist",
          onPressed: () {
            if (isInWishlist) {
              wishlistController.removeFromWishlist(product);
              onWishlistToggle(false);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${product.name} removed from wishlist"),
                  duration: const Duration(seconds: 1),
                ),
              );
            } else {
              wishlistController.addToWishlist(product);
              onWishlistToggle(true);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${product.name} added to wishlist"),
                  duration: const Duration(seconds: 1),
                ),
              );
            }
          },
        ),
        const Spacer(),
        CommonContainer(
          text: isInCart ? "Remove from Cart" : "Add to Cart",
          onPressed: () {
            if (isInCart) {
              cartController.removeFromCartByName(product.name);
              onCartToggle(false);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("${product.name} removed from cart"),
                duration: Duration(seconds: 1),),
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
                onCartToggle(true);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("${product.name} added to cart"),
                  duration: Duration(seconds: 1),),
                );
              }
            }
          },
        ),
      ],
    );
  }
}
