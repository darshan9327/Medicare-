import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicare/CommonScreens/common_container.dart';
import 'package:medicare/CommonScreens/size_config.dart';

import '../DashboardScreen/dashboard.dart';
import '../MyOrders/my_orders.dart';

class SuccessOrder extends StatefulWidget {
  final String orderId;
  final double amount;
  final String paymentStatus;
  final String orderStatus;

  const SuccessOrder({super.key, required this.orderId, required this.amount, required this.paymentStatus, required this.orderStatus});

  @override
  State<SuccessOrder> createState() => _SuccessOrderState();
}

class _SuccessOrderState extends State<SuccessOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Confirmed", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xff478ef8),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("✅", style: TextStyle(fontSize: 70)),
                      const SizedBox(height: 20),
                
                      const Text("Order Placed\nSuccessfully!", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      const Text("Thank you for your order", style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 30),
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Order Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [const Text("Order ID:"), Text("#${widget.orderId}", style: const TextStyle(fontWeight: FontWeight.w600))],
                            ),
                            SizedBox(height: SConfig.sHeight * 0.010),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Total Amount:"),
                                Text("₹${widget.amount.toStringAsFixed(2)}", style: const TextStyle(fontWeight: FontWeight.w600)),
                              ],
                            ),
                            SizedBox(height: SConfig.sHeight * 0.010),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Payment:"),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: widget.paymentStatus == "Completed" ? Colors.green[100] : Colors.orange[100],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    widget.paymentStatus,
                                    style: TextStyle(color: widget.paymentStatus == "Completed" ? Colors.green : Colors.orange,),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: SConfig.sHeight * 0.010),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Status:"),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(color: Colors.blue[100], borderRadius: BorderRadius.circular(20)),
                                  child: Text(widget.orderStatus, style: const TextStyle(color: Colors.blue,)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: SConfig.sHeight * 0.030),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Colors.blue[50],
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xff478ef8),
                                  offset: Offset(-4, 0)
                              )
                            ],
                            borderRadius: BorderRadius.circular(12)),
                        child: Text("📱 We will contact you via WhatsApp/Email for delivery confirmation",
                            style: TextStyle(color: Colors.blue)
                        ),
                      ),
                      SizedBox(height: SConfig.sHeight * 0.035),
                      CommonContainer(text: "Track Order", onPressed: (){
                        Get.to(MyOrders());
                      }),
                      SizedBox(height: SConfig.sHeight * 0.030),
                      CommonContainer(
                          text: "Continue Shopping",
                          color: Colors.white,
                          color1: Color(0xff478ef8),
                          onPressed: (){
                            Get.offAll(DashboardScreen());
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
