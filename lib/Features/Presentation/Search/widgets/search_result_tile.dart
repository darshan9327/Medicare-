import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicare/Features/Presentation/Product/pages/product_details_page.dart';
import '../pages/search_page.dart';

class SearchResultTile extends StatelessWidget {
  final Medicine medicine;

  const SearchResultTile({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
              () => ProductDetailPage(
            product: Product1(
              name: medicine.name,
              company: medicine.company,
              price: medicine.price,
              description: medicine.description,
              image: medicine.emoji,
              prescriptionRequired: medicine.prescriptionRequired,
            ),
          ),
        );
      },
      child: Card(
        shadowColor: Colors.grey.shade500,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.only(bottom: 12),
        child: ListTile(
          leading: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.shade200,
            ),
            child: Padding(
              padding: const EdgeInsets.all(7),
              child: Text("💊", style: TextStyle(fontSize: 30)),
            ),
          ),
          title: Text(medicine.name,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(medicine.company),
              Text(
                "₹${medicine.price.toStringAsFixed(2)}",
                style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              if (medicine.prescriptionRequired)
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade100,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    "Prescription Required",
                    style: TextStyle(fontSize: 12, color: Colors.orange),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
