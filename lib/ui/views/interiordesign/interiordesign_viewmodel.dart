import 'package:flutter/material.dart';
import 'package:rsbweb_v1/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';

class InteriorDesignViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();

  void handleBack(bool canPop) {
    if (canPop) {
      navigationService.back();
    } else {
      // If refreshed, the stack is empty, so force redirect to Home
      navigationService.replaceWithHomeView();
    }
  }

  // Simple Lightbox effect to view images clearly
  void showFullScreenImage(BuildContext context, String assetPath) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            InteractiveViewer(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(assetPath, fit: BoxFit.contain),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 30),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
