import 'package:event_management/services/pushNotification.dart';
import 'package:event_management/views/chats/chat.dart';
import 'package:event_management/views/events/event.dart';
import 'package:event_management/views/events/eventHistory.dart';
import 'package:event_management/views/home.dart';
import 'package:event_management/views/login/googlesignin.dart';
import 'package:event_management/views/login/login.dart';
import 'package:event_management/views/login/loginpage.dart';
import 'package:event_management/views/news.dart';
import 'package:event_management/views/settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await PushNotificationService().setupInteractedMessage();
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => GoogleSignInProvider())],
    child: MyApp(),
  ));
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    // App received a notification when it was killed
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

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
        '/chats': (_) => MyChats("forum"),
        '/settings': (_) => MySettingsPage(),
      },
      home: Authpage(),
    );
  }
}
