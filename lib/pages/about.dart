import 'package:flutter/material.dart';
import 'package:midsem/pages/calc.dart';
import 'package:midsem/pages/navbar.dart';
import 'package:provider/provider.dart';
import 'package:midsem/theme/theme_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UserAbout extends StatefulWidget {
  @override
  _UserAbout createState() => _UserAbout();
}

void signUserOut() {
  FirebaseAuth.instance.signOut();
}

class _UserAbout extends State<UserAbout> {
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }

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
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: Icon(Icons.logout),
          )
        ],
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at risus neque. Donec posuere ornare arcu, non faucibus neque commodo ac. Phasellus aliquam aliquam magna at accumsan. Cras bibendum nulla libero, sed imperdiet dui lacinia sed. Nulla facilisi. Mauris facilisis turpis quis nulla euismod varius. Sed pharetra leo vel arcu tempor, et aliquam mauris fringilla. Nullam sit amet tristique justo. Suspendisse ac tempor velit. Nam pharetra, dui vitae consequat suscipit, nibh est fermentum mauris, in molestie libero nulla non justo. Duis ut dapibus nulla. Vivamus ut arcu et diam scelerisque viverra.',
                style: TextStyle(fontSize: 10),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  imageProfile(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundImage: _imageFile == null
              ? AssetImage("lib/images/658920_v9_bb.jpg")
                  as ImageProvider<Object>
              : FileImage(File(_imageFile!.path)) as ImageProvider<Object>,
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context, builder: ((builder) => bottomSheet()));
            },
            child: Icon(
              Icons.camera_alt,
              color: Colors.teal,
              size: 28.0,
            ),
          ),
        )
      ]),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile Photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              ElevatedButton.icon(
                icon: Icon(Icons.camera),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                label: Text("Camera"),
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.photo),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                label: Text("Gallery"),
              )
            ],
          )
        ],
      ),
    );
  }
}
