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
        // Use the new ViewModel function
        viewModel.handleBack(Navigator.of(context).canPop());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: TextButton.icon(
              onPressed: () {
                // Use the new ViewModel function here too
                viewModel.handleBack(Navigator.of(context).canPop());
              },
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
              // ... Rest of your gallery code remains the same
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
      ),
    );
  }

  @override
  ConstructionWorksViewModel viewModelBuilder(BuildContext context) =>
      ConstructionWorksViewModel();
}
