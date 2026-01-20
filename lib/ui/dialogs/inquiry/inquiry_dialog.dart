import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked_services/stacked_services.dart';

class InquiryDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const InquiryDialog(
      {Key? key, required this.request, required this.completer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Controllers to grab the text
    final nameController = TextEditingController();
    final contactController = TextEditingController();
    final messageController = TextEditingController();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(24),
        width: 400, // Fixed width for desktop/web look
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Inquire: ${request.data}", // Shows "2-Storey" or "Bungalow"
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text(
                "Please provide your details so we can reach out to you.",
                style: TextStyle(color: Color(0xFF64748B), fontSize: 14)),
            const SizedBox(height: 20),
            _buildField("Full Name", nameController, Icons.person_outline),
            const SizedBox(height: 16),
            _buildField("Contact Number / Email", contactController,
                Icons.contact_mail_outlined),
            const SizedBox(height: 16),
            _buildField(
                "Message (Optional)", messageController, Icons.chat_outlined,
                maxLines: 3),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => completer(DialogResponse(
                  confirmed: true,
                  data: {
                    'name': nameController.text,
                    'contact': contactController.text,
                    'message': messageController.text,
                  },
                )),
                child: const Text("Submit Inquiry",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(
      String hint, TextEditingController controller, IconData icon,
      {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, size: 20),
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF8FAFC),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
      ),
    );
  }
}
