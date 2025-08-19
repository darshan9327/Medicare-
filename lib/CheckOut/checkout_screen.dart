import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicare/CommonScreens/common_container.dart';
import 'package:medicare/CommonScreens/common_text_form_field.dart';
import 'package:medicare/CommonScreens/size_config.dart';
import 'package:medicare/SecurePayment/secure_payment.dart';

class CheckoutScreen extends StatefulWidget {
  final double totalAmount;
  const CheckoutScreen({super.key, required this.totalAmount});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  List<Map<String, String>> addresses = [
    {"type": "Home",
      "name": "John Doe",
      "address": "123 Main Street, Apartment 4B Ahmedabad, Gujarat 380001",
      "phone": "+91 98765 43210"
    },
  ];

  double? finalAmount;

  @override
  void initState() {
    super.initState();
    finalAmount = widget.totalAmount; // initialize with original amount
  }

  int selectedAddressIndex = 0;

  List<Map<String, String>> paymentMethods = [
    {"name": "UPI", "emoji": "💳"},
    {"name": "Card", "emoji": "💰"},
    {"name": "Net Banking", "emoji": "🏦"},
    {"name": "COD", "emoji": "💵"},
  ];

  int selectedPaymentIndex = 0;

  final TextEditingController couponController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xff478ef8),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Delivery Address", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
              const SizedBox(height: 10),
              ...List.generate(addresses.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedAddressIndex = index;
                    });
                  },
                  child: Container(
                    width: SConfig.sWidth,
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: selectedAddressIndex == index ? Colors.blue.shade50 : Colors.transparent,
                      border: Border.all(color: selectedAddressIndex == index ? Colors.blue : Colors.grey.shade300, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("🏠 ${addresses[index]["type"]}", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                            Spacer(),
                            InkWell(
                              onTap: () async {
                                final updatedAddress = await showDialog<Map<String, String>>(
                                  context: context,
                                  builder: (context) {
                                    final typeController = TextEditingController(text: addresses[index]["type"] ?? "");
                                    final nameController = TextEditingController(text: addresses[index]["name"] ?? "");
                                    final addressController = TextEditingController(text: addresses[index]["address"] ?? "");
                                    final phoneController = TextEditingController(text: addresses[index]["phone"] ?? "");

                                    return AlertDialog(
                                      title: const Text("Edit Address"),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            TextField(controller: typeController, decoration: const InputDecoration(labelText: "Type")),
                                            TextField(controller: nameController, decoration: const InputDecoration(labelText: "Name")),
                                            TextField(controller: addressController, decoration: const InputDecoration(labelText: "Address")),
                                            TextField(controller: phoneController, decoration: const InputDecoration(labelText: "Phone")),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context, {
                                              "type": typeController.text,
                                              "name": nameController.text,
                                              "address": addressController.text,
                                              "phone": phoneController.text,
                                            });
                                          },
                                          child: const Text("Save"),
                                        ),
                                      ],
                                    );
                                  },
                                );

                                if (updatedAddress != null) {
                                  setState(() {
                                    addresses[index] = updatedAddress;
                                  });
                                }
                              },
                              child: const Icon(Icons.edit, size: 20),
                            ),
                            SizedBox(width: SConfig.sWidth * 0.010),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  addresses.removeAt(index);
                                });
                              },
                              child: Icon(Icons.delete_forever_outlined, size: 20),
                            ),
                          ],
                        ),
                        Text(addresses[index]["name"]!),
                        Text(addresses[index]["address"]!),
                        Text(addresses[index]["phone"]!),
                      ],
                    ),
                  ),
                );
              }),
              CommonContainer(
                text: "Add New Address",
                color: Colors.white,
                color1: Colors.blue,
                onPressed: () {
                  setState(() {
                    addresses.add({"type": "New", "name": "New User", "address": "New Flat, New City", "phone": "+91 99999 88888"});
                  });
                },
              ),
              const SizedBox(height: 20),
              const Text("Payment Method", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
              const SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: paymentMethods.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.9,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedPaymentIndex = index;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedPaymentIndex == index ? Colors.blue.shade50 : Colors.transparent,
                        border: Border.all(
                          color: selectedPaymentIndex == index ? Colors.blue : Colors.grey.shade300,
                          width: selectedPaymentIndex == index ? 2 : 1.5,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(paymentMethods[index]["emoji"]!, style: const TextStyle(fontSize: 22)),
                          const SizedBox(width: 8),
                          Text(paymentMethods[index]["name"]!, style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              const Text("Apply Coupon", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
              const SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(
                    width: SConfig.sWidth * 0.700,
                    child: CommonTextFormField(
                      controller: couponController,
                      hintText: "Enter coupon code",
                    )
                  ),
                  const SizedBox(width: 10),
                  CommonContainer(
                    text: "Apply",
                    color: Colors.white,
                    color1: Colors.blue,
                    onPressed: () {
                      if (couponController.text == "DISCOUNT10") {
                        setState(() {
                          finalAmount = widget.totalAmount - 20;
                        });
                      }
                    },
                  )
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    Text("Total Amount  ₹${finalAmount!.toStringAsFixed(2)}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: SConfig.sHeight * 0.040),
                    CommonContainer(text: "Place Order", onPressed: (){
                      Get.offAll(SecurePayment(totalAmount: finalAmount!));
                    })
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
