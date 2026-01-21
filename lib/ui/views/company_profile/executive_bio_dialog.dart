import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rsbweb_v1/ui/common/app_colors.dart';

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
        padding: const EdgeInsets.all(32),
        constraints: const BoxConstraints(maxWidth: 650),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header Row with Close Button
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
            const SizedBox(height: 32),

            // Content Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Image
                ClipRRect(
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
                ),
                const SizedBox(width: 24),

                // Text Information
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Badge/Tag
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
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
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Full Biography
                      Text(
                        data['fullBio']!,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 15,
                          color: const Color(0xFF64748B),
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Social Links
                      Row(
                        children: [
                          _SocialItem(
                            icon: Icons.facebook_outlined,
                            label: "Facebook Profile",
                            color: Colors.blue[700]!,
                          ),
                          const SizedBox(width: 20),
                          const _SocialItem(
                            icon: Icons.email_outlined,
                            label: "Contact Office",
                            color: Colors.black54,
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _SocialItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _SocialItem({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // You can add URL launcher logic here later
      },
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
