import 'package:flutter/material.dart';
import 'package:rsbweb_v1/ui/views/finishedprojects/finishedprojects_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:google_fonts/google_fonts.dart';

class FinishedProjectsView extends StackedView<FinishedProjectsViewModel> {
  const FinishedProjectsView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, FinishedProjectsViewModel viewModel,
      Widget? child) {
    // Determine screen width for responsiveness
    double width = MediaQuery.of(context).size.width;
    bool isMobile = width < 1100;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)),
          onPressed: viewModel.goBack,
        ),
        title: Text(
          "Portfolio",
          style: GoogleFonts.plusJakartaSans(
            color: const Color(0xFF0F172A),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- HEADER SECTION ---
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : width * 0.08,
                vertical: 40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "OUR FINISHED PROJECTS",
                    style: GoogleFonts.plusJakartaSans(
                      color: const Color(0xFF2563EB),
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Excellence in Every Detail",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: isMobile ? 32 : 42,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF0F172A),
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "From vision to reality. Explore our collection of successfully completed residential homes across the region.",
                    style: GoogleFonts.plusJakartaSans(
                      color: const Color(0xFF64748B),
                      fontSize: 16,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),

            // --- RESPONSIVE GRID SECTION ---
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : width * 0.08,
              ),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                // Switches between 1 column (mobile) and 3 columns (desktop)
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isMobile ? 1 : 3,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  // Adjust this ratio to make the "rectangle" taller or shorter
                  childAspectRatio: isMobile ? 1.2 : 0.85,
                ),
                itemCount: viewModel.projects.length,
                itemBuilder: (context, index) {
                  final project = viewModel.projects[index];
                  return _ProjectCard(
                    image: project['image']!,
                    location: project['location']!,
                    owner: project['owner']!,
                  );
                },
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  @override
  FinishedProjectsViewModel viewModelBuilder(BuildContext context) =>
      FinishedProjectsViewModel();
}

// --- PROJECT CARD COMPONENT ---

class _ProjectCard extends StatelessWidget {
  final String image;
  final String location;
  final String owner;

  const _ProjectCard({
    required this.image,
    required this.location,
    required this.owner,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section (Takes more space)
            Expanded(
              flex: 3,
              child: Image.asset(
                image,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[100],
                  child: const Icon(Icons.broken_image_outlined,
                      color: Colors.grey),
                ),
              ),
            ),
            // Information Section (The rectangle footer)
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            size: 16, color: Color(0xFF2563EB)),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            location,
                            style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: const Color(0xFF0F172A),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Owner: $owner",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        color: const Color(0xFF64748B),
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
