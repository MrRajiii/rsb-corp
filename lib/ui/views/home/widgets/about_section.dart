import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../common/app_colors.dart';
import '../home_viewmodel.dart';

class AboutSection extends ViewModelWidget<HomeViewModel> {
  const AboutSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    double width = MediaQuery.of(context).size.width;

    // BREAKPOINTS
    bool isMobile = width < 900;
    bool isSmallMobile = width < 600;
    bool isVisible = viewModel.isSectionVisible('about');

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 1000),
      opacity: isVisible ? 1.0 : 0.0,
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.only(top: isVisible ? 0 : 60),
        child: Container(
          key: viewModel.aboutKey,
          // Dynamic padding: less vertical space on mobile to keep the scroll feel tight
          padding: EdgeInsets.symmetric(
              vertical: isMobile ? 60 : 120,
              horizontal: width * 0.08 // Percentage-based horizontal padding
              ),
          child: Flex(
            // Switch direction based on screen size
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image Column
              SizedBox(
                // On mobile, the image takes full width. On desktop, it takes nearly half.
                width: isMobile ? double.infinity : width * 0.4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    'assets/images/about_img.jpg',
                    fit: BoxFit.cover,
                    // Slightly shorter image on mobile to avoid pushing text too far down
                    height: isMobile ? 300 : 500,
                  ),
                ),
              ),

              // Dynamic Spacing
              SizedBox(width: isMobile ? 0 : 60, height: isMobile ? 40 : 0),

              // Text Content Column
              Expanded(
                flex: isMobile ? 0 : 1,
                child: Column(
                  // Center text on mobile for better balance
                  crossAxisAlignment: isMobile
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "WHO WE ARE",
                      style: TextStyle(
                        color: apexBlue,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "RSB Corporation is built on a simple belief:",
                      textAlign: isMobile ? TextAlign.center : TextAlign.start,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: isSmallMobile ? 28 : 42,
                        fontWeight: FontWeight.w800,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Text(
                      "People come first. We are a customer-centered real estate company dedicated to creating homes and spaces that improve lives, strengthen communities, and offer longiterm value. With focus on transparency, trust, and ethical practices, we provide real estate solutions that feel honest, humane, and truly beneficial for our clients. Whether it's buying, selling, investing, or building, our team ensures a smooth and stress-free experience from start to finish.\n\nAt RSB Corporation, we combine modern market knowledge with genuine human care. Every project we undertake is guided by quality craftsmanship, sustainable planning, and a commitment to delivering properties that families and businesses can proudly call their own.",
                      textAlign: isMobile ? TextAlign.center : TextAlign.start,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Features grid/list
                    _aboutFeature(
                      Icons.verified_user_outlined,
                      "Certified Quality",
                      "Industry-leading building standards.",
                      isMobile: isMobile,
                    ),
                    _aboutFeature(
                      Icons.timer_outlined,
                      "On-Time Delivery",
                      "Strict adherence to project timelines.",
                      isMobile: isMobile,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _aboutFeature(IconData icon, String title, String sub,
      {required bool isMobile}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        // On mobile, keep icons aligned to the center if text is centered
        mainAxisAlignment:
            isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: apexBlue, size: 28),
          const SizedBox(width: 16),
          Flexible(
            child: Column(
              crossAxisAlignment: isMobile
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  sub,
                  textAlign: isMobile ? TextAlign.center : TextAlign.start,
                  style: const TextStyle(color: Colors.black45),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
