import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  final List<Map<String, dynamic>> faqItems = [
    {
      'question': 'How to upload a prescription?',
      'answer': 'Go to any prescription medicine and tap "Upload Prescription". You can upload from camera, gallery, or PDF file.',
    },
    {
      'question': 'What is the delivery time?',
      'answer': 'Standard delivery takes 2-4 hours. Express delivery is available in 30-60 minutes for urgent orders.',
    },
    {
      'question': 'How to cancel an order?',
      'answer': 'You can cancel your order within 10 minutes of placing it from the "My Orders" section.',
    },
    {
      'question': 'What payment methods are accepted?',
      'answer': 'We accept UPI, Credit/Debit Cards, Net Banking, and Cash on Delivery.',
    },
    {
      'question': 'How to track my order?',
      'answer': 'You can track your order in real-time from the "My Orders" section or through the tracking link sent via SMS.',
    },
  ];

  HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text('Help & Support'),
        backgroundColor: Color(0xff478ef8),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black12)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Quick Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF111827))),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: _buildQuickAction(
                          context,
                          '💬',
                          'Live Chat',
                          'Chat with our support team',
                              () => _startLiveChat(context),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: _buildQuickAction(
                          context,
                          '📞',
                          'Call Us',
                          '24/7 helpline available',
                              () => _makePhoneCall(context),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: _buildQuickAction(
                          context,
                          '📧',
                          'Email Us',
                          'Send us your query',
                              () => _sendEmail(context),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: _buildQuickAction(
                          context,
                          '🎥',
                          'Video Call',
                          'Video consultation',
                              () => _startVideoCall(context),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Text('Frequently Asked Questions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF111827))),
            SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black12)],
              ),
              child: Column(
                children: faqItems.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, dynamic> faq = entry.value;
                  bool isLast = index == faqItems.length - 1;

                  return ExpansionTile(
                    title: Text(faq['question'], style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF111827))),
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Text(faq['answer'], style: TextStyle(color: Color(0xFF6B7280), height: 1.5)),
                      ),
                    ],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: index == 0 ? Radius.circular(15) : Radius.zero,
                        bottom: isLast ? Radius.circular(15) : Radius.zero,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black12)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Contact Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF111827))),
                  SizedBox(height: 15),
                  _buildContactInfo('📞', 'Customer Care', '+91 1800-123-4567'),
                  _buildContactInfo('📧', 'Email Support', 'support@medicareplus.com'),
                  _buildContactInfo('💬', 'WhatsApp', '+91 98765-43210'),
                  _buildContactInfo('🕒', 'Support Hours', '24/7 Available'),
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black12)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('App Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF111827))),
                  SizedBox(height: 15),
                  _buildInfoRow('Version', 'v2.1.0'),
                  _buildInfoRow('Last Updated', '15 Mar 2024'),
                  _buildInfoRow('Privacy Policy', 'View Policy', isLink: true),
                  _buildInfoRow('Terms of Service', 'View Terms', isLink: true),
                  _buildInfoRow('Rate This App', '⭐⭐⭐⭐⭐', isLink: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAction(BuildContext context, String emoji, String title, String subtitle, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xFFE5E7EB)),
        ),
        child: Column(
          children: [
            Text(emoji, style: TextStyle(fontSize: 24)),
            SizedBox(height: 8),
            Text(title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            SizedBox(height: 4),
            Text(subtitle, style: TextStyle(color: Color(0xFF6B7280), fontSize: 10), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfo(String icon, String title, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(child: Text(icon, style: TextStyle(fontSize: 18))),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF111827))),
                Text(value, style: TextStyle(color: Color(0xFF6B7280))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String value, {bool isLink = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: Color(0xFF6B7280))),
          Text(
            value,
            style: TextStyle(
              color: isLink ? Color(0xFF2563EB) : Color(0xFF111827),
              fontWeight: FontWeight.w600,
              decoration: isLink ? TextDecoration.underline : null,
            ),
          ),
        ],
      ),
    );
  }

  void _startLiveChat(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => LiveChatScreen()));
  }

  void _makePhoneCall(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Calling +91 1800-123-4567...')),
    );
  }

  void _sendEmail(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening email app...')),
    );
  }

  void _startVideoCall(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Starting video consultation...')),
    );
  }
}




class LiveChatScreen extends StatefulWidget {
  const LiveChatScreen({super.key});

  @override
  State<LiveChatScreen> createState() => _LiveChatScreenState();
}

class _LiveChatScreenState extends State<LiveChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Map<String, dynamic>> messages = [
    {
      'message': 'Hello! I\'m here to help you with your queries. How can I assist you today?',
      'isUser': false,
      'time': '10:30 AM',
      'senderName': 'Dr. Pharmacist',
    },
    {
      'message': 'Hi, I want to know about the side effects of Paracetamol.',
      'isUser': true,
      'time': '10:32 AM',
    },
    {
      'message': 'Paracetamol is generally safe when taken as directed. Common side effects are rare but may include nausea or skin rash. Please consult your doctor if you experience any unusual symptoms.',
      'isUser': false,
      'time': '10:33 AM',
      'senderName': 'Dr. Pharmacist',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: Color(0xFF10B981),
              child: Icon(Icons.person, color: Colors.white, size: 18),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Dr. Pharmacist', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                Text('Online', style: TextStyle(fontSize: 12, color: Colors.white70)),
              ],
            ),
          ],
        ),
        backgroundColor: Color(0xFF2563EB),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.videocam)),
          IconButton(onPressed: () {}, icon: Icon(Icons.call)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(20),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return _buildMessageBubble(message);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black12, offset: Offset(0, -2))],
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => _showAttachmentOptions(context),
                  icon: Icon(Icons.attach_file, color: Color(0xFF6B7280)),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Color(0xFFE5E7EB)),
                    ),
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        border: InputBorder.none,
                      ),
                      onSubmitted: (value) => _sendMessage(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF2563EB),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: _sendMessage,
                    icon: Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message) {
    bool isUser = message['isUser'];
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: Color(0xFF10B981),
              child: Icon(Icons.support_agent, color: Colors.white, size: 16),
            ),
            SizedBox(width: 10),
          ],
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              decoration: BoxDecoration(
                color: isUser ? Color(0xFF2563EB) : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: isUser ? Radius.circular(15) : Radius.circular(5),
                  bottomRight: isUser ? Radius.circular(5) : Radius.circular(15),
                ),
                boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black12)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isUser && message.containsKey('senderName'))
                    Text(
                      message['senderName'],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2563EB),
                      ),
                    ),
                  if (!isUser && message.containsKey('senderName')) SizedBox(height: 4),
                  Text(
                    message['message'],
                    style: TextStyle(
                      color: isUser ? Colors.white : Color(0xFF111827),
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    message['time'],
                    style: TextStyle(
                      fontSize: 12,
                      color: isUser ? Colors.white70 : Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isUser) ...[
            SizedBox(width: 10),
            CircleAvatar(
              radius: 16,
              backgroundColor: Color(0xFF2563EB),
              child: Text('J', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        messages.add({
          'message': _messageController.text.trim(),
          'isUser': true,
          'time': '${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}',
        });
      });
      _messageController.clear();

      // Scroll to bottom
      Future.delayed(Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          messages.add({
            'message': 'Thank you for your message. Our pharmacist will respond shortly with detailed information.',
            'isUser': false,
            'time': '${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}',
            'senderName': 'Dr. Pharmacist',
          });
        });
      });
    }
  }

  void _showAttachmentOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Send Attachment', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildAttachmentOption('📷', 'Camera', () {}),
                _buildAttachmentOption('🖼️', 'Gallery', () {}),
                _buildAttachmentOption('📄', 'Document', () {}),
                _buildAttachmentOption('📋', 'Prescription', () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttachmentOption(String emoji, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(child: Text(emoji, style: TextStyle(fontSize: 24))),
          ),
          SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}