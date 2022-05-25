import 'package:event_management/services/mycolor.dart';
import 'package:event_management/views/chats/eventchat.dart';
import 'package:event_management/views/events/afterevent.dart';
import 'package:event_management/views/events/cardimageview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class MyCardView extends StatefulWidget {
  final String index,
      imageUrl,
      title,
      description,
      date,
      regUrl,
      host,
      tag,
      eventresult;
  var gallery;
  MyCardView(
      {required this.index,
      required this.imageUrl,
      required this.title,
      required this.description,
      required this.date,
      required this.regUrl,
      required this.host,
      required this.tag,
      required this.eventresult,
      required this.gallery});

  @override
  State<MyCardView> createState() => _MyCardViewState();
}

class _MyCardViewState extends State<MyCardView> {
  late FlutterLocalNotificationsPlugin fltrNotification;
  @override
  void initState() {
    super.initState();
    var androidInitilize =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSinitilize = new IOSInitializationSettings();
    var initilizationsSettings = new InitializationSettings(
        android: androidInitilize, iOS: iOSinitilize);
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initilizationsSettings);
  }

  Future _showScheduledNotification(
      int index, String title, String description, DateTime date) async {
    var androidDetails = new AndroidNotificationDetails(
        "Channel ID", "Mlsc Updates",
        channelDescription: "This is my channel", importance: Importance.max);
    var iSODetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iSODetails);
    var scheduledTime = date.add(Duration(hours: 9));
    var berforescheduledTime = date.subtract(Duration(hours: 6));
    fltrNotification.schedule(index, title, "Event Begins Today", scheduledTime,
        generalNotificationDetails);
    fltrNotification.schedule(index + 100, title, "Event Begins Tomorrow",
        berforescheduledTime, generalNotificationDetails);
  }

  bool onnotifydart = false;
  bool shownotify = true;
  @override
  Widget build(BuildContext context) {
    DateTime parseDate = new DateFormat("dd-MM-yyyy").parse(widget.date);
    DateTime currentDate = DateTime.now().subtract(Duration(hours: 24));
    if (parseDate.compareTo(currentDate) < 0) {
      setState(() {
        shownotify = false;
      });
    }
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
              title: Text("${widget.title}"),
              centerTitle: true,
              backgroundColor: Colors.transparent,
            ),
            body: Container(
              margin: EdgeInsets.all(
                MediaQuery.of(context).size.width * 0.03,
              ).copyWith(top: MediaQuery.of(context).size.height * 0.01),
              child: Column(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyCardImageView(
                                      imageUrl: widget.imageUrl,
                                    )));
                      },
                      child: Card(
                        elevation: 5,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: widget.imageUrl,
                          placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(
                            valueColor:
                                new AlwaysStoppedAnimation<Color>(Colors.cyan),
                          )),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ),
                      )),
                  Stack(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16).copyWith(bottom: 0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Container(
                                    padding: EdgeInsets.only(right: 5),
                                    margin: EdgeInsets.only(right: 5),
                                    child: Text(
                                      widget.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16).copyWith(bottom: 0),
                          child: Row(children: [
                            Text(
                              "Event Date : ",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.date,
                              style: TextStyle(fontSize: 16),
                            )
                          ]),
                        ),
                      ],
                    ),
                    if (shownotify)
                      Positioned(
                        top: 25,
                        right: 5,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(70),
                          onTap: () {
                            setState(() {
                              onnotifydart = true;
                            });
                            Fluttertoast.showToast(
                                msg: "Notification Enabled",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey[600],
                                textColor: Colors.white,
                                fontSize: 16.0);
                            var sdate = widget.date;
                            DateTime parseDate =
                                new DateFormat("dd-MM-yyyy").parse(sdate);
                            print(parseDate);
                            _showScheduledNotification(
                                int.parse(widget.index) % 1000000,
                                widget.title,
                                widget.description,
                                parseDate);
                          },
                          child: Icon(
                            onnotifydart
                                ? Icons.notifications_active_sharp
                                : Icons.notification_add,
                            color: Mycolor.textcolor,
                            size: 40,
                          ),
                        ),
                      )
                  ]),
                  Padding(
                    padding: EdgeInsets.all(16).copyWith(bottom: 0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Hosted By : ${widget.host}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ]),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16).copyWith(bottom: 0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Description :-",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ]),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16).copyWith(bottom: 0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text(
                          widget.description,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (shownotify)
                    Row(children: [
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
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
                          child: Text(
                            'Register Here!',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          onPressed: () async {
                            if (!await launch(widget.regUrl))
                              throw 'Could not launch ${widget.regUrl}';
                          },
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.04,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
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
                          child: Text(
                            'Queries Here!',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MyEventChats(widget.index)));
                          },
                        ),
                      ),
                    ]),
                  if (!shownotify)
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(
                                color: Colors.white,
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                        child: Text(
                          'See Event Report!',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AfterEvent(
                                        eventresult: widget.eventresult,
                                        gallery: widget.gallery,
                                        index: widget.index,
                                      )));
                        },
                      ),
                    ),
                ],
              ),
            )));
  }
}
