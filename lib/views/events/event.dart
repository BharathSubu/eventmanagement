import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management/drawer/navigationdrawer.dart';
import 'package:event_management/services/crud.dart';
import 'package:event_management/services/mycolor.dart';
import 'package:event_management/views/events/card.dart';
import 'package:event_management/views/events/create_post.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyEventPage extends StatefulWidget {
  @override
  _MyEventPageState createState() => _MyEventPageState();
}

class _MyEventPageState extends State<MyEventPage> {
  CrudMethods crudMethods = new CrudMethods();
  Stream<QuerySnapshot>? postsStream;
  bool onselectTech = true;
  bool onselectNTech = false;
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
                        margin: EdgeInsets.all(
                                MediaQuery.of(context).size.width * 0.07)
                            .copyWith(top: 0, bottom: 0),
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.07,
                              width: MediaQuery.of(context).size.width * 0.40,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    onselectNTech = false;
                                    onselectTech = true;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: onselectTech ? 50 : 0,
                                  primary: onselectTech
                                      ? Colors.white
                                      : Colors.black,
                                  onPrimary: Colors.white,
                                  side: BorderSide(
                                      color: onselectTech
                                          ? Colors.black
                                          : Colors.white,
                                      width: 1),
                                ),
                                child: Text(
                                  "Technical",
                                  style: TextStyle(
                                      color: onselectTech
                                          ? Colors.black
                                          : Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.07,
                              width: MediaQuery.of(context).size.width * 0.40,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    onselectTech = false;
                                    onselectNTech = true;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: onselectNTech ? 50 : 0,
                                  primary: onselectNTech
                                      ? Colors.white
                                      : Colors.black,
                                  onPrimary: Colors.white,
                                  side: BorderSide(
                                      color: onselectNTech
                                          ? Colors.black
                                          : Colors.white,
                                      width: 1),
                                ),
                                child: Text(
                                  "Non Technical",
                                  style: TextStyle(
                                      color: onselectNTech
                                          ? Colors.black
                                          : Colors.white),
                                ),
                              ),
                            )
                          ],
                        )),
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
                                if (data['tag'] == "Technical" &&
                                    onselectTech == true &&
                                    parseDate.compareTo(currentDate) > 0) {
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
                                if (data['tag'] == "Non Technical" &&
                                    onselectNTech == true &&
                                    parseDate.compareTo(currentDate) > 0) {
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
          title: Text("EVENTS"),
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
