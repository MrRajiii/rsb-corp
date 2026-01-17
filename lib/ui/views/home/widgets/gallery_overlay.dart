import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../common/app_colors.dart';

class GalleryOverlay extends StatelessWidget {
  final String category;
  final List<String> images;

  const GalleryOverlay({Key? key, required this.category, required this.images})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    // 1. Dynamic Grid Calculation
    // Instead of hardcoded numbers, we calculate columns based on width
    int getCrossAxisCount() {
      if (width > 1200) return 4; // Large Desktop
      if (width > 900) return 3; // Desktop/Laptop
      if (width > 600) return 2; // Tablet
      return 1; // Mobile
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
          color: apexDark,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      child: Column(
        children: [
          // Responsive Header
          Padding(
            padding: EdgeInsets.all(width < 600 ? 15 : 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    "$category Gallery",
                    style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: width < 600 ? 22 : 28,
                        fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.close,
                        color: Colors.white, size: width < 600 ? 24 : 30),
                    onPressed: () => Navigator.pop(context)),
              ],
            ),
          ),

          // Responsive Image Grid
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.symmetric(
                  horizontal: width < 600 ? 15 : 25, vertical: 10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: getCrossAxisCount(),
                crossAxisSpacing: width < 600 ? 12 : 20,
                mainAxisSpacing: width < 600 ? 12 : 20,
                childAspectRatio: 1.5,
              ),
              itemCount: images.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            _FullScreenImage(imagePath: images[index]),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(width < 600 ? 10 : 15),
                    child: Image.asset(
                      images[index],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stack) => Container(
                          color: Colors.white10,
                          child: const Icon(Icons.broken_image,
                              color: Colors.white24)),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// --- FULL SCREEN VIEW ---
class _FullScreenImage extends StatelessWidget {
  final String imagePath;
  const _FullScreenImage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // Close button remains accessible on all devices
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: InteractiveViewer(
          // InteractiveViewer is natively responsive (handles touch & mouse)
          panEnabled: true,
          boundaryMargin: const EdgeInsets.all(20),
          minScale: 0.5,
          maxScale: 4,
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
    );
  }
}
