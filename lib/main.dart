import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'services/navigation_service.dart';
import 'utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupFirebase();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ValueNotifier<bool> _isDarkModeNotifier = ValueNotifier<bool>(false);

  void _toggleTheme() {
    _isDarkModeNotifier.value = !_isDarkModeNotifier.value;
    print(
        "Theme toggled to ${_isDarkModeNotifier.value ? 'Dark Mode' : 'Light Mode'}");
  }

  @override
  void initState() {
    super.initState();
    registerServices(_toggleTheme, _isDarkModeNotifier);
  }

  @override
  Widget build(BuildContext context) {
    final NavigationService _navigationService =
        GetIt.instance<NavigationService>();

    return ValueListenableBuilder<bool>(
      valueListenable: _isDarkModeNotifier,
      builder: (context, isDarkMode, child) {
        return MaterialApp(
          title: 'EduGuide',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            brightness: Brightness.light,
            appBarTheme: AppBarTheme(
              color: Colors.blue.shade700,
            ),
          ),
          darkTheme: ThemeData(
            primarySwatch: Colors.brown,
            brightness: Brightness.dark,
            appBarTheme: AppBarTheme(
              color: Colors.brown.shade700,
            ),
          ),
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
          navigatorKey: _navigationService.navigatorKey,
          routes: _navigationService.routes,
          initialRoute: '/initial',
        );
      },
    );
  }
}
