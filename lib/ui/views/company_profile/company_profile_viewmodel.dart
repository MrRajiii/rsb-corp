import 'package:flutter/material.dart';
import 'package:rsbweb_v1/ui/views/company_profile/executive_bio_dialog.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:rsbweb_v1/app/app.locator.dart';

class CompanyProfileViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  NavigationService get navigationService => _navigationService;

  // The function the View is calling
  void showExecutiveBio(BuildContext context, Map<String, String> data) {
    showDialog(
      context: context,
      builder: (context) => ExecutiveBioDialog(data: data),
    );
  }

  void goBack() {
    _navigationService.back();
  }
}
