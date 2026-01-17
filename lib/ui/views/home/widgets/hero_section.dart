import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../common/app_colors.dart';
import '../home_viewmodel.dart';

class HeroSection extends ViewModelWidget<HomeViewModel> {
  const HeroSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    // 1. Use MediaQuery to get dynamic dimensions
    double width = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // 2. Set breakpoints
    bool isMobile = width < 600;
    bool isTablet = width >= 600 && width < 1024;

    return Container(
      // Use minHeight to ensure it covers the screen but can grow if needed
      constraints: BoxConstraints(minHeight: screenHeight * 0.8),
      width: width,
      decoration: BoxDecoration(
        color: apexDark,
        image: DecorationImage(
          image: const AssetImage('assets/images/hero_bg.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.6),
            BlendMode.darken,
          ),
        ),
      ),
      child: Padding(
        // Add horizontal padding so text doesn't touch screen edges on mobile
        padding:
            EdgeInsets.symmetric(horizontal: isMobile ? 20 : 40, vertical: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Responsive Logo Height
            Image.asset(
              'assets/images/company_logo.png',
              height: isMobile ? 100 : 180,
              filterQuality: FilterQuality.high,
            ),
            const SizedBox(height: 30),

            // Responsive Typography
            Text(
              "We don't just build structures\nwe build trust, comfort, and better futures",
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white,
                // Font size scales based on screen width
                fontSize: isMobile ? 32 : (isTablet ? 48 : 72),
                fontWeight: FontWeight.w800,
                height: 1.1,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(0, 4),
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // 3. Use Wrap instead of Row for buttons
            // This automatically stacks them when the screen is too narrow
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 20, // Horizontal space between buttons
              runSpacing: 16, // Vertical space when stacked
              children: [
                _heroButton(
                  "View House Models",
                  apexBlue,
                  () => viewModel.scrollToSection(viewModel.modelsKey),
                  isMobile: isMobile,
                ),
                _heroButton(
                  "Inquire now",
                  Colors.transparent,
                  () => viewModel.scrollToSection(viewModel.contactKey),
                  isOutline: true,
                  isMobile: isMobile,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _heroButton(
    String text,
    Color color,
    VoidCallback onPressed, {
    bool isOutline = false,
    required bool isMobile,
  }) {
    return SizedBox(
      // On mobile, make buttons full width or a fixed large size
      width: isMobile ? double.infinity : null,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          side: isOutline
              ? const BorderSide(color: Colors.white24)
              : BorderSide.none,
          // Adjust padding for mobile
          padding: EdgeInsets.symmetric(
            horizontal: 32,
            vertical: isMobile ? 18 : 24,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: isOutline ? 0 : 2,
        ),
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
