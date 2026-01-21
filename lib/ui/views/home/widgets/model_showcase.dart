import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:google_fonts/google_fonts.dart';
import '../home_viewmodel.dart';

class ModelShowcase extends ViewModelWidget<HomeViewModel> {
  const ModelShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    double width = MediaQuery.of(context).size.width;
    bool isMobile = width < 900;

    return Container(
      key: viewModel.modelsKey,
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
          vertical: 80, horizontal: isMobile ? 20 : width * 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Curated Works",
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              color: const Color(0xFF0F172A),
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Explore our architectural excellence ranging from conceptual\ndesigns to finished high-end residences.",
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              color: const Color(0xFF64748B),
              fontSize: 16,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 48),

          // --- UPDATED RESPONSIVE TAB BAR ---
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9), // Light grey track
              borderRadius: BorderRadius.circular(16),
            ),
            constraints: const BoxConstraints(maxWidth: 1000),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: isMobile
                  ? const BouncingScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: isMobile ? MainAxisSize.max : MainAxisSize.min,
                children: [
                  _CategoryTab(
                    label: "Bungalow",
                    icon: Icons.home_outlined,
                    onTap: viewModel.navigateToBungalow,
                  ),
                  _CategoryTab(
                    label: "2-Storey",
                    icon: Icons.layers_outlined,
                    onTap: viewModel.navigateToTwoStorey,
                  ),
                  _CategoryTab(
                    label: "Construction",
                    icon: Icons.construction_outlined,
                    onTap: viewModel.navigateToConstruction,
                  ),
                  _CategoryTab(
                    label: "Finished Projects",
                    icon: Icons.check_circle_outline,
                    onTap: viewModel.navigateToFinishedProjects,
                  ),
                  _CategoryTab(
                    label: "Interior Designs",
                    icon: Icons.chair_outlined,
                    onTap: viewModel.navigateToInterior,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryTab extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _CategoryTab({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  State<_CategoryTab> createState() => _CategoryTabState();
}

class _CategoryTabState extends State<_CategoryTab> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(12),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              // All tabs are now White to match the Bungalow style
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                // Border changes color on hover for better UX
                color:
                    _isHovered ? const Color(0xFF2563EB) : Colors.transparent,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(_isHovered ? 0.1 : 0.05),
                  blurRadius: _isHovered ? 8 : 4,
                  offset: const Offset(0, 2),
                )
              ],
            ),
            child: Row(
              children: [
                Icon(
                  widget.icon,
                  size: 20,
                  color: const Color(0xFF2563EB), // All icons now Blue
                ),
                const SizedBox(width: 8),
                Text(
                  widget.label,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF2563EB), // All text now Blue
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
