import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../common/app_colors.dart';
import '../home_viewmodel.dart';

class HeroSection extends ViewModelWidget<HomeViewModel> {
  const HeroSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    double width = MediaQuery.of(context).size.width;
    bool isMobile = width < 1024;

    return Container(
      width: width,
      decoration: BoxDecoration(
        // Modern slate-to-light gradient background
        image: DecorationImage(
          image: const AssetImage('assets/images/hero_bg.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5),
            BlendMode.darken,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : width * 0.08,
        vertical: isMobile ? 60 : 100,
      ),
      child: Flex(
        direction: isMobile ? Axis.vertical : Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left Side: Bold Typography
          Expanded(
            flex: isMobile ? 0 : 6,
            child: Column(
              crossAxisAlignment: isMobile
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                _buildBadge(),
                const SizedBox(height: 24),
                Text(
                  "Find Your\nMasterpiece\nDwelling.",
                  textAlign: isMobile ? TextAlign.center : TextAlign.left,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: isMobile ? 48 : 84,
                    fontWeight: FontWeight.w800,
                    height: 1.0,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  "We don't just build structures, we build trust, comfort, and better futures.",
                  textAlign: isMobile ? TextAlign.center : TextAlign.left,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 40),
                _buildHeroButtons(viewModel, isMobile),
                const SizedBox(height: 60),
                _buildStats(isMobile),
              ],
            ),
          ),

          if (!isMobile) const Spacer(flex: 1),

          // Right Side: Floating Consultation Card
          Expanded(
            flex: isMobile ? 0 : 4,
            child: _ConsultationCard(viewModel: viewModel),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star, color: Color(0xFFFFB800), size: 16),
          const SizedBox(width: 8),
          Text(
            "Baguio City",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroButtons(HomeViewModel viewModel, bool isMobile) {
    return Wrap(
      spacing: 20,
      runSpacing: 16,
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 0,
          ),
          child: const Text("Browse Collection →",
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            foregroundColor: const Color.fromARGB(136, 0, 0, 0),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            backgroundColor:
                const Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text("Virtual Tour",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        ),
      ],
    );
  }

  Widget _buildStats(bool isMobile) {
    return Wrap(
      spacing: 40,
      runSpacing: 20,
      children: [
        _statItem("12k+", "Premium Houses"),
        _statItem("5k+", "Happy Families"),
        _statItem("20+", "Years Experience"),
      ],
    );
  }

  Widget _statItem(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Colors.white)),
        Text(label,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 14, color: const Color.fromARGB(255, 255, 255, 255))),
      ],
    );
  }
}

class _ConsultationCard extends StatelessWidget {
  final HomeViewModel viewModel;
  const _ConsultationCard({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 50,
            offset: const Offset(0, 20),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Private Consultation",
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 24, fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          const Text(
              "Receive a curated list of properties tailored to your needs.",
              style: TextStyle(color: Colors.black54, height: 1.5)),
          const SizedBox(height: 32),
          _inputLabel("FULL NAME"),
          _textField("e.g., John Doe", Icons.person_outline),
          const SizedBox(height: 20),
          _inputLabel("EMAIL ADDRESS"),
          _textField("e.g., john@example.com", Icons.mail_outline),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: apexBlue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Inquire now",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text("No spam. 100% Privacy Guaranteed.",
                style: TextStyle(fontSize: 12, color: Colors.black26)),
          ),
        ],
      ),
    );
  }

  Widget _inputLabel(String label) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(label,
            style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.black38)),
      );

  Widget _textField(String hint, IconData icon) => TextField(
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, size: 20),
          filled: true,
          fillColor: const Color(0xFFF1F4F9),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
        ),
      );
}
