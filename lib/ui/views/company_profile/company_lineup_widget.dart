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
        "name": "Randy Sion Bernardez",
        "tag": "Chairman / Founder",
        "imagePath": "assets/images/comp_prof_img/chairman_founder.jpg",
        "bio": "Bio",
        "fullBio": "Full bio goes here",
        "fbLink": "https://www.facebook.com/chimino.roglo",
      },
      {
        "name": "Alexander Dipasupil Florendo",
        "tag": "Chief Executive Officer",
        "imagePath": "assets/images/comp_prof_img/ceo.png",
        "bio": "Bio",
        "fullBio": "Full bio goes here",
        "fbLink": "https://www.facebook.com",
      },
      {
        "name": "Kim Cabe Aquino",
        "tag": "President / Chief Operating Officer",
        "imagePath": "assets/images/comp_prof_img/president_coo.jpg",
        "bio": "Bio",
        "fullBio": "Full bio goes here",
        "fbLink": "https://www.facebook.com/kim.aquino.9256",
      },
      {
        "name": "Ericha Tucay Villarico",
        "tag": "Chief Financial Officer",
        "imagePath": "assets/images/comp_prof_img/cfo.png",
        "bio": "Bio",
        "fullBio": "Full bio goes here",
        "fbLink": "https://www.facebook.com/elocinagetro",
      },
      {
        "name": "Glydel Sobrepeña Cayabyab",
        "tag": "Corporate Secretary",
        "imagePath": "assets/images/comp_prof_img/secretary.jpg",
        "bio": "Bio",
        "fullBio": "Full bio goes here",
        "fbLink": "https://www.facebook.com/glycayabyab",
      },
      {
        "name": "Rajian Hero Gayo Castronuevo",
        "tag": "Chief Technology Officer",
        "imagePath": "assets/images/comp_prof_img/cto.png",
        "bio": "Bio",
        "fullBio": "Full bio goes here",
        "fbLink": "https://www.facebook.com/raji.castronuevo.5",
      },
      {
        "name": "Leeal Chan Bernandez",
        "tag": "Corporate Auditor",
        "imagePath": "assets/images/comp_prof_img/auditor.jpg",
        "bio": "Bio",
        "fullBio": "Full bio goes here",
        "fbLink": "https://www.facebook.com/leealchann#",
      },
      {
        "name": "Jared Valdez Reclosado",
        "tag": "Corporate Treasurer",
        "imagePath": "assets/images/comp_prof_img/treasurer.jpg",
        "bio": "Bio",
        "fullBio": "Full bio goes here",
        "fbLink": "https://www.facebook.com/m.thisisjvr#",
      },
      {
        "name": "Gieselle Sobrepeña Cayabyab",
        "tag": "Human Resources",
        "imagePath": "assets/images/comp_prof_img/hr.jpg",
        "bio": "Bio",
        "fullBio": "Full bio goes here",
        "fbLink": "https://www.facebook.com/PrettyGieselle",
      },
      {
        "name": "Sherlene Corales Aquino",
        "tag": "Admin",
        "imagePath": "assets/images/comp_prof_img/admin.jpg",
        "bio": "Bio",
        "fullBio": "Full bio goes here",
        "fbLink": "https://www.facebook.com/sherlene.corales#",
      },
    ];

    double screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1400),
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Determine columns: 4 for Desktop, 2 for Tablet, 1 for Mobile
            int crossAxisCount = 4;
            if (constraints.maxWidth < 600) {
              crossAxisCount = 1;
            } else if (constraints.maxWidth < 1100) {
              crossAxisCount = 2;
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: executives.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 30,
                mainAxisSpacing: 40,
                // Adjusted to 0.6 to prevent bottom overflow
                childAspectRatio: 0.6,
              ),
              itemBuilder: (context, index) {
                return ExecutiveCard(
                  data: executives[index],
                  viewModel: viewModel,
                );
              },
            );
          },
        ),
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
          children: [
            // Top Section: Image
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
                  Positioned(
                    bottom: 16,
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

            // Bottom Section: Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // Keeps footer at bottom
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name and Bio grouping
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                Icon(Icons.link,
                                    size: 20, color: Color(0xFF94A3B8)),
                                SizedBox(width: 12),
                                Icon(Icons.email_outlined,
                                    size: 20, color: Color(0xFF94A3B8)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          widget.data['bio']!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            color: const Color(0xFF64748B),
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),

                    // Footer grouping
                    Column(
                      children: [
                        const Divider(height: 1, color: Color(0xFFF1F5F9)),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: () => widget.viewModel
                              .showExecutiveBio(context, widget.data),
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
