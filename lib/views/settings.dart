import 'package:event_management/drawer/navigationdrawer.dart';
import 'package:event_management/services/mycolor.dart';
import 'package:event_management/views/login/googlesignin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'dart:io' show Platform, exit;
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MySettingsPage extends StatefulWidget {
  @override
  State<MySettingsPage> createState() => _MySettingsPageState();
}

class _MySettingsPageState extends State<MySettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
//   Widget StreamBuilder(
//   stream: context.watch<Stream<FirebaseUser>>(),
//   builder: (context, snapshot) {
//     ...
//   },
// );
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    // void logout() {
    //   final provider =
    //       Provider.of<GoogleSignInProvider>(context, listen: false);
    //   provider.logout();
    // }

    void logout() {
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

    return WillPopScope(
        onWillPop: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/home', (Route<dynamic> route) => false);
          ;
          return Future.value(false);
        },
        child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                  Mycolor.secondary1,
                  Mycolor.secondary2,
                  Mycolor.secondary3
                ])),
            child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  title: Text("SETTINGS"),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                ),
                drawer: MyNavigationDrawer(),
                body: StreamProvider(
                    create: (_) => FirebaseAuth.instance.authStateChanges(),
                    initialData: null,
                    child: Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          buildHeader(
                            urlImage: user!.photoURL.toString(),
                            name: user.displayName.toString(),
                            email: user.email.toString(),
                            context: context,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 25),
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(
                                      color: Colors.white,
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                              ),
                              child: Row(children: [
                                Container(
                                    height: 70,
                                    child: Icon(
                                      Icons.logout,
                                      color: Colors.black,
                                    )),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'LogOut',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ]),
                              onPressed: () async {
                                logout();
                              },
                            ),
                          ),
                        ]))))));
  }
}

Widget buildHeader(
        {required String urlImage,
        required String name,
        required String email,
        required BuildContext context}) =>
    Container(
      margin: EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Card(
        color: Colors.grey.shade200.withOpacity(0.5),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 10,
              ),
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  Text(
                    email,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
