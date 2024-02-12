import 'package:home_work_3/pages/about.dart';
import 'package:home_work_3/pages/calc.dart';
import 'package:home_work_3/pages/homecontent.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _SelectedIndex = 0;
  void navigatedBar(int index) {
    setState(() {
      _SelectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    UserHome(),
    Calculator(),
    UserAbout(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_SelectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _SelectedIndex,
        onTap: navigatedBar,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calculate_rounded), label: 'Calculator'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'About me'),
        ],
      ),
    );
  }
}
