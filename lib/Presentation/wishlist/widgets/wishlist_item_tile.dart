import 'package:flutter/material.dart';

class WishlistItemTile extends StatelessWidget {
  // final Product1 product;

  const WishlistItemTile({super.key,
    // required this.product
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          Padding(padding: EdgeInsets.all(3)),
        //   WishlistProductImage(emoji: product.image),
        //   SizedBox(width: SConfig.sWidth * 0.030),
        //   Expanded(child: WishlistProductInfo(product: product)),
         ],
      ),
    );
  }
}
