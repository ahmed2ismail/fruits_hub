import 'package:flutter/material.dart';
import 'package:fruits_hub/core/helper/functions/on_generate_routes.dart';
import 'package:fruits_hub/core/services/shared_preferences_singleton.dart';
import 'package:fruits_hub/features/splash/presentation/view/splash_view.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

void main() async {
  // Ensure that the Flutter binding is initialized before calling any platform-specific code.
  // This is crucial because `SharedPreferencesSingleton.init()` is called before `runApp()`.
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.init();

  runApp(const FruitHub());
}

class FruitHub extends StatelessWidget {
  const FruitHub({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: const Locale('ar'),

      debugShowCheckedModeBanner: false,
      title: 'Fruit Hub',
      theme: ThemeData(fontFamily: 'Cairo'),
      onGenerateRoute: onGenerateRoute,
      initialRoute: SplashView.routeName,
    );
  }
}
