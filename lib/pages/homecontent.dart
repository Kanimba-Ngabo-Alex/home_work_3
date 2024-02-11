import 'package:flutter/material.dart';
import 'package:home_work_3/pages/about.dart';
import 'package:home_work_3/pages/calc.dart';

class UserHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.grey,
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            children: [
              DrawerHeader(
                child: Center(
                  child: Text(
                    'MENU',
                    style: TextStyle(fontSize: 50),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.calculate),
                title: Text(
                  'Calculator',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Calculator()));
                },
              ),
              ListTile(
                leading: Icon(Icons.message),
                title: Text(
                  'About Me',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => UserAbout()));
                },
              )
            ],
          ),
        ),
      ),
      body: Center(
        child: Text(
          'Welcome',
          style: TextStyle(fontSize: 70),
        ),
      ),
    );
  }
}
