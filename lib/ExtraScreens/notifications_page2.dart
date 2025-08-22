import 'package:flutter/material.dart';

class NotificationModel {
  final String title;
  final String message;
  final String time;

  NotificationModel({required this.title, required this.message, required this.time});
}

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({super.key});

  final List<NotificationModel> notifications = [
    NotificationModel(
      title: "🎉 Order Delivered Successfully",
      message: "Your order #ORD001233 has been delivered. Thank you for choosing MediCare+!",
      time: "2 hours ago",
    ),
    NotificationModel(
      title: "💳 Payment Successful",
      message: "Your payment of ₹201.85 for order #ORD001234 has been processed successfully.",
      time: "1 day ago",
    ),
    NotificationModel(
      title: "📋 Prescription Approved",
      message: "Your prescription for Crocin Syrup has been verified and approved by our pharmacist.",
      time: "2 days ago",
    ),
    NotificationModel(
      title: "🚚 Order Processing",
      message: "Your order #ORD001235 is being processed. We’ll notify you once it’s shipped.",
      time: "3 days ago",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text("Notifications", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xff478ef8),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notify = notifications[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.blue, offset: Offset(-5, 0))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notify.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(notify.message, style: const TextStyle(color: Colors.black54)),
                const SizedBox(height: 8),
                Text(notify.time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          );
        },
      ),
    );
  }
}
