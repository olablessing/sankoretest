import 'package:flutter/material.dart';
import 'package:sankoreassesmenttest/screens/contact.dart';
// import 'package:sankoreassesmenttest/screens/contacts_page.dart';
import 'package:sankoreassesmenttest/screens/message.dart';
import 'package:sankoreassesmenttest/screens/news.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    MessagesPage(),
    ContactPage(),
    NewsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message_outlined,
              // color: kGoodLightGray,
            ),
            label: 'Message',
            activeIcon: Icon(
              Icons.message,
              // color: kGoodPurple,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
              // color: kGoodLightGray,
            ),
            // title: Text('CALENDAR'),
            label: 'Contacts',
            activeIcon: Icon(
              Icons.person,
              // color: kGoodPurple,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.dashboard_customize_outlined,
              // color: kGoodLightGray,
              size: 36,
            ),
            label: 'News',
            activeIcon: Icon(
              Icons.dashboard_customize,
              // color: kGoodPurple,
              size: 36,
            ),
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
