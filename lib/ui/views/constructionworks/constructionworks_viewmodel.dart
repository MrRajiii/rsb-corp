import 'package:rsbweb_v1/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';

class ConstructionWorksViewModel extends BaseViewModel {
  // This line defines the getter that the View was looking for
  final navigationService = locator<NavigationService>();

  // Optional: You can also move the logic here to keep the View clean
  void handleBack(bool canPop) {
    if (canPop) {
      navigationService.back();
    } else {
      navigationService.replaceWithHomeView();
    }
  }
}
