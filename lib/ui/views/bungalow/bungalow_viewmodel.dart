import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rsbweb_v1/app/app.dialogs.dart';
import 'package:rsbweb_v1/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';

class BungalowViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();

  void handleBack(bool canPop) {
    if (canPop) {
      navigationService.back();
    } else {
      navigationService.replaceWithHomeView();
    }
  }

  // --- INQUIRE NOW LOGIC ---
  Future<void> onInquireTap() async {
    var response = await _dialogService.showCustomDialog(
      variant: DialogType.inquiry, // Using the renamed 'inquiry'
      data: 'Bungalow Series',
    );

    if (response?.confirmed == true && response?.data != null) {
      final userData = response!.data as Map<String, dynamic>;
      setBusy(true);
      try {
        await FirebaseFirestore.instance.collection('property_inquiries').add({
          'property': 'Bungalow',
          'client_name': userData['name'],
          'client_contact': userData['contact'],
          'client_message': userData['message'],
          'timestamp': FieldValue.serverTimestamp(),
          'status': 'new',
        });
        await _dialogService.showDialog(
            title: 'Success', description: 'Inquiry sent!');
      } finally {
        setBusy(false);
      }
    }
  }

  // --- SITE VISIT LOGIC ---
  Future<void> onScheduleVisitTap(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );
    if (pickedDate == null) return;

    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 0),
    );
    if (pickedTime == null) return;

    var response = await _dialogService.showCustomDialog(
      variant: DialogType.inquiry,
      title: 'Book Visit Details',
      data: 'Site Visit for Bungalow',
    );

    if (response?.confirmed == true && response?.data != null) {
      final userData = response!.data as Map<String, dynamic>;
      setBusy(true);
      try {
        await FirebaseFirestore.instance.collection('site_visits').add({
          'property_type': 'Bungalow',
          'visit_date': pickedDate.toIso8601String().split('T')[0],
          'visit_time': pickedTime.format(context),
          'client_name': userData['name'],
          'client_contact': userData['contact'],
          'timestamp': FieldValue.serverTimestamp(),
          'status': 'pending',
        });
        await _dialogService.showDialog(
            title: 'Confirmed',
            description: 'Visit request sent for Bungalow.');
      } finally {
        setBusy(false);
      }
    }
  }
}
