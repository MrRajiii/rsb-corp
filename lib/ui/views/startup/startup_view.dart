import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rsbweb_v1/ui/common/app_colors.dart';
import 'package:stacked/stacked.dart';
import 'startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, StartupViewModel viewModel, Widget? child) {
    return Scaffold(
      // Removed 'const' if it was at the Scaffold level
      backgroundColor: apexDark,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/company_logo.png',
              height: 120,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.business,
                color: apexBlue,
                size: 80,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'RSB Corp',
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Real Estate Structures and Builders Co.',
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white54,
                fontSize: 16,
                letterSpacing: 1.2,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 40),
            // REMOVED 'const' here because apexBlue is a variable
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: apexBlue,
                strokeWidth: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  StartupViewModel viewModelBuilder(BuildContext context) => StartupViewModel();

  @override
  void onViewModelReady(StartupViewModel viewModel) =>
      viewModel.runStartupLogic();
}
