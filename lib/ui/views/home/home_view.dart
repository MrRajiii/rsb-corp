import 'package:flutter/material.dart';
import 'package:rsbweb_v1/app/app.router.dart';
import 'package:rsbweb_v1/ui/common/app_colors.dart';
import 'package:rsbweb_v1/ui/views/home/widgets/common_footer.dart';
import 'package:rsbweb_v1/ui/views/home/widgets/location_section.dart';
import 'package:stacked/stacked.dart'; // Ensure this is imported for apex colors
import 'home_viewmodel.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/hero_section.dart';
import 'widgets/about_section.dart';
import 'widgets/model_showcase.dart';
import 'widgets/contact_section.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: HomeAppBar(viewModel: viewModel),

      // 1. ADDED: Mobile Drawer
      // This works with the Scaffold.of(context).openEndDrawer() call in HomeAppBar
      endDrawer: _MobileDrawer(viewModel: viewModel),

      body: SingleChildScrollView(
        controller: viewModel.scrollController,
        child: Column(
          children: [
            const HeroSection(),
            AboutSection(key: viewModel.aboutKey),
            ModelShowcase(
              key: viewModel.modelsKey,
            ),
            LocationSection(
              key: viewModel.locationKey,
            ),
            ContactSection(
              key: viewModel.contactKey,
            ),
            CommonFooter(viewModel: viewModel),
          ],
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}

// 2. NEW: The Drawer Widget for Mobile Navigation
class _MobileDrawer extends StatelessWidget {
  final HomeViewModel viewModel;
  const _MobileDrawer({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: apexDark,
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFF151921)),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Ensure this asset path is correct
                  Image.asset(
                    'assets/images/company_logo.png',
                    height: 50,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.business,
                        color: Colors.white,
                        size: 50),
                  ),
                  const SizedBox(height: 10),
                  const Text("RSB Corp",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          // Scroll to Home
          _drawerTile(
              context,
              "Home",
              () => viewModel.scrollController.animateTo(0,
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut)),

          _drawerTile(context, "About",
              () => viewModel.scrollToSection(viewModel.aboutKey)),

          _drawerTile(context, "Contact",
              () => viewModel.scrollToSection(viewModel.contactKey)),
          _drawerTile(
            context,
            "Company Profile",
            () => viewModel.navigationService.navigateToCompanyProfileView(),
          ),

          const Spacer(),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text("© 2026 RSB Corp",
                style: TextStyle(color: Colors.white24, fontSize: 12)),
          )
        ],
      ),
    );
  }

  Widget _drawerTile(BuildContext context, String title, VoidCallback onTap) {
    return ListTile(
      title: Text(title,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.chevron_right, color: Colors.white24),
      onTap: () {
        Navigator.pop(context); // 1. Close drawer first
        onTap(); // 2. Perform action
      },
    );
  }
}
