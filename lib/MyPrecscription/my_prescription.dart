import 'package:flutter/material.dart';

class MyPrescriptionsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> prescriptions = [
    {
      'id': '1',
      'doctorName': 'Dr. Rajesh Kumar',
      'date': '15 Mar 2024',
      'medicines': ['Paracetamol 500mg', 'Crocin Syrup'],
      'status': 'Approved',
      'validUntil': '15 Jun 2024',
      'image': '📋',
    },
    {
      'id': '2',
      'doctorName': 'Dr. Priya Sharma',
      'date': '10 Mar 2024',
      'medicines': ['Vitamin D3', 'Calcium Tablets'],
      'status': 'Expired',
      'validUntil': '10 Mar 2024',
      'image': '📋',
    },
    {
      'id': '3',
      'doctorName': 'Dr. Amit Patel',
      'date': '05 Mar 2024',
      'medicines': ['Omega 3', 'Iron Tablets'],
      'status': 'Under Review',
      'validUntil': '05 Jun 2024',
      'image': '📋',
    },
  ];
  MyPrescriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text('My Prescriptions'),
        backgroundColor: Color(0xff478ef8),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => _showUploadPrescriptionDialog(context),
            icon: Icon(Icons.upload_file),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Color(0xFF2563EB).withOpacity(0.3)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.description, color: Color(0xFF2563EB), size: 24),
                        SizedBox(height: 5),
                        Text('${prescriptions.length}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2563EB))),
                        Text('Total', style: TextStyle(color: Color(0xFF6B7280), fontSize: 12)),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Color(0xFFDCFCE7),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Color(0xFF16A34A).withOpacity(0.3)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.check_circle, color: Color(0xFF16A34A), size: 24),
                        SizedBox(height: 5),
                        Text('1', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF16A34A))),
                        Text('Active', style: TextStyle(color: Color(0xFF6B7280), fontSize: 12)),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Color(0xFFD97706).withOpacity(0.3)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.schedule, color: Color(0xFFD97706), size: 24),
                        SizedBox(height: 5),
                        Text('1', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFD97706))),
                        Text('Pending', style: TextStyle(color: Color(0xFF6B7280), fontSize: 12)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text('Recent Prescriptions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF111827))),
            SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: prescriptions.length,
                itemBuilder: (context, index) {
                  final prescription = prescriptions[index];
                  Color statusColor = prescription['status'] == 'Approved' ? Color(0xFF16A34A) :
                  prescription['status'] == 'Under Review' ? Color(0xFFD97706) : Color(0xFFEF4444);
                  Color bgColor = prescription['status'] == 'Approved' ? Color(0xFFDCFCE7) :
                  prescription['status'] == 'Under Review' ? Color(0xFFFEF3C7) : Color(0xFFFEE2E2);

                  return Container(
                    margin: EdgeInsets.only(bottom: 15),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black12)],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color(0xFFF3F4F6),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(child: Text(prescription['image'], style: TextStyle(fontSize: 24))),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(prescription['doctorName'], style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF111827))),
                                  SizedBox(height: 2),
                                  Text(prescription['date'], style: TextStyle(color: Color(0xFF6B7280), fontSize: 14)),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: bgColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(prescription['status'], style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: statusColor)),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Text('Medicines:', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF111827))),
                        SizedBox(height: 5),
                        Text(prescription['medicines'].join(', '), style: TextStyle(color: Color(0xFF6B7280))),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.schedule, size: 16, color: Color(0xFF6B7280)),
                            SizedBox(width: 5),
                            Text('Valid until: ${prescription['validUntil']}', style: TextStyle(color: Color(0xFF6B7280), fontSize: 12)),
                            Spacer(),
                            TextButton(
                              onPressed: () {},
                              child: Text('View Details', style: TextStyle(color: Color(0xFF2563EB))),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showUploadPrescriptionDialog(context),
        backgroundColor: Color(0xFF2563EB),
        label: Text('Upload Prescription'),
        icon: Icon(Icons.upload_file),
      ),
    );
  }

  void _showUploadPrescriptionDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) =>
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5E7EB),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Upload Prescription',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 20),

                // Upload options row
                Row(
                  children: [
                    // Camera
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Camera opened')),
                          );
                        },
                        child: _optionBox(Icons.camera_alt, "Camera"),
                      ),
                    ),
                    const SizedBox(width: 15),

                    // Gallery
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Gallery opened')),
                          );
                        },
                        child: _optionBox(Icons.photo_library, "Gallery"),
                      ),
                    ),
                    const SizedBox(width: 15),

                    // PDF
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('File picker opened')),
                          );
                        },
                        child: _optionBox(Icons.insert_drive_file, "PDF"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }
  Widget _optionBox(IconData icon, String label) {
    return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: const Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(12)
        )
    );
  }
}