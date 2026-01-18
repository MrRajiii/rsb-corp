import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../home_viewmodel.dart';

class ConsultationCard extends StatelessWidget {
  final HomeViewModel viewModel;
  const ConsultationCard({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 50,
                offset: const Offset(0, 20),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Private Consultation",
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 24, fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              const Text("Curated off-market listings tailored for you.",
                  style: TextStyle(color: Colors.black54, height: 1.5)),
              const SizedBox(height: 32),

              _inputLabel("FULL NAME"),
              _textField("John Doe", Icons.person_outline),
              const SizedBox(height: 20),

              _inputLabel("EMAIL ADDRESS"),
              _textField("john@example.com", Icons.mail_outline),
              const SizedBox(height: 20),

              // NEW: Row for Type and Budget
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _inputLabel("TYPE"),
                        _textField("Penthouse", null), // No icon as per image
                      ],
                    ),
                  ),
                  const SizedBox(width: 16), // Gap between the two fields
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _inputLabel("BUDGET"),
                        _textField("\$1M - \$5M", null),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0052CC),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: const Text("Inquire now",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                ),
              ),
              const SizedBox(height: 16),
              const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.verified_user_outlined,
                        size: 14, color: Colors.black26),
                    SizedBox(width: 4),
                    Text("Secure & 100% Confidential",
                        style: TextStyle(fontSize: 12, color: Colors.black26)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputLabel(String label) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(label,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.black38,
                letterSpacing: 0.5)),
      );

  Widget _textField(String hint, IconData? icon) => TextField(
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black26, fontSize: 14),
          prefixIcon:
              icon != null ? Icon(icon, size: 20, color: Colors.black38) : null,
          filled: true,
          fillColor: const Color(0xFFF1F4F9),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
        ),
      );
}
