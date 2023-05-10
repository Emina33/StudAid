import 'package:flutter/material.dart';
import 'package:stud_aid/chat_list.dart';
import 'package:stud_aid/home_page_ful.dart';
import 'package:stud_aid/main.dart';
import 'package:stud_aid/my_profile_page.dart';
import 'package:stud_aid/search_page.dart';
import 'package:stud_aid/utils/util.dart';

import '../my_profile_page_ful.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePageNew()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ChatListPage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyProfilePage2(Authorization.id)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: const Color.fromRGBO(20, 30, 39, 1.0),
      onTap: _onItemTapped,
      currentIndex: _selectedIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_rounded),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_pin_rounded),
          label: 'Profile',
        ),
      ],
      backgroundColor: const Color.fromRGBO(224, 221, 170, 1.0),
    );
  }
}
