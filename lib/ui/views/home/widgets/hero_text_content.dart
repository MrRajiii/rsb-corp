import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../home_viewmodel.dart';

class HeroTextContent extends StatelessWidget {
  final HomeViewModel viewModel;
  final bool isMobile;

  const HeroTextContent(
      {Key? key, required this.viewModel, required this.isMobile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildBadge(),
        const SizedBox(height: 32),
        Text(
          "Real Estate\nStructures and\nBuilders Co.",
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: GoogleFonts.plusJakartaSans(
            fontSize: isMobile ? 48 : 84,
            fontWeight: FontWeight.w800,
            height: 1.0,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          "We don't just build structures, we build trust, comfort, and better futures.",
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            color: Colors.white.withOpacity(0.9),
            height: 1.6,
          ),
        ),
        const SizedBox(height: 40),
        _buildHeroButtons(),
        const SizedBox(height: 60),
        _buildStats(),
      ],
    );
  }

  Widget _buildBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.location_on, color: Color(0xFFFFB800), size: 16),
          const SizedBox(width: 8),
          Text(
            "Baguio City",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroButtons() {
    return Wrap(
      spacing: 20,
      runSpacing: 16,
      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
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
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            backgroundColor: Colors.white.withOpacity(0.15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text(
            "Virtual Tour",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStats() {
    return Wrap(
      spacing: 40,
      runSpacing: 20,
      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
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
                fontSize: 14, color: Colors.white70)),
      ],
    );
  }
}
