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

    final List<String> constructionImages = [
      'assets/images/constructionworks/work1.jpg',
      'assets/images/constructionworks/work2.jpg',
      'assets/images/constructionworks/work3.jpg',
    ];

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        viewModel.handleBack(Navigator.of(context).canPop());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        // Removed AppBar to fix alignment
        body: SafeArea(
          child: Stack(
            children: [
              // 1. MAIN SCROLLABLE CONTENT
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 20 : width * 0.1,
                  vertical: 0, // Vertical handled by the Column and Spacer
                ).copyWith(top: 80), // Space for the sticky button
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
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
                    const SizedBox(height: 40),
                    MasonryGridView.count(
                      crossAxisCount: isMobile ? 2 : 3,
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
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),

              // 2. STICKY BACK BUTTON (Aligned exactly like Finished Projects)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.white.withOpacity(0.9),
                  padding:
                      const EdgeInsets.only(left: 8.0, top: 10, bottom: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      onPressed: () {
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
  ConstructionWorksViewModel viewModelBuilder(BuildContext context) =>
      ConstructionWorksViewModel();
}
