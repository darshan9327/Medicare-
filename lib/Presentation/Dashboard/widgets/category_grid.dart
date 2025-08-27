import 'package:flutter/material.dart';

final List<Map<String, dynamic>> categories = [
  {"name": "Tablets", "emoji": "💊"},
  {"name": "Syrups", "emoji": "🧴"},
  {"name": "Injections", "emoji": "💉"},
  {"name": "First Aid", "emoji": "🩹"},
];

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount;
    if (screenWidth > 1200) {
      crossAxisCount = 6; // Desktop / Laptop large screen
    } else if (screenWidth > 800) {
      crossAxisCount = 4; // Tablet / small laptop
    } else {
      crossAxisCount = 2; // Mobile
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 15,
        crossAxisSpacing: 25,
        childAspectRatio: 1, // square tiles
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final item = categories[index];
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 6,
                spreadRadius: 2,
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(item["emoji"], style: const TextStyle(fontSize: 40)),
              const SizedBox(height: 8),
              Text(
                item["name"],
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        );
      },
    );
  }
}
