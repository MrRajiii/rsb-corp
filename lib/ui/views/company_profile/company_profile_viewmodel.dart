import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:rsbweb_v1/app/app.locator.dart';
import 'package:rsbweb_v1/app/app.router.dart';

class CompanyProfileViewModel extends BaseViewModel {
  // 1. Get the NavigationService from the locator
  final _navigationService = locator<NavigationService>();

  // 2. Create the getter that the View is looking for
  NavigationService get navigationService => _navigationService;

  void goBack() {
    _navigationService.back();
  }

  // Helper for the refresh fix
  void replaceWithHomeView() {
    _navigationService.replaceWithHomeView();
  }

  // If you have the showExecutiveBio function, keep it here too:
  void showExecutiveBio(context, data) {
    // Your existing logic for dialogs
  }
}
