import 'package:flutter/material.dart';
import 'package:home_work_3/pages/about.dart';
import 'package:home_work_3/pages/calc.dart';
import 'package:provider/provider.dart';
import 'package:home_work_3/theme/theme_provider.dart';
import 'package:home_work_3/components/button.dart';

class UserHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Home',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.grey,
          centerTitle: true,
        ),
        drawer: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Theme',
                      style: TextStyle(
                          color: themeProvider
                              .themeData.textTheme.bodyText1!.color),
                    ),
                    MyButton(
                      icon: Icon(Icons.settings),
                      color: Colors.red,
                      onTap: () {
                        Provider.of<ThemeProvider>(context, listen: false)
                            .toggleTheme();
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
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
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Calculator()));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text(
                        'About Me',
                        style: TextStyle(fontSize: 20),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => UserAbout()));
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Center(
          child: Text(
            'Welcome',
            style: TextStyle(fontSize: 70),
          ),
        ),
      );
    });
  }
}
