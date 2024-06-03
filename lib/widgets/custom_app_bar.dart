import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/media_service.dart';
import 'package:chat_app/services/storage_service.dart';
import 'package:chat_app/services/database_service.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  CustomAppBar({required this.toggleTheme, required this.isDarkMode});

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  final AuthService _authService = GetIt.instance.get<AuthService>();
  final MediaService _mediaService = GetIt.instance.get<MediaService>();
  final StorageService _storageService = GetIt.instance.get<StorageService>();
  final DatabaseService _databaseService =
      GetIt.instance.get<DatabaseService>();

  Future<void> _changeProfilePhoto(BuildContext context) async {
    final FilePickerResult? result = await _mediaService.pickFile();
    if (result != null && result.files.single.path != null) {
      File file = File(result.files.single.path!);
      String? downloadURL = await _storageService.uploadUserPfp(
        file: file,
        uid: _authService.user!.uid,
      );

      if (downloadURL != null) {
        // Update the profile photo URL in the database
        await _databaseService.updateUserProfilePhoto(downloadURL);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = _authService.user;
    print("Building AppBar with isDarkMode: ${widget.isDarkMode}");

    return AppBar(
      leading: Container(
        padding: EdgeInsets.only(left: 10),
        width: 55,
        child: ClipOval(
          child: Image.asset(
            'assets/images/lightbulb.jpg',
            width: 45.0,
            height: 45.0,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: const Text('Eduguibet'),
      actions: [
        if (user != null)
          PopupMenuButton<int>(
            icon: CircleAvatar(
              backgroundImage: NetworkImage(
                user.photoURL ?? 'https://via.placeholder.com/150',
              ),
            ),
            onSelected: (item) => _onSelected(context, item),
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                value: 0,
                child: Text('Change Profile Photo'),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Text(widget.isDarkMode ? 'Light Mode' : 'Dark Mode'),
              ),
              const PopupMenuItem<int>(value: 2, child: Text('Logout')),
            ],
          )
        else
          const SizedBox.shrink(), // Or any other placeholder widget
      ],
    );
  }

  void _onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        _changeProfilePhoto(context);
        break;
      case 1:
        print("Toggling theme from ${widget.isDarkMode}...");
        widget.toggleTheme();
        break;
      case 2:
        _authService.logout();
        Navigator.of(context).pushReplacementNamed('/login');
        break;
    }
  }
}
