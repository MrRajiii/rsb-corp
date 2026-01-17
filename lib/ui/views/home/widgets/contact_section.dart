import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../common/app_colors.dart';
import '../home_viewmodel.dart';

class ContactSection extends ViewModelWidget<HomeViewModel> {
  const ContactSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    double width = MediaQuery.of(context).size.width;
    bool isMobile = width < 900;

    return Container(
      key: viewModel.contactKey,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 60 : 120,
        horizontal: isMobile ? 20 : width * 0.1,
      ),
      color: const Color(0xFFF8FAFC),
      child: Flex(
        direction: isMobile ? Axis.vertical : Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Side: Text and Info Tiles
          Expanded(
            flex: isMobile ? 0 : 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Let's build your\ndream project\ntogether.",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: isMobile ? 36 : 52,
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                    color: const Color(0xFF1D212B),
                  ),
                ),
                const SizedBox(height: 48),
                _infoTile(
                    Icons.phone_outlined, "Call Us", "(+63) 975 595 3380"),
                const SizedBox(height: 10),
                _infoTile(
                    Icons.mail_outline, "Email", "rsbcorporation8@gmail.com"),
                const SizedBox(height: 10),
                // Location Info - Now handles long addresses safely
                _infoTile(
                  Icons.location_on_outlined,
                  "Visit Us",
                  "2nd Floor Rev. Alejandro Rulite Multipurpose Building, 356 purok 3, Magsaysay Private Rd. Baguio City.",
                ),
              ],
            ),
          ),

          if (isMobile) const SizedBox(height: 60),

          // Right Side: The Form
          Expanded(
            flex: isMobile ? 0 : 1,
            child: _ContactForm(viewModel: viewModel, isMobile: isMobile),
          ),
        ],
      ),
    );
  }

  Widget _infoTile(IconData icon, String title, String sub) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start, // Icon stays at the top
        children: [
          Container(
            height: 54,
            width: 54,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: apexBlue, size: 24),
          ),
          const SizedBox(width: 20),
          // FIX: Expanded allows the text column to take up remaining width and wrap
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.black45,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    sub,
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: const Color(0xFF1D212B),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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
      padding: const EdgeInsets.fromLTRB(30, 40, 30, 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 50,
            offset: const Offset(0, 20),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _formField("NAME", viewModel.nameController),
          const SizedBox(height: 35),
          _formField("EMAIL", viewModel.emailController),
          const SizedBox(height: 35),
          _formField("MESSAGE", viewModel.messageController, maxLines: 3),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            height: 65,
            child: ElevatedButton(
              onPressed: viewModel.isBusy ? null : viewModel.submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: apexBlue,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
              child: viewModel.isBusy
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2),
                    )
                  : const Text(
                      "Send Proposal",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
            ),
          )
        ],
      ),
    );
  }

  Widget _formField(String label, TextEditingController controller,
      {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Colors.black54,
            letterSpacing: 1.0,
          ),
        ),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black12, width: 1.5)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: apexBlue, width: 2)),
          ),
        ),
      ],
    );
  }
}
