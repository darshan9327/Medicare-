import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:medicare/CommonScreens/common_container.dart';

import '../CommonScreens/size_config.dart';

class UploadPrescription extends StatefulWidget {
  const UploadPrescription({super.key});

  @override
  State<UploadPrescription> createState() =>
      _UploadPrescriptionState();
}

class _UploadPrescriptionState extends State<UploadPrescription> {
  String? uploadedFile;
  final TextEditingController notesController = TextEditingController();

  Future<void> pickFile(String type) async {
    if (type == "Camera") {
      final picked = await ImagePicker().pickImage(source: ImageSource.camera);
      if (picked != null) {
        setState(() => uploadedFile = picked.path);
      }
    } else if (type == "Gallery") {
      final picked =
      await ImagePicker().pickImage(source: ImageSource.gallery);
      if (picked != null) {
        setState(() => uploadedFile = picked.path);
      }
    } else if (type == "PDF") {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.single.path != null) {
        setState(() {
          uploadedFile = result.files.single.path!;
        });
      }
    }
  }

  void submit() {
    if (uploadedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please upload a prescription")),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Uploaded: $uploadedFile\nNotes: ${notesController.text}"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Upload Prescription", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xff478ef8),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "This medicine requires a valid prescription. Please upload a clear image of your prescription.",
                  style: TextStyle(color: Colors.black87),
                ),
              ),
              const SizedBox(height: 20),
              DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(12),
                color: Colors.grey,
                strokeWidth: 2,
                dashPattern: const [6, 3],
                child: Container(
                  width: SConfig.sWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade100,
                  ),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      SizedBox(height: SConfig.sHeight * 0.020),
                      Text("📄",style: TextStyle(fontSize: 40)),
                      SizedBox(height: SConfig.sHeight * 0.020),
                      const Text(
                        "Upload Prescription",
                        style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const Text("  Tap to upload from\ncamera, gallery or PDF",
                          style: TextStyle(color: Colors.black54)),
                      SizedBox(height: SConfig.sHeight * 0.020),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _fileButton("Camera", "📷"),
                          _fileButton("Gallery", "🖼️"),
                          _fileButton("PDF", "📄"),
                        ],
                      ),
                      if (uploadedFile != null) ...[
                        const SizedBox(height: 12),
                        Text(
                          "Uploaded: $uploadedFile",
                          style: const TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                      ]
                    ],
                  ),
                ),
              ),
              SizedBox(height: SConfig.sHeight * 0.030),
              TextField(
                controller: notesController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Notes (Optional)",
                  hintText: "Any additional instructions...",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              SizedBox(height: SConfig.sHeight * 0.030),
              CommonContainer(text: "Upload & Add to Cart", onPressed: (){
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget _fileButton(String label, String text) {
    return OutlinedButton(
      onPressed: () => pickFile(label),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.blue,width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text,style: TextStyle(fontSize: 22),),
          Text(label, style: const TextStyle(color: Colors.blue,fontSize: 15,fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
