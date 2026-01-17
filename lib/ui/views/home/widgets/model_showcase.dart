import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../common/app_colors.dart';
import '../home_viewmodel.dart';
import 'gallery_overlay.dart';

class ModelShowcase extends ViewModelWidget<HomeViewModel> {
  const ModelShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    double width = MediaQuery.of(context).size.width;
    bool isMobile = width < 900;
    bool isVisible = viewModel.isSectionVisible('models');

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 1000),
      opacity: isVisible ? 1.0 : 0.0,
      child: Container(
        key: viewModel.modelsKey,
        color: apexDark,
        padding: EdgeInsets.symmetric(vertical: 120, horizontal: width * 0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("MODEL CATEGORIES",
                style: TextStyle(
                    color: apexBlue,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2)),
            const SizedBox(height: 10),
            Text("Choose Your Vision",
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontSize: width < 600 ? 32 : 48,
                  fontWeight: FontWeight.w800,
                )),
            const SizedBox(height: 60),
            Flex(
              direction: isMobile ? Axis.vertical : Axis.horizontal,
              children: [
                _CategoryCard(
                  title: "Bungalow Houses",
                  tag: "SINGLE LEVEL LUXURY",
                  imagePath: "assets/images/bungalow_main.jpg",
                  onTap: () => _openGallery(context, viewModel, "Bungalow"),
                ),
                SizedBox(width: isMobile ? 0 : 40, height: isMobile ? 40 : 0),
                _CategoryCard(
                  title: "2 Storey Houses",
                  tag: "MODERN MULTI-LEVEL",
                  imagePath: "assets/images/2storey_main.jpg",
                  onTap: () => _openGallery(context, viewModel, "2 Storey"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _openGallery(
      BuildContext context, HomeViewModel viewModel, String category) {
    final images = viewModel.getGalleryImages(category);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => GalleryOverlay(category: category, images: images),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String title;
  final String tag;
  final String imagePath;
  final VoidCallback onTap;

  const _CategoryCard(
      {required this.title,
      required this.tag,
      required this.imagePath,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: MediaQuery.of(context).size.width < 900 ? 0 : 1,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF262B35),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(imagePath,
                    height: 380, width: double.infinity, fit: BoxFit.cover),
              ),
              const SizedBox(height: 25),
              Text(tag,
                  style: const TextStyle(
                      color: apexBlue,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Text(title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
