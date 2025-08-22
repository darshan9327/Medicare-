import 'package:flutter/material.dart';
import 'package:medicare/Features/Presentation/Common/utils/size_config.dart';
import 'package:medicare/Features/Presentation/Wishlist/widgets/wishlist_buttons.dart';
import '../../Product/pages/product_details_page.dart';

class WishlistProductInfo extends StatelessWidget {
  final Product1 product;

  const WishlistProductInfo({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: SConfig.sHeight * 0.010),
        Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(product.company, style: const TextStyle(color: Colors.black54)),
        Text("₹${product.price}", style: const TextStyle(color: Colors.green)),
        if (product.prescriptionRequired)
          const Text("Prescription Required",
              style: TextStyle(color: Colors.orange)),
        SizedBox(height:SConfig.sHeight * 0.005),
        WishlistButtons(product: product),
        SizedBox(height:SConfig.sHeight * 0.010)
      ],
    );
  }
}
