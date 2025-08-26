import 'package:flutter/material.dart';

import '../widgets/category_grid.dart';
import '../widgets/medicine_list.dart';
import '../widgets/search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(height: 12),
                SearchBarWidget(),
                SizedBox(height: 20),
                CategoryGrid(),
                SizedBox(height: 20),
                Text("Popular Medicines", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                SizedBox(height: 12),
                MedicineList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
