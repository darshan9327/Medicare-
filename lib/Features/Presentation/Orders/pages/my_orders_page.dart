import 'package:flutter/material.dart';

class Order {
  final String id;
  final String date;
  final String status;
  final int itemCount;
  final String price;
  final String products;

  Order({required this.id, required this.date, required this.status, required this.itemCount, required this.price, required this.products});
}

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    final List<Order> orders = [
      Order(
        id: "#ORD001234",
        date: "Mar 15, 2024",
        status: "Processing",
        itemCount: 2,
        price: "₹201.85",
        products: "Paracetamol 500mg, Crocin Syrup",
      ),
      Order(id: "#ORD001233", date: "Mar 10, 2024", status: "Completed", itemCount: 1, price: "₹125.00", products: "Band-Aid Pack"),
      Order(
        id: "#ORD001232",
        date: "Mar 5, 2024",
        status: "Pending",
        itemCount: 3,
        price: "₹399.00",
        products: "Vitamin-C Tablets, Dettol, Thermometer",
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Orders", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xff478ef8),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              const Text("Your order history", style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    return _buildOrderCard(orders[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderCard(Order order) {
    Color statusColor;
    switch (order.status) {
      case "Processing":
        statusColor = Colors.blue;
        break;
      case "Pending":
        statusColor = Colors.orange;
        break;
      case "Completed":
        statusColor = Colors.green;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 8)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(order.id, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                  child: Text(order.status, style: TextStyle(color: statusColor, fontWeight: FontWeight.w500, fontSize: 12)),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(order.status == "Completed" ? "Delivered on ${order.date}" : "Placed on ${order.date}", style: const TextStyle(color: Colors.grey)),

            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${order.itemCount} items", style: const TextStyle(fontWeight: FontWeight.w500)),
                Text(order.price, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
            const SizedBox(height: 5),
            Text(order.products, style: const TextStyle(color: Colors.black87)),

            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _actionButton("View Details", Colors.blue, isOutlined: true)),
                if (order.status == "Completed") const SizedBox(width: 10),
                if (order.status == "Completed") Expanded(child: _actionButton("Reorder", Colors.blue, isOutlined: true)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionButton(String text, Color color, {bool isOutlined = false}) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: isOutlined ? color : Colors.white,
        backgroundColor: isOutlined ? Colors.white : color,
        side: BorderSide(color: color, width: 1.5),
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () {
        debugPrint("$text clicked");
      },
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
