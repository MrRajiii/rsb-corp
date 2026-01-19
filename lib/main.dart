import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // 1. Added Import
import 'firebase_options.dart'; // 2. Added Generated Options Import
import 'package:rsbweb_v1/app/app.bottomsheets.dart';
import 'package:rsbweb_v1/app/app.dialogs.dart';
import 'package:rsbweb_v1/app/app.locator.dart';
import 'package:rsbweb_v1/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 3. Initialize Firebase before anything else
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.startupView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [StackedService.routeObserver],
    );
  }
}
