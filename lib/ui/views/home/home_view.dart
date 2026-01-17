import 'package:flutter/material.dart';
import 'package:rsbweb_v1/ui/common/app_colors.dart';
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
        child: const Column(
          children: [
            HeroSection(),
            AboutSection(),
            ModelShowcase(),
            ContactSection(),
            _Footer(),
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
                  Image.asset(
                    'assets/images/company_logo.png',
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 10),
                  Text("RSB Corp",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
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
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
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
        Navigator.pop(context); // Close drawer first
        onTap(); // Then scroll
      },
    );
  }
}

// 3. UPDATED: Responsive Footer
class _Footer extends StatelessWidget {
  const _Footer();
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 40),
        color: const Color(0xFF1D212B),
        child: const Center(
            child: Text("© 2026 RSB Corp. Built with Excellence.",
                style: TextStyle(color: Colors.white24, letterSpacing: 1.2))));
  }
}
