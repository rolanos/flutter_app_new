import 'package:flutter/material.dart';

class ProfileInfoPage extends StatelessWidget {
  final String userProfileName;
  final String userProfileEmail;

  const ProfileInfoPage({
    Key? key,
    required this.userProfileName,
    required this.userProfileEmail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Профиль"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Имя: $userProfileName"),
            Text("Email: $userProfileEmail"),
          ],
        ),
      ),
    );
  }
}
