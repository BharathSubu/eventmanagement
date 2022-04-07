import 'package:flutter/material.dart';
import '../services/mycolor.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            title: Text("HOME"),
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),
          // drawer: MyNavigationDrawer(),
          body: Column(children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Center(
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Image.asset("assets/underconstruction.png")),
            ),
          ]),
        ));
  }
}
