import 'package:rsbweb_v1/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  Future runStartupLogic() async {
    // Artificial delay to show the logo
    await Future.delayed(const Duration(seconds: 3));

    // Navigate to Home
    _navigationService.replaceWithHomeView();
  }
}
