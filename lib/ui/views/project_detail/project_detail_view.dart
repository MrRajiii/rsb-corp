import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectDetailView extends StatelessWidget {
  final Map<String, dynamic> project;

  const ProjectDetailView({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> images = project['images'] as List<String>;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // Large Hero Image with Back Button
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            backgroundColor: const Color(0xFF0F172A),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(images[0], fit: BoxFit.cover),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Project Details",
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text("Owner: ${project['owner']}",
                      style: GoogleFonts.plusJakartaSans(
                          color: const Color(0xFF2563EB),
                          fontWeight: FontWeight.w600)),

                  // --- ADD THE DESCRIPTION HERE ---
                  const SizedBox(height: 16),
                  Text(
                    project['description'] ??
                        'No description available.', // This pulls your text
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        height: 1.6,
                        color: const Color(0xFF64748B)),
                  ),
                  // --------------------------------

                  const SizedBox(height: 32),
                  Text("Full Gallery",
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),

                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: (project['images'] as List).length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(project['images'][index],
                            fit: BoxFit.cover),
                      );
                    },
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
