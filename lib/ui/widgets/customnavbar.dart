import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class CustomNavBar extends StatefulWidget {
  @override
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int _currentIndex = 0;

  final List<String> _pageRoutes = [
    '/',
    '/persons',
    '/projects'
        '/linkedprojects',
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
          Navigator.pushNamed(context, _pageRoutes[index]);
        });
      },
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: Colors.grey,
      unselectedLabelStyle:
          const TextStyle(color: Color.fromARGB(255, 24, 20, 20)),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Persons',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category),
          label: 'Projects',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.link_rounded),
          label: 'Linked',
        ),
      ],
    );
  }
}
