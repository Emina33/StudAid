import 'package:flutter/material.dart';
import 'package:stud_aid/chat3.dart';
import 'package:stud_aid/home_page_ful.dart';
import 'package:stud_aid/main.dart';
import 'package:stud_aid/previous_reservations.dart';

import 'package:stud_aid/utils/util.dart';

import '../chat_list_ful.dart';
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
        MaterialPageRoute(builder: (context) => const ChatList2()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyProfilePage2(0)),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PreviousReservations()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Color.fromRGBO(103, 101, 78, 1),
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed,
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
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          label: 'Reservations',
        ),
      ],
      backgroundColor: const Color.fromRGBO(224, 221, 170, 1.0),
    );
  }
}
