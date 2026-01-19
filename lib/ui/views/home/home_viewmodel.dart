import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final ScrollController scrollController = ScrollController();

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
    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty) {
      return;
    }

    setBusy(true);

    try {
      await FirebaseFirestore.instance.collection('consultations').add({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'type': typeController.text.trim(),
        'budget': budgetController.text.trim(),
        'timestamp': FieldValue.serverTimestamp(),
      });

      nameController.clear();
      emailController.clear();
      typeController.clear();
      budgetController.clear();
      messageController.clear();
    } catch (e) {
      debugPrint("Error saving to Firebase: $e");
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
