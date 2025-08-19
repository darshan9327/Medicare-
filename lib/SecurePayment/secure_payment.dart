import 'package:flutter/material.dart';

import '../CommonScreens/size_config.dart';
import '../SuccessOrder/success_order.dart';

class SecurePayment extends StatefulWidget {
  final double totalAmount;
  const SecurePayment({super.key, required this.totalAmount});

  @override
  State<SecurePayment> createState() => _SecurePaymentState();
}

class _SecurePaymentState extends State<SecurePayment> {
  @override
  void initState() {
    super.initState();

    // Wait 2 seconds then redirect with values
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (_) => SuccessOrder(
                orderId: "ORD${DateTime.now().millisecondsSinceEpoch}",
                amount: widget.totalAmount,
                paymentStatus: "Completed",
                orderStatus: "Order Placed",
              ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xff478ef8),
      ),
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.credit_card, size: 80, color: Colors.blueAccent),
              SizedBox(height: SConfig.sHeight * 0.050),
              const Text("Secure Payment", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: SConfig.sHeight * 0.020),
              const Text("You will be redirected to your\nselected payment method",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: SConfig.sHeight * 0.070),
              Text("₹${widget.totalAmount.toStringAsFixed(2)}", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              const Text("Order Total", style: TextStyle(color: Colors.grey)),
              SizedBox(height: SConfig.sHeight * 0.060),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.autorenew, color: Colors.blue),
                  SizedBox(width: 8),
                  Text("Processing payment...", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600)),
                ],
              ),
              SizedBox(height: SConfig.sHeight * 0.040),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: const [
                    Icon(Icons.lock, color: Colors.green),
                    SizedBox(width: 8),
                    Expanded(child: Text("Your payment is secured with 256-bit SSL encryption", style: TextStyle(color: Colors.green))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
