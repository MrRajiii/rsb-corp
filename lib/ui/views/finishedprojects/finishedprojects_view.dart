import 'package:flutter/material.dart';
import 'package:rsbweb_v1/ui/views/finishedprojects/finishedprojects_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:google_fonts/google_fonts.dart';

class FinishedProjectsView extends StackedView<FinishedProjectsViewModel> {
  const FinishedProjectsView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, FinishedProjectsViewModel viewModel,
      Widget? child) {
    double width = MediaQuery.of(context).size.width;
    bool isMobile = width < 1100;

    // 1. Wrap the Scaffold in PopScope to catch browser back/gestures
    return PopScope(
      canPop: false, // Prevents default pop to handle refresh cases
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        // Calls the safe back logic from your ViewModel
        viewModel.handleBack(Navigator.of(context).canPop());
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: SafeArea(
          child: Stack(
            children: [
              // MAIN SCROLLABLE CONTENT
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 80),

                    // HEADER SECTION
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 24 : width * 0.08,
                        vertical: 40,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                            textAlign: TextAlign.center,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: isMobile ? 32 : 42,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF0F172A),
                              height: 1.1,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 700),
                            child: Text(
                              "From vision to reality. Explore our collection of successfully completed residential homes across the region.",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.plusJakartaSans(
                                color: const Color(0xFF64748B),
                                fontSize: 16,
                                height: 1.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // CLICKABLE GRID SECTION
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 24 : width * 0.08,
                      ),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isMobile ? 1 : 3,
                          crossAxisSpacing: 24,
                          mainAxisSpacing: 24,
                          childAspectRatio: isMobile ? 1.2 : 0.85,
                        ),
                        itemCount: viewModel.projects.length,
                        itemBuilder: (context, index) {
                          final project = viewModel.projects[index];
                          return InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () => viewModel.goToProjectDetail(project),
                            child: _ProjectCard(
                              image: project['images'][0],
                              location: project['location']!,
                              owner: project['owner']!,
                              imageCount: (project['images'] as List).length,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),

              // 2. STICKY BACK BUTTON
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: const Color(0xFFF8FAFC).withOpacity(0.9),
                  padding:
                      const EdgeInsets.only(left: 8.0, top: 10, bottom: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      onPressed: () {
                        // 3. Updated to use the safe back logic
                        viewModel.handleBack(Navigator.of(context).canPop());
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 20,
                        color: Color(0xFF64748B),
                      ),
                      label: Text(
                        "Back",
                        style: GoogleFonts.plusJakartaSans(
                          color: const Color(0xFF64748B),
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  FinishedProjectsViewModel viewModelBuilder(BuildContext context) =>
      FinishedProjectsViewModel();
}

class _ProjectCard extends StatelessWidget {
  final String image;
  final String location;
  final String owner;
  final int imageCount;

  const _ProjectCard({
    required this.image,
    required this.location,
    required this.owner,
    required this.imageCount,
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
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[100],
                        child: const Icon(Icons.broken_image_outlined,
                            color: Colors.grey),
                      ),
                    ),
                  ),
                  // "View Gallery" Badge
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.photo_library_outlined,
                              size: 14, color: Colors.white),
                          const SizedBox(width: 6),
                          Text(
                            "$imageCount Photos",
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
