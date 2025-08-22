import 'package:flutter/material.dart';
import 'summary_row.dart';

class CartSummaryCard extends StatelessWidget {
  final double subtotal;
  final double deliveryFee;
  final double tax;
  final double total;

  const CartSummaryCard({
    super.key,
    required this.subtotal,
    required this.deliveryFee,
    required this.tax,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SummaryRow(label: "Subtotal", value: subtotal),
            SummaryRow(label: "Delivery Fee", value: deliveryFee),
            SummaryRow(label: "Tax", value: tax),
            const Divider(),
            SummaryRow(label: "Total", value: total, bold: true),
          ],
        ),
      ),
    );
  }
}
