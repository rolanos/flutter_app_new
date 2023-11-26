// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_app_new/explore/view/page/explore_page.dart';
import 'package:flutter_app_new/favourite/view/favorite_page.dart';
import 'package:flutter_app_new/home/view/page/home_page.dart';
import 'package:flutter_app_new/profile/view/profile_page.dart';

class BottomBarPage extends StatefulWidget {
  final String userProfileName;
  final String userProfileEmail;

  const BottomBarPage(
      {Key? key, required this.userProfileName, required this.userProfileEmail})
      : super(key: key);

  @override
  _BottomBarPageState createState() => _BottomBarPageState();
}

class _BottomBarPageState extends State<BottomBarPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _buildPage(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
            backgroundColor: Color.fromRGBO(67, 67, 67, 1),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Изучение',
            backgroundColor: Color.fromRGBO(67, 67, 67, 1),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Избранное',
            backgroundColor: Color.fromRGBO(67, 67, 67, 1),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
            backgroundColor: Color.fromRGBO(67, 67, 67, 1),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return const ExplorePage();
      case 2:
        return const FavoritePage();
      case 3:
        return const ProfilePage();
      default:
        return Container();
    }
  }
}
