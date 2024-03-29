import 'package:event_management/drawer/navigationdrawer.dart';
import 'package:event_management/services/mycolor.dart';
import 'package:event_management/views/chats/messages_widget.dart';
import 'package:event_management/views/chats/new_message_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyEventChats extends StatefulWidget {
  final String forum;

  MyEventChats(this.forum);
  @override
  State<MyEventChats> createState() => _MyEventChatsState();
}

class _MyEventChatsState extends State<MyEventChats> {
  late var user;

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
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
            title: Text("CHAT"),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
          ),
          drawer: MyNavigationDrawer(),
          body: Column(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200.withOpacity(0.2),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: MessagesWidget(
                    idUser: user!.email.toString(),
                    forum: widget.forum,
                  ),
                ),
              ),
              NewMessageWidget(
                  idUser: user!.email.toString(),
                  profileurl: user!.photoURL.toString(),
                  username: user.displayName.toString(),
                  forum: widget.forum)
            ],
          ),
        ));
  }
}
