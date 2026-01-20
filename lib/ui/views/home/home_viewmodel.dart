import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rsbweb_v1/app/app.locator.dart';
import 'package:rsbweb_v1/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final ScrollController scrollController = ScrollController();
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();

  // Form Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();
  // Animation & Header State
  bool _isScrolled = false;
  bool get isScrolled => _isScrolled;

  // Track which sections have been seen to trigger animations once
  final Map<String, bool> _revealedSections = {
    'hero': true,
    'about': false,
    'models': false,
    'contact': false,
  };

  bool isSectionVisible(String section) => _revealedSections[section] ?? false;

  // GlobalKeys for Smooth Scrolling
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey modelsKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  HomeViewModel() {
    scrollController.addListener(_onScroll);
  }
  void navigateToFinishedProjects() {
    _navigationService.navigateToFinishedProjectsView();
  }

  void navigateToBungalow() {
    _navigationService.navigateToBungalowView();
  }

  void navigateToTwoStorey() {
    _navigationService.navigateToTwoStoreyView();
  }

  void navigateToConstruction() {
    _navigationService.navigateToConstructionWorksView();
  }

  // Also add one for Interior while we're at it
  void navigateToInterior() {
    _navigationService.navigateToInteriorDesignView();
  }

  void _onScroll() {
    // 1. Sticky Header Logic
    if (scrollController.offset > 80 && !_isScrolled) {
      _isScrolled = true;
      notifyListeners();
    } else if (scrollController.offset <= 80 && _isScrolled) {
      _isScrolled = false;
      notifyListeners();
    }

    // 2. Reveal Sections Logic (Animations)
    _checkSectionReveal('about', aboutKey);
    _checkSectionReveal('models', modelsKey);
    _checkSectionReveal('contact', contactKey);
  }

  void _checkSectionReveal(String name, GlobalKey key) {
    if (_revealedSections[name] == true) return;

    final context = key.currentContext;
    if (context != null) {
      final box = context.findRenderObject() as RenderBox;
      final position = box.localToGlobal(Offset.zero).dy;
      if (position < scrollController.position.viewportDimension + 200) {
        _revealedSections[name] = true;
        notifyListeners();
      }
    }
  }

  void scrollToSection(GlobalKey key) {
    if (key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  Future<void> submitForm() async {
    // 1. Only block if the CRITICAL info is missing
    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty) {
      // Optional: Show a quick dialog telling them to fill the name/email
      await _dialogService.showDialog(
        title: 'Missing Info',
        description:
            'Please provide at least your name and email so we can reach you.',
      );
      return;
    }

    setBusy(true);

    try {
      await FirebaseFirestore.instance.collection('consultations').add({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'type': typeController.text.trim(),
        'budget': budgetController.text.trim(),
        'message': messageController.text
            .trim(), // Will be empty string if not provided
        'timestamp': FieldValue.serverTimestamp(),
      });

      nameController.clear();
      emailController.clear();
      typeController.clear();
      budgetController.clear();
      messageController.clear();

      await _dialogService.showDialog(
        title: 'Success!',
        description:
            'Your inquiry has been sent to RSB Corp. We will get back to you soon!',
        buttonTitle: 'OK',
      );
    } catch (e) {
      debugPrint("Error saving to Firebase: $e");
      await _dialogService.showDialog(
        title: 'Error',
        description: 'Failed to send inquiry. Please check your connection.',
      );
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }

  // --- GALLERY DATA PROVIDER ---
  // This takes only the category string and returns the list of image paths.
  List<String> getGalleryImages(String category) {
    if (category == "Bungalow") {
      return [
        'assets/images/bungalow/img1.jpg',
        'assets/images/bungalow/img2.jpg',
        'assets/images/bungalow/img3.jpg',
        'assets/images/bungalow/img4.jpg',
      ];
    } else {
      return [
        'assets/images/2storey/img1.jpg',
        'assets/images/2storey/img2.jpg',
        'assets/images/2storey/img3.jpg',
        'assets/images/2storey/img4.jpg',
      ];
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    scrollController.dispose();
    typeController.dispose();
    budgetController.dispose();
    super.dispose();
  }
}
