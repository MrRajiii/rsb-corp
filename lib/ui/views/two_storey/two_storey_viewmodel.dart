import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rsbweb_v1/app/app.dialogs.dart'; // Ensure this is imported
import 'package:rsbweb_v1/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';

class TwoStoreyViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();

  void handleBack(bool canPop) {
    if (canPop) {
      navigationService.back();
    } else {
      // If the user refreshed, the stack is gone, so force return to Home
      navigationService.replaceWithHomeView();
    }
  }

  // --- INQUIRE NOW LOGIC ---
  Future<void> onInquireTap() async {
    var response = await _dialogService.showCustomDialog(
      variant: DialogType.inquiry,
      data: '2-Storey House',
    );

    if (response?.confirmed == true && response?.data != null) {
      final userData = response!.data as Map<String, dynamic>;

      if (userData['name'].isEmpty || userData['contact'].isEmpty) {
        await _dialogService.showDialog(
          title: "Error",
          description: "Please provide your name and contact info.",
        );
        return;
      }

      setBusy(true);
      try {
        await FirebaseFirestore.instance.collection('property_inquiries').add({
          'property': '2-Storey',
          'client_name': userData['name'],
          'client_contact': userData['contact'],
          'client_message': userData['message'],
          'timestamp': FieldValue.serverTimestamp(),
          'status': 'new',
        });

        await _dialogService.showDialog(
          title: 'Thank You!',
          description:
              'Your inquiry has been sent. RSB Corp will contact you shortly.',
        );
      } catch (e) {
        debugPrint("Firebase Error: $e");
      } finally {
        setBusy(false);
      }
    }
  }

  // --- SITE VISIT LOGIC ---
  Future<void> onScheduleVisitTap(BuildContext context) async {
    // 1. Pick Date
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );

    if (pickedDate == null) return;

    // 2. Pick Time
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 0),
    );

    if (pickedTime == null) return;

    // 3. Get Contact Info
    var response = await _dialogService.showCustomDialog(
      variant: DialogType.inquiry,
      title: 'Book Visit Details',
      data: 'Site Visit for 2-Storey',
    );

    if (response?.confirmed == true && response?.data != null) {
      final userData = response!.data as Map<String, dynamic>;

      setBusy(true);
      try {
        await FirebaseFirestore.instance.collection('site_visits').add({
          'property_type': '2-Storey',
          'visit_date': pickedDate.toIso8601String().split('T')[0],
          'visit_time': pickedTime.format(context),
          'client_name': userData['name'],
          'client_contact': userData['contact'],
          'timestamp': FieldValue.serverTimestamp(),
          'status': 'pending',
        });

        await _dialogService.showDialog(
          title: 'Visit Requested!',
          description:
              'Scheduled for ${pickedDate.day}/${pickedDate.month} at ${pickedTime.format(context)}. We will call you to confirm.',
        );
      } catch (e) {
        debugPrint("Firebase Error: $e");
      } finally {
        setBusy(false);
      }
    }
  }
}
