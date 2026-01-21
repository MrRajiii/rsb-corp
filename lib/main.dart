import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:rsbweb_v1/app/app.locator.dart';
import 'package:rsbweb_v1/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:rsbweb_v1/app/app.bottomsheets.dart';
import 'package:rsbweb_v1/app/app.dialogs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 2. This removes the "/#/" from the browser URL bar
  usePathUrlStrategy();

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
      title: 'RSB Corp',
      initialRoute: Routes.startupView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [StackedService.routeObserver],
      debugShowCheckedModeBanner: false,
    );
  }
}
