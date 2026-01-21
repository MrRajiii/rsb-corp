import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rsbweb_v1/ui/views/home/home_viewmodel.dart'; // Import your ViewModel

class CommonFooter extends StatelessWidget {
  final HomeViewModel viewModel; // 1. Add this variable

  const CommonFooter({Key? key, required this.viewModel}) : super(key: key);

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint("Could not launch $urlString");
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isMobile = width < 800;

    return Container(
      width: double.infinity,
      color: const Color(0xFF0F172A),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : width * 0.10,
        vertical: 80,
      ),
      child: Column(
        children: [
          isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _footerSections(context),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _footerSections(context),
                ),
          const SizedBox(height: 80),
          const Divider(color: Color(0xFF1E293B)),
          const SizedBox(height: 24),
          Text(
            "© 2026 RSB Corp. All rights reserved.",
            style: GoogleFonts.plusJakartaSans(
              color: const Color(0xFF64748B),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _footerSections(BuildContext context) {
    return [
      // 1. BRAND SECTION
      SizedBox(
        width: 350,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("RSB CORP",
                style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5)),
            const SizedBox(height: 16),
            Text(
              "Building excellence in Baguio City. We turn your vision into high-quality residential and commercial realities.",
              style: GoogleFonts.plusJakartaSans(
                  color: const Color(0xFF94A3B8), fontSize: 14, height: 1.6),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                _SocialIcon(
                    icon: Icons.facebook,
                    onTap: () => _launchURL('https://facebook.com')),
                const SizedBox(width: 16),
                _SocialIcon(
                    icon: Icons.business,
                    onTap: () => _launchURL('https://linkedin.com')),
              ],
            ),
          ],
        ),
      ),

      // 2. QUICK LINKS (Now using the helper widget and viewModel)
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Quick Links",
              style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          _FooterLink(
              title: "Home",
              onTap: () => viewModel.scrollController.animateTo(0,
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut)),
          _FooterLink(
              title: "About",
              onTap: () => viewModel.scrollToSection(viewModel.aboutKey)),
          _FooterLink(
              title: "Curated Works",
              onTap: () => viewModel.scrollToSection(viewModel.modelsKey)),
          _FooterLink(
              title: "Location",
              onTap: () => viewModel.scrollToSection(viewModel.locationKey)),
          _FooterLink(
              title: "Contact",
              onTap: () => viewModel.scrollToSection(viewModel.contactKey)),
        ],
      ),

      // 3. CONTACT INFO
      SizedBox(
        width: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Contact Us",
                style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            const _ContactRow(
                icon: Icons.location_on,
                text: "Magsaysay Private Rd. Baguio City"),
            _ContactRow(
                icon: Icons.phone,
                text: "(+63) 975 595 3380",
                onTap: () => _launchURL('tel:+639755953380')),
            _ContactRow(
                icon: Icons.email,
                text: "rsbcorporation8@gmail.com",
                onTap: () => _launchURL('mailto:rsbcorporation8@gmail.com')),
          ],
        ),
      ),
    ];
  }
}

// --- NEW HELPER WIDGETS TO FIX THE ERRORS ---

class _FooterLink extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _FooterLink({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        child: Text(
          title,
          style: GoogleFonts.plusJakartaSans(
              color: const Color(0xFF94A3B8), fontSize: 14),
        ),
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _SocialIcon({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap, child: Icon(icon, color: Colors.white, size: 24));
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;
  const _ContactRow({required this.icon, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: const Color(0xFF2563EB), size: 18),
            const SizedBox(width: 12),
            Expanded(
              child: Text(text,
                  style: GoogleFonts.plusJakartaSans(
                      color: const Color(0xFF94A3B8),
                      fontSize: 14,
                      height: 1.4)),
            ),
          ],
        ),
      ),
    );
  }
}
