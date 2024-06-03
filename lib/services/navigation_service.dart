import 'package:flutter/material.dart';
import 'package:chat_app/pages/home.dart';
import 'package:chat_app/pages/chat_list.dart';
import 'package:chat_app/pages/initial_page.dart';
import 'package:chat_app/pages/login_pages.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/pages/to_atttendance.dart';

class NavigationService {
  late GlobalKey<NavigatorState> _navigatorKey;
  final Map<String, Widget Function(BuildContext)> _routes;

  NavigationService(
      VoidCallback toggleTheme, ValueNotifier<bool> isDarkModeNotifier)
      : _routes = {
          "/login": (context) => const LoginPage(),
          "/register": (context) => const RegisterPage(),
          "/chatlist": (context) => const ChatListPage(),
          "/home": (context) => Home(
              toggleTheme: toggleTheme, isDarkModeNotifier: isDarkModeNotifier),
          "/initial": (context) => InitialScreen(),
          "/toattendance": (context) => const AttendanceFormPage(),
        } {
    _navigatorKey = GlobalKey<NavigatorState>();
  }

  GlobalKey<NavigatorState>? get navigatorKey {
    return _navigatorKey;
  }

  Map<String, Widget Function(BuildContext)> get routes {
    return _routes;
  }

  void push(MaterialPageRoute route) {
    _navigatorKey.currentState?.push(route);
  }

  void pushNamed(String routeName) {
    _navigatorKey.currentState?.pushNamed(routeName);
  }

  void pushNamedWithArguments(
      String routeName, Map<String, dynamic> arguments) {
    _navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  void pushReplacementNamed(String routeName) {
    _navigatorKey.currentState?.pushReplacementNamed(routeName);
  }

  void goBack() {
    _navigatorKey.currentState?.pop();
  }
}
