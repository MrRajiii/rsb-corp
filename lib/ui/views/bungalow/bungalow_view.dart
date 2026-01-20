import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:google_fonts/google_fonts.dart';
import 'bungalow_viewmodel.dart';

class BungalowView extends StackedView<BungalowViewModel> {
  const BungalowView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, BungalowViewModel viewModel, Widget? child) {
    double width = MediaQuery.of(context).size.width;
    bool isMobile = width < 1100;

    return Scaffold(
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
            horizontal: isMobile ? 24 : width * 0.08, vertical: 40),
        child: Flex(
          direction: isMobile ? Axis.vertical : Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: isMobile ? 0 : 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _ProjectHeader(),
                  const SizedBox(height: 32),
                  // Pass viewModel to the price card
                  _PriceInquiryCard(viewModel: viewModel),
                  const SizedBox(height: 48),
                  const _PropertyFeatures(),
                  const SizedBox(height: 48),
                  const _LocationSection(),
                ],
              ),
            ),
            SizedBox(width: isMobile ? 0 : 80, height: isMobile ? 60 : 0),
            Expanded(
              flex: isMobile ? 0 : 3,
              child: const _ProjectGallery(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  BungalowViewModel viewModelBuilder(BuildContext context) =>
      BungalowViewModel();
}

// --- LEFT SIDE COMPONENTS ---

class _ProjectHeader extends StatelessWidget {
  const _ProjectHeader();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("MODERN BUNGALOW SERIES",
            style: GoogleFonts.plusJakartaSans(
                color: const Color(0xFF2563EB),
                fontWeight: FontWeight.w800,
                fontSize: 12,
                letterSpacing: 1.2)),
        const SizedBox(height: 16),
        Text("Customizable Dream Home",
            style: GoogleFonts.plusJakartaSans(
                color: const Color(0xFF0F172A),
                fontSize: 42,
                fontWeight: FontWeight.w800,
                height: 1.1)),
        const SizedBox(height: 16),
        Text(
          "You can customize your preferred designs and interior! We have different options to choose from to fit your lifestyle.",
          style: GoogleFonts.plusJakartaSans(
              color: const Color(0xFF64748B), fontSize: 16, height: 1.6),
        ),
      ],
    );
  }
}

class _PriceInquiryCard extends StatelessWidget {
  final BungalowViewModel viewModel;
  const _PriceInquiryCard({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("STARTING PRICE",
              style: TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 13,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("₱4.5M",
                  style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontSize: 42,
                      fontWeight: FontWeight.w800)),
              const Padding(
                padding: EdgeInsets.only(bottom: 8, left: 8),
                child: Text("ONLY",
                    style: TextStyle(
                        color: Color(0xFF2563EB), fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 32),
          _ActionButton(
            onPressed: viewModel.onInquireTap,
            label: "Inquire Now",
            icon: Icons.chat_bubble_outline,
            color: const Color(0xFF2563EB),
          ),
          const SizedBox(height: 12),
          _ActionButton(
            onPressed: () => viewModel.onScheduleVisitTap(context),
            label: "Book Site Visit",
            icon: Icons.calendar_today_outlined,
            isOutlined: true,
          ),
        ],
      ),
    );
  }
}

class _PropertyFeatures extends StatelessWidget {
  const _PropertyFeatures();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("HOME FEATURES",
            style: GoogleFonts.plusJakartaSans(
                fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        Wrap(
          spacing: 24,
          runSpacing: 16,
          children: const [
            _FeatureTile(icon: Icons.bed_outlined, label: "2-3 Bedrooms"),
            _FeatureTile(
                icon: Icons.restaurant_outlined, label: "Dining & Kitchen"),
            _FeatureTile(icon: Icons.chair_outlined, label: "Living Room"),
            _FeatureTile(icon: Icons.wc_outlined, label: "Toilet & Bath"),
            _FeatureTile(
                icon: Icons.directions_car_filled_outlined,
                label: "Parking Space"),
            _FeatureTile(icon: Icons.yard_outlined, label: "Front Yard"),
          ],
        ),
      ],
    );
  }
}

class _LocationSection extends StatelessWidget {
  const _LocationSection();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("AVAILABLE LOCATIONS",
            style: GoogleFonts.plusJakartaSans(
                fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        const _LocationRow(location: "Balacbac", size: "100 - 310 sqm"),
        const _LocationRow(location: "Tuba", size: "100 - 340 sqm"),
        const _LocationRow(location: "Pinget", size: "100 sqm"),
      ],
    );
  }
}

// --- RIGHT SIDE GALLERY ---

class _ProjectGallery extends StatelessWidget {
  const _ProjectGallery();
  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      "assets/images/bungalow/img1.jpg",
      "assets/images/bungalow/img2.jpg",
      "assets/images/bungalow/img3.jpg",
      "assets/images/bungalow/img4.jpg",
      "assets/images/bungalow/img5.jpg",
    ];

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Image.asset(images[0],
              height: 500, width: double.infinity, fit: BoxFit.cover),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.4,
          ),
          itemCount: images.length - 1,
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(16),
              // Fixed: Changed from .network to .asset
              child: Image.asset(images[index + 1], fit: BoxFit.cover),
            );
          },
        ),
      ],
    );
  }
}

// --- UI ATOMS (Helpers) ---

class _FeatureTile extends StatelessWidget {
  final IconData icon;
  final String label;
  const _FeatureTile({required this.icon, required this.label});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFF1F5F9)),
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFF2563EB)),
          const SizedBox(width: 10),
          Expanded(
              child: Text(label,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }
}

class _LocationRow extends StatelessWidget {
  final String location;
  final String size;
  const _LocationRow({required this.location, required this.size});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF22C55E), size: 18),
          const SizedBox(width: 12),
          Text(location,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const Spacer(),
          Text(size, style: const TextStyle(color: Color(0xFF64748B))),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color? color;
  final bool isOutlined;
  final VoidCallback onPressed; // Added this

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.onPressed, // Added this
    this.color,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed, // Connected the callback
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: isOutlined ? Colors.transparent : color,
        foregroundColor: Colors.white,
        side: isOutlined ? const BorderSide(color: Color(0xFF334155)) : null,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
    );
  }
}
