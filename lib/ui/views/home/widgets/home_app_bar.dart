import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../home_viewmodel.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final HomeViewModel viewModel;
  const HomeAppBar({Key? key, required this.viewModel}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isMobile = width < 900;
    bool isScrolled = viewModel.isScrolled;

    // Updated logic: Match the image background color when scrolled
    Color backgroundColor =
        isScrolled ? const Color(0xFFF8FAFC) : Colors.transparent;
    Color textColor = isScrolled ? const Color(0xFF1D212B) : Colors.white;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      color: backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : width * 0.07),
      alignment: Alignment.center, // Vertically centers the Row
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Branding / Logo
            InkWell(
              onTap: () => viewModel.scrollController.animateTo(0,
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut),
              child: Text(
                'RSB Corp',
                style: GoogleFonts.plusJakartaSans(
                  color: textColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
            ),

            // Navigation Items
            if (isMobile)
              IconButton(
                icon: Icon(Icons.menu, color: textColor),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
              )
            else
              Row(
                children: [
                  _navItem(
                      "Home",
                      textColor,
                      () => viewModel.scrollController.animateTo(0,
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeInOut)),
                  _navItem("About", textColor,
                      () => viewModel.scrollToSection(viewModel.aboutKey)),
                  _navItem("Contact", textColor,
                      () => viewModel.scrollToSection(viewModel.contactKey)),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _navItem(String text, Color color, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(foregroundColor: color),
        child: Text(
          text,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
