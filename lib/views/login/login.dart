import 'package:event_management/views/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'googlesignin.dart';
import 'loginpage.dart';

class Authpage extends StatelessWidget {
  const Authpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
          body: ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            final provider = Provider.of<GoogleSignInProvider>(context);
            if (provider.isSigningIn) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              return MyHomePage();
            } else {
              return Login();
            }
          },
        ),
      ));
}
