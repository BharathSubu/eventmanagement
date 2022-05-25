import 'dart:io';

import 'package:event_management/services/mycolor.dart';
import 'package:event_management/views/login/googlesignin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class MyNavigationDrawer extends StatefulWidget {
  @override
  State<MyNavigationDrawer> createState() => _MyNavigationDrawerState();
}

class _MyNavigationDrawerState extends State<MyNavigationDrawer> {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  final String fb = "https://m.facebook.com/100063772070560/";
  final String insta =
      "https://www.instagram.com/sriramakrishnaenggcollege/?hl=en";
  final String linkedin =
      "https://in.linkedin.com/school/sriramakrishnaenggcollege/";
  final String web = "https://www.srec.ac.in/";

  @override
  Widget build(BuildContext context) {
    void logout() {
      // final provider =
      //     Provider.of<GoogleSignInProvider>(context, listen: false);
      // provider.logout();
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else if (Platform.isIOS) {
            exit(0);
          }
        } else {
          final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
          provider.logout();
        }
      });
    }

    return Drawer(
      child: Stack(children: [
        Container(
          // color: Colors.black.withOpacity(0.25),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                Mycolor.secondary1,
                Mycolor.secondary2,
                Mycolor.secondary3
              ])),
          height: MediaQuery.of(context).size.height,
        ),
        Material(
          color: Colors.transparent,
          elevation: 0,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            padding: EdgeInsets.symmetric(horizontal: 10),
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
            child: ListView(shrinkWrap: true, children: [
              SizedBox(
                height: 20,
              ),
              buildMenuItem(
                text: 'Home',
                icon: Icons.home,
                onClicked: () => selectedItem(context, 0),
              ),
              buildMenuItem(
                text: 'Events',
                icon: Icons.calendar_today,
                onClicked: () => selectedItem(context, 1),
              ),
              buildMenuItem(
                text: 'History',
                icon: Icons.history,
                onClicked: () => selectedItem(context, 2),
              ),
              buildMenuItem(
                text: 'News',
                icon: Icons.analytics_rounded,
                onClicked: () => selectedItem(context, 3),
              ),
              buildMenuItem(
                text: 'Forum',
                icon: Icons.chat,
                onClicked: () => selectedItem(context, 4),
              ),
              buildMenuItem(
                text: 'Settings',
                icon: Icons.settings,
                onClicked: () => selectedItem(context, 5),
              ),
              // buildMenuItem(
              //   text: 'Log Out',
              //   icon: Icons.logout,
              //   onClicked: logout,
              // ),
            ]),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.07,
          child: buildHeader(
            context: context,
          ),
        ),
        Positioned(
            bottom: MediaQuery.of(context).size.height * 0.025,
            child: outTour(context: context))
      ]),
    );
  }

  Widget buildHeader({required BuildContext context
          // required VoidCallback onClicked,
          }) =>
      Row(children: [
        SizedBox(
          width: 10,
        ),
        Container(
            margin: padding,
            height: MediaQuery.of(context).size.height * 0.17,
            width: MediaQuery.of(context).size.width * 0.65,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/applogo2.png"),
              ),
            )),
      ]);

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final selectColor = Colors.white;

    return InkWell(
      onTap: onClicked,
      child: Container(
        padding: padding,
        margin: EdgeInsets.all(15),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: selectColor,
                size: 30,
              ),
              SizedBox(
                width: 15,
              ),
              Text(text,
                  style: TextStyle(
                      color: selectColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: Colors.white70,
            thickness: 4,
            height: 0,
          ),
        ]),
      ),
    );
  }

  Widget outTour({required BuildContext context}) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(),
        width: MediaQuery.of(context).size.width * 0.8,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Text(
              "Follow SREC",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.67,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      height: 60,
                      width: 60,
                      child: InkWell(
                          onTap: () async {
                            if (!await launch(linkedin))
                              throw 'Could not launch $linkedin';
                          },
                          child: Image.asset("assets/linkedin.png"))),
                  Container(
                      height: 60,
                      width: 60,
                      child: InkWell(
                          onTap: () async {
                            if (!await launch(insta))
                              throw 'Could not launch $insta';
                          },
                          child: Image.asset("assets/insta.png"))),
                  Container(
                      height: 60,
                      width: 60,
                      child: InkWell(
                          onTap: () async {
                            if (!await launch(fb)) throw 'Could not launch $fb';
                          },
                          child: Image.asset("assets/facebook.png"))),
                  Container(
                      height: 60,
                      width: 60,
                      child: InkWell(
                          onTap: () async {
                            if (!await launch(web))
                              throw 'Could not launch $web';
                          },
                          child: Image.asset("assets/web.png"))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).pushReplacementNamed("/home");
        break;
      case 1:
        Navigator.of(context).pushReplacementNamed("/event");
        break;
      case 2:
        Navigator.of(context).pushReplacementNamed("/history");
        break;
      case 3:
        Navigator.of(context).pushReplacementNamed("/news");
        break;
      case 4:
        Navigator.of(context).pushReplacementNamed("/chats");
        break;
      case 5:
        Navigator.of(context).pushReplacementNamed("/settings");
        break;
    }
  }
}
