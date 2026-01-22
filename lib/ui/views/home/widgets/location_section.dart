import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationSection extends StatelessWidget {
  const LocationSection({Key? key}) : super(key: key);

  Future<void> _openGoogleMaps() async {
    const String googleMapsUrl =
        "https://www.google.com/maps/place/Kumon+Lower+Magsaysay+(Baguio)+Center/@16.4234314,120.5908943,17z/data=!3m1!4b1!4m6!3m5!1s0x3391a330f0078477:0x9f657523fe3b8c86!8m2!3d16.4234263!4d120.5934692!16s%2Fg%2F11v9kmkm9d?entry=ttu&g_ep=EgoyMDI2MDExOS4wIKXMDSoASAFQAw%3D%3D";
    final Uri url = Uri.parse(googleMapsUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isMobile = width < 900;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : width * 0.10,
        vertical: 80,
      ),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            "VISIT OUR OFFICE",
            style: GoogleFonts.plusJakartaSans(
              color: const Color(0xFF2563EB),
              fontWeight: FontWeight.w800,
              fontSize: 14,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Where Excellence is Built",
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: isMobile ? 28 : 36,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 40),

          // The Animated Map Card
          _MapCard(onTap: _openGoogleMaps),
        ],
      ),
    );
  }
}

class _MapCard extends StatefulWidget {
  final VoidCallback onTap;
  const _MapCard({required this.onTap});

  @override
  State<_MapCard> createState() => _MapCardState();
}

class _MapCardState extends State<_MapCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          height: 450,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              )
            ],
          ),
          child: ClipRRect(
            // Ensures the zoomed image doesn't bleed outside the rounded corners
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              children: [
                // 1. THE ZOOMING IMAGE
                AnimatedScale(
                  scale: _isHovered ? 1.05 : 1.0, // Slight zoom in
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOutCubic,
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/map_bg.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                // 2. OVERLAY (Darkens slightly on hover)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  decoration: BoxDecoration(
                    color: _isHovered
                        ? Colors.black.withOpacity(0.3)
                        : Colors.black.withOpacity(0.2),
                  ),
                ),

                // 3. CENTER CONTENT
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.location_on,
                          color: Colors.redAccent, size: 60),
                      const SizedBox(height: 16),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        decoration: BoxDecoration(
                          color: _isHovered
                              ? const Color(0xFF2563EB)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          "View on Google Maps",
                          style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.bold,
                            color: _isHovered
                                ? Colors.white
                                : const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
