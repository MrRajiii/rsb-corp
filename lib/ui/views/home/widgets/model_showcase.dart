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

          // --- RESPONSIVE TAB BAR ---
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(16),
            ),
            // Limits width on desktop so it stays a "pill" shape in the center
            constraints: const BoxConstraints(maxWidth: 1000),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              // NeverScrollable on desktop keeps it from feeling "wobbly"
              physics: isMobile
                  ? const BouncingScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              child: Row(
                // Centers content on Desktop, starts at left on Mobile
                mainAxisAlignment: isMobile
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                mainAxisSize: isMobile ? MainAxisSize.max : MainAxisSize.min,
                children: [
                  _CategoryTab(
                    label: "Bungalow",
                    icon: Icons.home_outlined,
                    isActive: true,
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

class _CategoryTab extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const _CategoryTab({
    required this.label,
    required this.icon,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isActive
                ? [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.05), blurRadius: 4)
                  ]
                : null,
          ),
          child: Row(
            children: [
              Icon(icon,
                  size: 20,
                  color: isActive
                      ? const Color(0xFF2563EB)
                      : const Color(0xFF64748B)),
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isActive
                      ? const Color(0xFF2563EB)
                      : const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
