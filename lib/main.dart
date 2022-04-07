import 'package:event_management/views/chats/chat.dart';
import 'package:event_management/views/event.dart';
import 'package:event_management/views/eventHistory.dart';
import 'package:event_management/views/home.dart';
import 'package:event_management/views/login/googlesignin.dart';
import 'package:event_management/views/login/login.dart';
import 'package:event_management/views/login/loginpage.dart';
import 'package:event_management/views/news.dart';
import 'package:event_management/views/settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => GoogleSignInProvider())],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context)
                .textTheme, // If this is not set, then ThemeData.light().textTheme is used.
          ).apply(
            bodyColor: Colors.white,
            displayColor: Colors.blue,
          )),
      routes: {
        '/login': (_) => Login(),
        '/home': (_) => MyHomePage(),
        '/event': (_) => MyEventPage(),
        '/history': (_) => MyEventPageHistory(),
        '/news': (_) => MyNews(),
        '/chats': (_) => MyChats(),
        '/settings': (_) => MySettingsPage(),
      },
      home: Authpage(),
    );
  }
}
