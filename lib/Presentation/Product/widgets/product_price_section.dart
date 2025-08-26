import 'package:flutter/material.dart';

import '../pages/product_details_page.dart';

class ProductPriceSection extends StatelessWidget {
  final Product1 product;

  const ProductPriceSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "₹${product.price.toStringAsFixed(2)}",
          style: const TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.green),
        ),
        const SizedBox(width: 10),
        if (product.prescriptionRequired)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.amber.shade100,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text("Prescription Required",
                style:
                TextStyle(color: Colors.orange, fontWeight: FontWeight.w600)),
          ),
      ],
    );
  }
}
