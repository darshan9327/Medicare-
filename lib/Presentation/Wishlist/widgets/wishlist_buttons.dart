import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Cart/controllers/cart_controller.dart';
import '../../Common/widgets/common_container.dart';
import '../../Prescription/pages/upload_prescription_page.dart';
import '../../Product/pages/product_details_page.dart';
import '../controllers/wishlist_controller.dart';

class WishlistButtons extends StatelessWidget {
  final Product1 product;

  const WishlistButtons({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final wishlistController = Get.find<WishlistController>();
    final cartController = Get.find<CartController>();

    return Row(
      children: [
        CommonContainer(
          text: "Remove",
          color: Colors.white,
          color1: Colors.blue,
          onPressed: () => wishlistController.removeFromWishlist(product),
        ),
        const SizedBox(width: 10),
        CommonContainer(
          text: "Add to Cart",
          onPressed: () {
            if (product.prescriptionRequired) {
              Get.to(() => UploadPrescription(product: product,));
            } else {
              cartController.addToCart(
                  CartItem(
                    name: product.name,
                    company: product.company,
                    price: product.price,
                    image: product.image,
                    requiresPrescription: product.prescriptionRequired,
                  )
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("${product.name} added to cart")),
              );
            }
          }
        ),
      ],
    );
  }
}
