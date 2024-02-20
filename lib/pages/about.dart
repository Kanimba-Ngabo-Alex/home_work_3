import 'package:flutter/material.dart';
import 'package:home_work_3/pages/calc.dart';
import 'package:home_work_3/pages/navbar.dart';
import 'package:provider/provider.dart';
import 'package:home_work_3/theme/theme_provider.dart';

class UserAbout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.grey,
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return Container(
              color: themeProvider.themeData.backgroundColor,
              child: ListView(
                children: [
                  DrawerHeader(
                    child: Center(
                      child: Text(
                        'MENU',
                        style: TextStyle(
                          fontSize: 50,
                          color: themeProvider
                              .themeData.textTheme.bodyText1!.color,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text(
                      'Home',
                      style: TextStyle(
                        fontSize: 20,
                        color:
                            themeProvider.themeData.textTheme.bodyText1!.color,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.calculate),
                    title: Text(
                      'Calculator',
                      style: TextStyle(
                        fontSize: 20,
                        color:
                            themeProvider.themeData.textTheme.bodyText1!.color,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Calculator()),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
      body: Text(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at risus neque. Donec posuere ornare arcu, non faucibus neque commodo ac. Phasellus aliquam aliquam magna at accumsan. Cras bibendum nulla libero, sed imperdiet dui lacinia sed. Nulla facilisi. Mauris facilisis turpis quis nulla euismod varius. Sed pharetra leo vel arcu tempor, et aliquam mauris fringilla. Nullam sit amet tristique justo. Suspendisse ac tempor velit. Nam pharetra, dui vitae consequat suscipit, nibh est fermentum mauris, in molestie libero nulla non justo. Duis ut dapibus nulla. Vivamus ut arcu et diam scelerisque viverra.',
        style: TextStyle(fontSize: 10),
      ),
    );
  }
}
