import 'package:rsbweb_v1/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';

class FinishedProjectsViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();

  void handleBack(bool canPop) {
    if (canPop) {
      navigationService.back();
    } else {
      // Fallback for hard refresh: Go back to Home
      navigationService.replaceWithHomeView();
    }
  }

  // Future-proofing: You can eventually fetch this list from Firebase
  final List<Map<String, dynamic>> projects = [
    {
      'images': [
        'assets/images/FinishedProjects/p1.jpg',
      ],
      'location': 'Aguilar, Pangasinan',
      'owner': 'Mrs. Alex Espino',
      'description':
          'A modern 2-storey residential home featuring a minimalist aesthetic and open-plan living spaces.',
    },
    {
      'images': [
        'assets/images/FinishedProjects/p2(1).jpg',
        'assets/images/FinishedProjects/p2(2).jpg',
        'assets/images/FinishedProjects/p2(3).jpg',
      ],
      'location': 'Yagyagan, Tuba Benguet, Regal lexber Subdivision',
      'owner': 'Mr. Ramon Jeminez',
      'description':
          'A modern 2-storey residential home featuring a minimalist aesthetic and open-plan living spaces.',
    },
    // Add more projects following this same List<String> format for 'images'
  ];
  void goToProjectDetail(Map<String, dynamic> project) {
    navigationService.navigateToProjectDetailView(project: project);
  }
}
