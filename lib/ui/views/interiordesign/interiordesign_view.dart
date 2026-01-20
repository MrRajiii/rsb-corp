import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'interiordesign_viewmodel.dart';

class InteriorDesignView extends StackedView<InteriorDesignViewModel> {
  const InteriorDesignView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    InteriorDesignViewModel viewModel,
    Widget? child,
  ) {
    double width = MediaQuery.of(context).size.width;
    bool isMobile = width < 900;

    // List of your local Interior Design images
    final List<String> interiorImages = [
      'assets/images/interiordesigns/d1.jpg',
      'assets/images/interiordesigns/d2.jpg',
      'assets/images/interiordesigns/d3.jpg',
      'assets/images/interiordesigns/d4.jpg',
      'assets/images/interiordesigns/d5.jpg',
      'assets/images/interiordesigns/d6.jpg',
      'assets/images/interiordesigns/d7.jpg',
      'assets/images/interiordesigns/d8.jpg',
      'assets/images/interiordesigns/d9.jpg',
      'assets/images/interiordesigns/d10.jpg',
      'assets/images/interiordesigns/d11.jpg',
      'assets/images/interiordesigns/d12.jpg',
      'assets/images/interiordesigns/d13.jpg',
      'assets/images/interiordesigns/d14.jpg',
      'assets/images/interiordesigns/d15.jpg',
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
              "Interior Designs",
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: isMobile ? 36 : 48,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 16),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 750),
              child: Text(
                "Explore our curated collection of interior styles. From minimalist modern to luxury classic, we offer full customization of finishes, lighting, and cabinetry to match your personal taste.",
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
              crossAxisCount: isMobile ? 2 : 3,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: interiorImages.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => viewModel.showFullScreenImage(
                      context, interiorImages[index]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      interiorImages[index],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(Icons.format_paint_outlined,
                            color: Colors.grey),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  @override
  InteriorDesignViewModel viewModelBuilder(BuildContext context) =>
      InteriorDesignViewModel();
}
