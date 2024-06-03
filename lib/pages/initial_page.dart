import 'package:chat_app/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class InitialScreen extends StatelessWidget {
  InitialScreen({super.key});
  final NavigationService _navigationService =
      GetIt.instance<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 40),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/lightbulb.jpg',
                  width: 150.0,
                  height: 150.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Text(
              'Choose your role',
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _navigationService.pushReplacementNamed("/login");
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/parent.png",
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text('Parent'),
                    ],
                  ),
                ),
                const SizedBox(width: 40),
                ElevatedButton(
                  onPressed: () {
                    _navigationService.pushReplacementNamed("/login");
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/teacher.png",
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text('Teacher'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
