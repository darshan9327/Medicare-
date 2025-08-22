import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Features/Presentation/Common/utils/size_config.dart';
import '../Features/Presentation/Common/widgets/common_container.dart';
import '../Features/Presentation/Orders/pages/checkout_page.dart';
import '../Features/Presentation/Cart/controllers/cart_controller.dart';

class ShoppingCart2 extends StatefulWidget {
  final bool? showOwnAppBar;
  const ShoppingCart2({super.key, this.showOwnAppBar});

  @override
  State<ShoppingCart2> createState() => _ShoppingCart2State();
}

class _ShoppingCart2State extends State<ShoppingCart2> {
  final cartController = Get.put(CartController());

  final double deliveryFee = 25.0;

  final double taxPercent = 0.115;

  double get subtotal => cartController.cartItems.fold(0, (sum, item) => sum + item.totalPrice);

  double get tax => subtotal * taxPercent;

  double get total => subtotal + deliveryFee + tax;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          widget.showOwnAppBar == true
              ? AppBar(title: const Text("Shopping Cart", style: TextStyle(color: Colors.white)), backgroundColor: const Color(0xff478ef8))
              : null,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${cartController.cartItems.length} items in cart", style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: cartController.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartController.cartItems[index];
                      return Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(item.image, style: const TextStyle(fontSize: 32)),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                        Text(item.company, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                                        Text(
                                          "₹${item.price.toStringAsFixed(2)}",
                                          style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                                        ),
                                        if (item.requiresPrescription)
                                          Container(
                                            margin: const EdgeInsets.only(top: 6),
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(color: Colors.orange[100], borderRadius: BorderRadius.circular(6)),
                                            child: const Text("📄 Prescription Uploaded", style: TextStyle(fontSize: 10, color: Colors.orange)),
                                          ),
                                      ],
                                    ),
                                  ),
                                  InkWell(onTap: () => cartController.removeFromCart(item), child: const Icon(Icons.delete_forever_outlined)),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () => cartController.decreaseQuantity(item),
                                    icon: Container(
                                      height: SConfig.sHeight * 0.030,
                                      width: SConfig.sWidth * 0.065,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.grey.shade300),
                                      child: const Icon(Icons.remove, size: 18),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text("${item.quantity}", style: const TextStyle(fontSize: 16)),
                                  ),
                                  IconButton(
                                    onPressed: () => cartController.increaseQuantity(item),
                                    icon: Container(
                                      height: SConfig.sHeight * 0.030,
                                      width: SConfig.sWidth * 0.065,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.grey.shade300),
                                      child: const Icon(Icons.add, size: 18),
                                    ),
                                  ),
                                  const Spacer(),
                                  Text("₹${item.totalPrice.toStringAsFixed(2)}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        summaryRow("Subtotal", subtotal),
                        summaryRow("Delivery Fee", deliveryFee),
                        summaryRow("Tax", tax),
                        const Divider(),
                        summaryRow("Total", total, bold: true),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: SConfig.sHeight * 0.030),
                CommonContainer(
                  text: "Proceed to Checkout",
                  onPressed: () {
                    Get.to(CheckoutScreen(totalAmount: total));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget summaryRow(String label, double value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
          Text("₹${value.toStringAsFixed(2)}", style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
