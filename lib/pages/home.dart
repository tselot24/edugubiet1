import 'package:chat_app/pages/chat_list.dart';
import 'package:chat_app/pages/to_atttendance.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:chat_app/services/navigation_service.dart';
import 'package:chat_app/widgets/custom_app_bar.dart';

class Home extends StatefulWidget {
  final VoidCallback toggleTheme;
  final ValueNotifier<bool> isDarkModeNotifier;

  Home({Key? key, required this.toggleTheme, required this.isDarkModeNotifier})
      : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final NavigationService _navigationService =
      GetIt.instance<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.isDarkModeNotifier,
      builder: (context, isDarkMode, child) {
        print("Home widget building with isDarkMode: $isDarkMode");

        return Scaffold(
          appBar: CustomAppBar(
              toggleTheme: widget.toggleTheme, isDarkMode: isDarkMode),
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      top: 170, bottom: 20, left: 25, right: 25),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Empower your teaching journey with EduGuide\'s mobile app. Seamlessly manage classes, engage with parents, and explore innovative teaching tools at your fingertips.',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    padding: const EdgeInsets.all(10),
                    children: [
                      _buildGridItem(Icons.assignment, 'Report', () {
                        /* print('Report button tapped'); */
                      }),
                      _buildGridItem(Icons.summarize, 'Summarize', () {
                        /* print('Summarize button tapped'); */
                      }),
                      _buildGridItem(Icons.grade, 'Submit Grade', () {
                        /* print('Submit Grade button tapped'); */
                      }),
                      _buildGridItem(Icons.assignment_turned_in, 'Attendance',
                          () {
                        _navigationService.push(
                          MaterialPageRoute(
                            builder: (context) {
                              return const AttendanceFormPage();
                            },
                          ),
                        );
                      }),
                      _buildGridItem(Icons.chat, 'Chat', () {
                        _navigationService.push(
                          MaterialPageRoute(
                            builder: (context) {
                              return const ChatListPage();
                            },
                          ),
                        );
                      }),
                      _buildGridItem(Icons.announcement, 'Announcement', () {
                        /* print('Announcement button tapped'); */
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildGridItem(IconData icon, String label, void Function() onTap) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: onTap,
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: Colors.blue,
              size: 40,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(label),
      ],
    );
  }
}
