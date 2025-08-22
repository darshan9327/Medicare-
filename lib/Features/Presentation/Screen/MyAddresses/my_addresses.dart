import 'package:flutter/material.dart';

class MyAddressesScreen extends StatefulWidget {
  @override
  _MyAddressesScreenState createState() => _MyAddressesScreenState();
}

class _MyAddressesScreenState extends State<MyAddressesScreen> {
  List<Map<String, dynamic>> addresses = [
    {
      'id': '1',
      'type': 'Home',
      'icon': '🏠',
      'name': 'John Doe',
      'address': '123 Main Street, Apartment 4B\nAhmedabad, Gujarat 380001',
      'phone': '+91 98765 43210',
      'isDefault': true,
    },
    {
      'id': '2',
      'type': 'Office',
      'icon': '🏢',
      'name': 'John Doe',
      'address': '456 Business Park, Floor 7\nAhmedabad, Gujarat 380015',
      'phone': '+91 98765 43210',
      'isDefault': false,
    },
    {
      'id': '3',
      'type': 'Other',
      'icon': '📍',
      'name': 'Jane Doe',
      'address': '789 Residential Area\nAhmedabad, Gujarat 380009',
      'phone': '+91 87654 32109',
      'isDefault': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text('My Addresses'),
        backgroundColor: Color(0xff478ef8),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => _showAddAddressDialog(context),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${addresses.length} saved addresses', style: TextStyle(color: Color(0xFF6B7280))),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: addresses.length,
                itemBuilder: (context, index) {
                  final address = addresses[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black12)],
                      border: address['isDefault'] ? Border.all(color: Color(0xFF2563EB), width: 2) : null,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(address['icon'], style: TextStyle(fontSize: 20)),
                              SizedBox(width: 8),
                              Text(address['type'], style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2563EB))),
                              if (address['isDefault']) ...[
                                SizedBox(width: 8),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFDCFCE7),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text('Default', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF166534))),
                                ),
                              ],
                              Spacer(),
                              PopupMenuButton<String>(
                                onSelected: (String value) {
                                  if (value == 'edit') {
                                    _showEditAddressDialog(context, address);
                                  } else if (value == 'delete') {
                                    _deleteAddress(address['id']);
                                  } else if (value == 'default') {
                                    _setDefaultAddress(address['id']);
                                  }
                                },
                                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                  PopupMenuItem<String>(
                                    value: 'edit',
                                    child: Row(
                                      children: [
                                        Icon(Icons.edit, size: 18, color: Color(0xFF6B7280)),
                                        SizedBox(width: 8),
                                        Text('Edit'),
                                      ],
                                    ),
                                  ),
                                  if (!address['isDefault'])
                                    PopupMenuItem<String>(
                                      value: 'default',
                                      child: Row(
                                        children: [
                                          Icon(Icons.star, size: 18, color: Color(0xFF6B7280)),
                                          SizedBox(width: 8),
                                          Text('Set as Default'),
                                        ],
                                      ),
                                    ),
                                  PopupMenuItem<String>(
                                    value: 'delete',
                                    child: Row(
                                      children: [
                                        Icon(Icons.delete, size: 18, color: Colors.red),
                                        SizedBox(width: 8),
                                        Text('Delete', style: TextStyle(color: Colors.red)),
                                      ],
                                    ),
                                  ),
                                ],
                                child: Icon(Icons.more_vert, color: Color(0xFF6B7280)),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(address['name'], style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF111827))),
                          SizedBox(height: 5),
                          Text(address['address'], style: TextStyle(color: Color(0xFF6B7280), height: 1.4)),
                          SizedBox(height: 5),
                          Text(address['phone'], style: TextStyle(color: Color(0xFF6B7280))),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddAddressDialog(context),
        backgroundColor: Color(0xFF2563EB),
        label: Text('Add Address'),
        icon: Icon(Icons.add),
      ),
    );
  }

  void _showAddAddressDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 20,
          left: 20,
          right: 20,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Color(0xFFE5E7EB),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: 20),
              Text('Add New Address', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Address added successfully!')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2563EB),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text('Save Address', style: TextStyle(color: Colors.white)),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditAddressDialog(BuildContext context, Map<String, dynamic> address) {
    _showAddAddressDialog(context);
  }

  void _deleteAddress(String id) {
    setState(() {
      addresses.removeWhere((address) => address['id'] == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Address deleted successfully!')),
    );
  }

  void _setDefaultAddress(String id) {
    setState(() {
      for (var address in addresses) {
        address['isDefault'] = address['id'] == id;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Default address updated!')),
    );
  }
}