import 'package:flutter/material.dart';
import '../../../Common/utils/size_config.dart';

class AddressTile extends StatelessWidget {
  final Map<String, String> address;
  final bool isSelected;
  final VoidCallback onSelect;
  final Function(Map<String, String>) onEdit;
  final VoidCallback onDelete;

  const AddressTile({
    super.key,
    required this.address,
    required this.isSelected,
    required this.onSelect,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        width: SConfig.sWidth,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade50 : Colors.transparent,
          border: Border.all(color: isSelected ? Colors.blue : Colors.grey.shade300, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("🏠 ${address["type"]}", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                const Spacer(),
                InkWell(
                  onTap: () async {
                    final updated = await _editDialog(context, address);
                    if (updated != null) onEdit(updated);
                  },
                  child: const Icon(Icons.edit, size: 20),
                ),
                SizedBox(width: SConfig.sWidth * 0.010),
                InkWell(onTap: onDelete, child: const Icon(Icons.delete_forever_outlined, size: 20)),
              ],
            ),
            Text(address["name"] ?? ""),
            Text(address["address"] ?? ""),
            Text(address["phone"] ?? ""),
          ],
        ),
      ),
    );
  }

  Future<Map<String, String>?> _editDialog(BuildContext context, Map<String, String> address) {
    final typeController = TextEditingController(text: address["type"]);
    final nameController = TextEditingController(text: address["name"]);
    final addressController = TextEditingController(text: address["address"]);
    final phoneController = TextEditingController(text: address["phone"]);

    return showDialog<Map<String, String>>(
      context: context,
      builder: (context) => AlertDialog(
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
            onPressed: () => Navigator.pop(context, {
              "type": typeController.text,
              "name": nameController.text,
              "address": addressController.text,
              "phone": phoneController.text,
            }),
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}
