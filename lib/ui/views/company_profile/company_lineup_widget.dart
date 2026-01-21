import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rsbweb_v1/ui/common/app_colors.dart';
import 'company_profile_viewmodel.dart';

class ExecutiveGrid extends StatelessWidget {
  final CompanyProfileViewModel viewModel;
  const ExecutiveGrid({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final executives = [
      {
        "name": "Randy Bernardez",
        "tag": "Chairman / Founder",
        "imagePath": "assets/images/leader1.jpg",
        "bio": "Bio",
        "fullBio": "Full bio goes here"
      },
      {
        "name": "Alex Xander Florendo",
        "tag": "CEO",
        "imagePath": "assets/images/leader2.jpg",
        "bio": "Bio",
        "fullBio": "Full bio goes here"
      },
      {
        "name": "Kim Aquino",
        "tag": "President / COO",
        "imagePath": "assets/images/leader3.jpg",
        "bio": "Bio",
        "fullBio": "Full bio goes here"
      },
      {
        "name": "Nicole Ortega",
        "tag": "CFO",
        "imagePath": "assets/images/leader3.jpg",
        "bio": "Bio",
        "fullBio": "Full bio goes here"
      },
    ];

    return Center(
      child: Wrap(
        spacing: 30,
        runSpacing: 40,
        alignment: WrapAlignment.center,
        children: executives
            .map((data) => ExecutiveCard(
                  data: data,
                  viewModel: viewModel,
                ))
            .toList(),
      ),
    );
  }
}

class ExecutiveCard extends StatefulWidget {
  final Map<String, String> data;
  final CompanyProfileViewModel viewModel;

  const ExecutiveCard({super.key, required this.data, required this.viewModel});

  @override
  State<ExecutiveCard> createState() => _ExecutiveCardState();
}

class _ExecutiveCardState extends State<ExecutiveCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        width: 320,
        // Card lifts up by 12 pixels on hover
        transform: Matrix4.identity()..translate(0, _isHovered ? -12 : 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_isHovered ? 0.1 : 0.04),
              blurRadius: _isHovered ? 30 : 20,
              offset: Offset(0, _isHovered ? 15 : 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section with AspectRatio
            AspectRatio(
              aspectRatio: 1,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(24)),
                    child: Image.asset(
                      widget.data['imagePath']!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: const Color(0xFFF8FAFC),
                        child: Icon(Icons.person,
                            color: apexBlue.withOpacity(0.2), size: 50),
                      ),
                    ),
                  ),
                  // Tag Overlay
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: apexBlue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        widget.data['tag']!.toUpperCase(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content Section
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and Social Icons Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.data['name']!,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1E293B),
                          ),
                        ),
                      ),
                      const Row(
                        children: [
                          Icon(Icons.link, size: 20, color: Color(0xFF94A3B8)),
                          SizedBox(width: 12),
                          Icon(Icons.email_outlined,
                              size: 20, color: Color(0xFF94A3B8)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Bio
                  Text(
                    widget.data['bio']!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      color: const Color(0xFF64748B),
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Divider(height: 1, color: Color(0xFFF1F5F9)),
                  const SizedBox(height: 20),
                  // Footer Link
                  InkWell(
                    onTap: () =>
                        widget.viewModel.showExecutiveBio(context, widget.data),
                    borderRadius: BorderRadius.circular(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "PROFILE DETAILS",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: apexBlue,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const Icon(Icons.arrow_forward_rounded,
                            size: 18, color: apexBlue),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
