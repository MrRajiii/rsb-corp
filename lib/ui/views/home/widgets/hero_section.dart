import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../home_viewmodel.dart';
import 'hero_text_content.dart';
import 'consultation_card.dart';
import 'scroll_indicator.dart';

class HeroSection extends ViewModelWidget<HomeViewModel> {
  const HeroSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    double width = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isMobile = width < 1024;

    return Container(
      width: width,
      constraints: BoxConstraints(minHeight: screenHeight),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('assets/images/hero_bg.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.45),
            BlendMode.darken,
          ),
        ),
      ),
      child: isMobile
          ? _buildMobileContent(viewModel, width)
          : _buildDesktopContent(viewModel, width, screenHeight),
    );
  }

  Widget _buildDesktopContent(
      HomeViewModel viewModel, double width, double screenHeight) {
    return Stack(
      children: [
        Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              left: width * 0.08,
              right: width * 0.08,
              top: 120,
              bottom: 80,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 6,
                  child: HeroTextContent(viewModel: viewModel, isMobile: false),
                ),
                const Spacer(flex: 1),
                Expanded(
                  flex: 4,
                  child: ConsultationCard(viewModel: viewModel),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 30,
          left: 0,
          right: 0,
          child: AnimatedScrollIndicator(
            onTap: () => viewModel.scrollToSection(viewModel.aboutKey),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileContent(HomeViewModel viewModel, double width) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
      child: Column(
        children: [
          HeroTextContent(viewModel: viewModel, isMobile: true),
          const SizedBox(height: 50),
          ConsultationCard(viewModel: viewModel),
          const SizedBox(height: 50),
          AnimatedScrollIndicator(
            onTap: () => viewModel.scrollToSection(viewModel.aboutKey),
          ),
        ],
      ),
    );
  }
}
