import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:rsbweb_v1/app/app.locator.dart';
import 'executive_bio_dialog.dart';

class CompanyProfileViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void showExecutiveBio(BuildContext context, Map<String, String> data) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (context) => ExecutiveBioDialog(data: data),
    );
  }

  void goBack() {
    _navigationService.back();
  }

  void navigateBack() => _navigationService.back();
}
