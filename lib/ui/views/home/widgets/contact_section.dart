import 'package:flutter/material.dart';
import 'package:rsbweb_v1/ui/common/app_colors.dart';
import 'package:stacked/stacked.dart';
import 'package:google_fonts/google_fonts.dart';
import '../home_viewmodel.dart';

class ContactSection extends ViewModelWidget<HomeViewModel> {
  const ContactSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    double width = MediaQuery.of(context).size.width;
    // Set breakpoint for mobile/tablet vs desktop
    bool isMobile = width < 1024;

    return Container(
      key: viewModel.contactKey,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 60 : 100,
        horizontal: isMobile ? 20 : width * 0.1,
      ),
      color: const Color(0xFFF8FAFF), // Light professional background
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 40,
                offset: const Offset(0, 10),
              )
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(isMobile ? 30 : 60),
            child: Flex(
              direction: isMobile ? Axis.vertical : Axis.horizontal,
              // Keep content at the top for mobile, centered for desktop
              crossAxisAlignment: isMobile
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              children: [
                // LEFT SIDE: Content
                Expanded(
                  flex: isMobile ? 0 : 5,
                  child: _buildContactText(isMobile),
                ),

                if (!isMobile) const Spacer(flex: 1),

                // RIGHT SIDE: Form Card
                Expanded(
                  flex: isMobile ? 0 : 5,
                  child: _ContactForm(viewModel: viewModel, isMobile: isMobile),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactText(bool isMobile) {
    return Column(
      // Ensure left alignment for both Desktop and Mobile
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Ready to find your\nnext chapter?",
          textAlign: TextAlign.left,
          style: GoogleFonts.playfairDisplay(
            fontSize: isMobile ? 36 : 48,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1A1A1A),
            height: 1.2,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          "Visit our office:\n2nd Floor Rev. Alejandro Rulite Multipurpose Building,\n356 purok 3, Magsaysay Private Rd. Baguio City.",
          textAlign: TextAlign.left,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            color: Colors.black54,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 40),
        _benefitItem(
          icon: Icons.mail_outline_rounded,
          label: "rsbcorporation8@gmail.com",
        ),
        const SizedBox(height: 16),
        _benefitItem(
          icon: Icons.phone_android_rounded,
          label: "(+63) 975 595 3380",
        ),
        // Add spacing before the form only on mobile to prevent crowding
        if (isMobile) const SizedBox(height: 48),
      ],
    );
  }

  Widget _benefitItem({required IconData icon, required String label}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: apexBlue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 18, color: Colors.white),
        ),
        const SizedBox(width: 16),
        Flexible(
          child: Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1A1A1A),
            ),
          ),
        ),
      ],
    );
  }
}

class _ContactForm extends StatelessWidget {
  final HomeViewModel viewModel;
  final bool isMobile;
  const _ContactForm({required this.viewModel, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          _formField("Full Name", viewModel.nameController),
          const SizedBox(height: 16),
          _formField("Email Address", viewModel.emailController),
          const SizedBox(height: 16),
          _formField(
            "Tell us what you're looking for...",
            viewModel.messageController,
            maxLines: 4,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: viewModel.isBusy ? null : viewModel.submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: apexBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: viewModel.isBusy
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      "Send Inquiry",
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _formField(String hint, TextEditingController controller,
      {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.plusJakartaSans(
          color: Colors.black26,
          fontSize: 14,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.black.withOpacity(0.05)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: apexBlue, width: 1.5),
        ),
      ),
    );
  }
}
