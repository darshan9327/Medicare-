import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Common/utils/size_config.dart';
import '../../Product/pages/product_details_page.dart';

final List<Map<String, dynamic>> medicines = [
  {
    "name": "Paracetamol 500mg",
    "company": "Cipla Ltd.",
    "price": 45.0,
    "prescription": false,
    "emoji": "💊",
    "description": "Used for fever and mild pain relief",
  },
  {"name": "Crocin Syrup", "company": "GSK", "price": 68.5, "prescription": true, "emoji": "🧴", "description": "Used for diabetes management"},
  {
    "name": "Band-Aid Pack",
    "company": "Johnson & Johnson",
    "price": 125.0,
    "emoji": "🩹",
    "prescription": false,
    "description": "Protects a wound from dirt and bacteria",
  },
];

class MedicineList extends StatelessWidget {
  const MedicineList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: medicines.length,
      itemBuilder: (context, index) {
        final med = medicines[index];
        return Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: ListTile(
            onTap: () {
              final product = Product1(
                name: med["name"],
                company: med["company"],
                price: double.parse(med["price"].toString()),
                description: med["description"] ?? "No description available",
                image: med["emoji"],
                prescriptionRequired: med["prescription"] ?? false,
              );
              Get.to(() => ProductDetailPage(product: product));
            },
            leading: Container(
              height: SConfig.sHeight * 0.075,
              width: SConfig.sWidth * 0.160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade100,
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Text(med["emoji"], style: const TextStyle(fontSize: 35)),
              ),
            ),
            title: Text(med["name"], style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(med["company"]),
                Text("₹${med["price"]}", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                if (med["prescription"])
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: Colors.amber[100], borderRadius: BorderRadius.circular(6)),
                    child: const Text("Prescription Required", style: TextStyle(fontSize: 10, color: Colors.orange)),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
