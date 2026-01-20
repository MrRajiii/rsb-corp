import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';

class FinishedProjectsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void goBack() => _navigationService.back();

  // Future-proofing: You can eventually fetch this list from Firebase
  final List<Map<String, String>> projects = [
    {
      'image': 'assets/images/FinishedProjects/p1.jpg',
      'location': 'Aguilar, Pangasinan',
      'owner': 'Mrs. Alex Espino',
    },
    // Add more projects here
  ];
}
