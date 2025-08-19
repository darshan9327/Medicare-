import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../ProductDetails/product_details.dart';

class Medicine {
  final String name;
  final String company;
  final double price;
  final bool prescriptionRequired;
  final String emoji;
  final String description;

  Medicine({
    required this.name,
    required this.company,
    required this.price,
    required this.prescriptionRequired,
    required this.emoji,
    required this.description,
  });
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<Medicine> medicines = [
    Medicine(
        name: "Paracetamol 500mg",
        company: "Cipla Ltd.",
        price: 45.00,
        emoji: '💊',
        description: 'Used for fever and mild pain relief',
        prescriptionRequired: false,
    ),
    Medicine(
        name: "Dolo 650mg",
        company: "Micro Labs",
        price: 32.50,
        emoji: '💊',
        description: 'Stronger dose for fever and pain.',
        prescriptionRequired: true),
    Medicine(
        name: "Calpol 500mg",
        company: "GSK",
        price: 28.00,
        emoji: '💊',
        description: 'Calpol 650mg is used to relieve fever, headache,'
            ' and mild to moderate pain such as body pain, toothache, and menstrual cramps.',
        prescriptionRequired: false),
    Medicine(
        name: "Azithromycin 250mg",
        company: "Sun Pharma",
        price: 120.00,
        emoji: '💊',
        description: 'Azithromycin 250mg is an antibiotic used to treat '
            'various bacterial infections such as respiratory infections',
        prescriptionRequired: true),
  ];

  String searchQuery = "";
  String filter = "All";

  @override
  Widget build(BuildContext context) {
    List<Medicine> filteredList = medicines.where((med) {
      final matchesSearch = med.name.toLowerCase().contains(searchQuery.toLowerCase());

      final matchesFilter = filter == "All"
          ? true
          : filter == "OTC"
          ? !med.prescriptionRequired
          : med.prescriptionRequired;

      return matchesSearch && matchesFilter;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.blue),
                hintText: "Search medicine...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                filterButton("All"),
                const SizedBox(width: 8),
                filterButton("OTC"),
                const SizedBox(width: 8),
                filterButton("Prescription"),
              ],
            ),

            const SizedBox(height: 12),
            Text("${filteredList.length} results found",
                style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final med = filteredList[index];
                  return InkWell(
                    onTap: () {
                      Get.to(() => ProductDetailScreen(
                        product: Product1(
                          name: med.name,
                          company: med.company,
                          price: med.price,
                          description: med.description,
                          image: med.emoji,
                          prescriptionRequired: med.prescriptionRequired,
                        ),
                      ));
                    },
                    child: Card(
                      shadowColor: Colors.grey.shade500,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.shade200,
                          ),
                            child: Padding(
                              padding: const EdgeInsets.all(7),
                              child: Text("💊",style: TextStyle(fontSize: 30),),
                            )),
                        title: Text(
                          med.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(med.company),
                            Text(
                              "₹${med.price.toStringAsFixed(2)}",
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            if (med.prescriptionRequired)
                              Container(
                                margin: const EdgeInsets.only(top: 5),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.amber.shade100,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  "Prescription Required",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.orange),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Custom filter button
  Widget filterButton(String label) {
    bool isSelected = filter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          filter = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade50 : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade400,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.blue : Colors.black54,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

