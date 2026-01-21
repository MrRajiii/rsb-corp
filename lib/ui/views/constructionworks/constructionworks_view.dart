import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'constructionworks_viewmodel.dart';

class ConstructionWorksView extends StackedView<ConstructionWorksViewModel> {
  const ConstructionWorksView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ConstructionWorksViewModel viewModel,
    Widget? child,
  ) {
    double width = MediaQuery.of(context).size.width;
    bool isMobile = width < 900;

    // List of your local BTS/Construction images
    final List<String> constructionImages = [
      'assets/images/constructionworks/work1.jpg',
      'assets/images/constructionworks/work2.jpg',
      'assets/images/constructionworks/work3.jpg',
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false, // Disables default centering/spacing
        titleSpacing: 0, // Removes the gap between the edge and the title
        title: Padding(
          padding: const EdgeInsets.only(
              left: 8.0), // Minimal padding for a clean edge
          child: TextButton.icon(
            onPressed: viewModel.goBack,
            icon: const Icon(Icons.arrow_back,
                size: 20, color: Color(0xFF64748B)),
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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : width * 0.1,
          vertical: 60,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // --- HEADER SECTION ---
            Text(
              "BEHIND THE SCENES",
              style: GoogleFonts.plusJakartaSans(
                color: const Color(0xFF2563EB),
                fontWeight: FontWeight.w800,
                fontSize: 12,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Construction Works",
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: isMobile ? 36 : 48,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 16),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: Text(
                "A look behind the scenes of our ongoing projects. We ensure quality from the ground up, maintaining the highest standards in structural integrity and craftsmanship.",
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  color: const Color(0xFF64748B),
                  height: 1.6,
                ),
              ),
            ),
            const SizedBox(height: 64),

            // --- MASONRY GALLERY SECTION ---
            MasonryGridView.count(
              crossAxisCount:
                  isMobile ? 2 : 3, // 2 columns on mobile, 3 on desktop
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: constructionImages.length,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    constructionImages[index],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child:
                          const Icon(Icons.image_outlined, color: Colors.grey),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  @override
  ConstructionWorksViewModel viewModelBuilder(BuildContext context) =>
      ConstructionWorksViewModel();
}
