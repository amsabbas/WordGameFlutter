import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:word_game/home/screen/home_screen.dart';
import 'base/injection/general_injection.dart';
import 'base/language/language.dart';
import 'base/style/theme.dart';

void main() async {
  // NOTE: This is required for accessing the method channel before runApp().
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  await initGeneralInjection();
  runApp(const MyApp());
}

void run() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    setLocale(const Locale("ar"));
    return GetMaterialApp(
      locale: _locale,
      debugShowCheckedModeBanner: false,
      translations: Language(),
      home: const HomeScreen(),
      theme: CustomTheme.lightTheme,
    );
  }
}
