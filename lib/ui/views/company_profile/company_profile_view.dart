import 'package:flutter/material.dart';
import 'package:rsbweb_v1/ui/common/app_colors.dart';
import 'package:rsbweb_v1/ui/views/company_profile/company_lineup_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:google_fonts/google_fonts.dart';
import 'company_profile_viewmodel.dart';
// Import your new widget file

class CompanyProfileView extends StackedView<CompanyProfileViewModel> {
  const CompanyProfileView({super.key});

  @override
  Widget builder(
      BuildContext context, CompanyProfileViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          // Using Stack to keep the button pinned
          children: [
            // 1. Scrollable Content
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Added space at the top so the header doesn't hide under the sticky button
                  const SizedBox(height: 60),
                  const _LeadershipHeader(),
                  ExecutiveGrid(viewModel: viewModel),
                  const SizedBox(height: 120),
                ],
              ),
            ),

            // 2. Sticky Back Button Section
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                // Optional: add a slight gradient or solid color if text becomes hard to read over images
                color: Colors.white.withOpacity(0.9),
                padding: const EdgeInsets.only(left: 8.0, top: 10, bottom: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: viewModel.goBack,
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 20,
                      color: Color(0xFF64748B),
                    ),
                    label: Text(
                      "Back",
                      style: GoogleFonts.plusJakartaSans(
                        color: const Color(0xFF64748B),
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  CompanyProfileViewModel viewModelBuilder(BuildContext context) =>
      CompanyProfileViewModel();
}

class _LeadershipHeader extends StatelessWidget {
  const _LeadershipHeader();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: double
          .infinity, // Ensures the column centers relative to screen width
      child: Padding(
        padding: const EdgeInsets.only(top: 60, bottom: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFE0E7FF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "Company Profile",
                style: GoogleFonts.plusJakartaSans(
                  color: apexBlue,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "Meet Our Team",
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: width < 600 ? 32 : 48,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              constraints: const BoxConstraints(maxWidth: 700),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Our diverse group of leaders brings decades of experience and a shared commitment to driving innovation and excellence in everything we do.",
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  color: const Color(0xFF64748B),
                  height: 1.6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
