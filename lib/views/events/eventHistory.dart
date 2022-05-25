import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management/drawer/navigationdrawer.dart';
import 'package:event_management/services/crud.dart';
import 'package:event_management/services/mycolor.dart';
import 'package:event_management/views/events/card.dart';
import 'package:event_management/views/events/create_post.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class MyEventPageHistory extends StatefulWidget {
  @override
  _MyEventPageHistoryState createState() => _MyEventPageHistoryState();
}

class _MyEventPageHistoryState extends State<MyEventPageHistory> {
  CrudMethods crudMethods = new CrudMethods();
  Stream<QuerySnapshot>? postsStream;
  bool onselectTech = true;
  var selectedDate = "";
  bool onselectNTech = false;

  void _presentDatePicker() {
    showMonthPicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2025),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
        print("Selected Date : ${selectedDate}");
      });
    });
    print('...');
  }

  Widget PostList() {
    return WillPopScope(
        onWillPop: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/home', (Route<dynamic> route) => false);
          ;
          return Future.value(false);
        },
        child: SingleChildScrollView(
          child: postsStream != null
              ? Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 20, left: 20),
                      height: 70,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              selectedDate == ""
                                  ? 'No Date Chosen!'
                                  : 'Search Event: ${selectedDate}',
                            ),
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              'Choose Date',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Mycolor.black),
                            ),
                            onPressed: _presentDatePicker,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    StreamBuilder<QuerySnapshot>(
                        stream: postsStream,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError)
                            return Text('Error = ${snapshot.error}');
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Colors.cyan)),
                            );
                          }
                          final document = snapshot.data!.docs;
                          return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              itemCount: document.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                Map<String, dynamic> data = document[index]
                                    .data()! as Map<String, dynamic>;
                                print("tag ${data['tag']}");
                                DateTime parseDate =
                                    new DateFormat("dd-MM-yyyy")
                                        .parse(data['date']);
                                DateTime currentDate = DateTime.now()
                                    .subtract(Duration(hours: 24));
                                print(parseDate.compareTo(currentDate) > 0);
                                if (parseDate.compareTo(currentDate) < 0) {
                                  if (selectedDate == "")
                                    return MyCard(
                                      index: data['index'],
                                      imageUrl: data['imgUrl'],
                                      title: data['title'],
                                      description: data['desc'],
                                      date: data['date'],
                                      regUrl: data['regUrl'],
                                      tag: data['tag'],
                                      host: data['host'],
                                      eventresult: data['eventresult'],
                                      gallery: data['gallery'],
                                    );
                                  if (selectedDate != "") {
                                    DateTime filterDate =
                                        new DateFormat("dd-MM-yyyy")
                                            .parse(selectedDate);
                                    DateTime parsedateedit = new DateTime(
                                            parseDate.year,
                                            parseDate.month,
                                            parseDate.hour,
                                            parseDate.minute)
                                        .add(Duration(hours: 24));
                                    ;

                                    print(parseDate);
                                    print(" Parse date {$parseDate}");
                                    print(" Parse date edit {$parsedateedit}");

                                    print(" filter date {$filterDate}");
                                    print(
                                        "Is there ${(parseDate.compareTo(filterDate) == 0)}");
                                    if (parsedateedit.compareTo(filterDate) ==
                                        0)
                                      return MyCard(
                                        index: data['index'],
                                        imageUrl: data['imgUrl'],
                                        title: data['title'],
                                        description: data['desc'],
                                        date: data['date'],
                                        regUrl: data['regUrl'],
                                        tag: data['tag'],
                                        host: data['host'],
                                        eventresult: data['eventresult'],
                                        gallery: data['gallery'],
                                      );
                                  }
                                }

                                return Container();
                              });
                        })
                  ],
                )
              : Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.cyan)),
                ),
        ));
  }

  @override
  void initState() {
    crudMethods.getData().then((result) {
      setState(() {
        postsStream = result;
      });
    });

    super.initState();
  }

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
          title: Text("EVENTS HISTORY"),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreatePost()));
              },
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(Icons.add)),
            )
          ],
        ),
        drawer: MyNavigationDrawer(),
        body: PostList(),
      ),
    );
  }
}
