import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rsbweb_v1/ui/common/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ExecutiveBioDialog extends StatelessWidget {
  final Map<String, String> data;

  const ExecutiveBioDialog({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding:
            const EdgeInsets.all(24), // Slightly reduced padding for mobile
        constraints: const BoxConstraints(maxWidth: 700, maxHeight: 800),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Column(
          mainAxisSize:
              MainAxisSize.min, // Dialog stays compact if content is short
          children: [
            // Header Row - Always visible
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Executive Biography",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Scrollable Content Section
            Flexible(
              child: SingleChildScrollView(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    bool isMobile = constraints.maxWidth < 450;

                    return isMobile
                        ? _buildMobileLayout()
                        : _buildDesktopLayout();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Mobile: Image on top of text
  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _profileImage(),
        const SizedBox(height: 24),
        _textInformation(isMobile: true),
      ],
    );
  }

  // Desktop: Image side-by-side with text
  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _profileImage(),
        const SizedBox(width: 24),
        Expanded(child: _textInformation(isMobile: false)),
      ],
    );
  }

  Widget _profileImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        data['imagePath']!,
        width: 140,
        height: 140,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          width: 140,
          height: 140,
          color: Colors.grey[200],
          child: const Icon(Icons.person, size: 40),
        ),
      ),
    );
  }

  Widget _textInformation({required bool isMobile}) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: apexBlue,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            data['tag']!.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Name
        Text(
          data['name']!,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: GoogleFonts.plusJakartaSans(
            fontSize: isMobile ? 24 : 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        // Bio
        Text(
          data['fullBio']!,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 15,
            color: const Color(0xFF64748B),
            height: 1.6,
          ),
        ),
        const SizedBox(height: 24),
        // Social Items
        Wrap(
          spacing: 20,
          runSpacing: 12,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            _SocialItem(
              icon: Icons.facebook_outlined,
              label: "Facebook Profile",
              color: Colors.blue[700]!,
              url: data['fbLink'],
            ),
            const _SocialItem(
              icon: Icons.email_outlined,
              label: "Contact Office",
              color: Colors.black54,
              url: 'mailto:info@rsbcorp.com',
            ),
          ],
        ),
        const SizedBox(height: 8), // Padding at the very bottom
      ],
    );
  }
}

class _SocialItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final String? url;

  const _SocialItem({
    required this.icon,
    required this.label,
    required this.color,
    this.url,
  });

  Future<void> _handleTap() async {
    if (url == null || url!.isEmpty) return;
    final Uri uri = Uri.parse(url!);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _handleTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
