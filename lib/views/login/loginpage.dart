import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:event_management/services/mycolor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import './googlesignin.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Mycolor.secondary1,
              Mycolor.secondary2,
              Mycolor.secondary1,
            ]),
      ),
      child: Stack(
        children: [
          Positioned(
              top: height / 90,
              left: width / 10,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/mlscLogo.png'),
                  ),
                ),
              )),
          Positioned(
            top: height / 3,
            left: width / 10,
            child: Text(
              "        Microsoft Learn \n Student Ambassadors",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
              top: height / 2.2,
              left: width / 4,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/srecLogo.png'),
                  ),
                ),
              )),
          Positioned(
            bottom: height / 8,
            left: width / 10,
            child: BouncingWidget(
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.googleLogin();
              },
              // stayOnBottom: true,
              child: SizedBox(
                height: 60,
                width: width / 1.2,
                child: Card(
                  elevation: 20,
                  child: Stack(
                    children: [
                      Positioned(
                        top: MediaQuery.of(context).size.width * 0.03,
                        left: MediaQuery.of(context).size.width * 0.04,
                        child: FaIcon(
                          FontAwesomeIcons.google,
                          color: Colors.orange,
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.width * 0.03,
                        left: MediaQuery.of(context).size.width * 0.2,
                        child: Text(
                          "Continue with google",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              bottom: height / 14,
              left: width / 6,
              child: Row(
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      provider.googleLogin();
                    },
                    child: Text(
                      "LOGIN",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                      ),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
