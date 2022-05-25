import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:event_management/drawer/navigationdrawer.dart';
import 'package:flutter/material.dart';
import '../services/mycolor.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int activeIndex = 0;
  int currentIndex = 0;
  Icon customicon = const Icon(Icons.search);

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        activeIndex++;

        if (activeIndex == 4) activeIndex = 0;
      });
    });

    super.initState();
  }

  List datas = [
    {
      "title": "MLSC",
      "event": "CLUB EVENT",
      "time": "12:20 P.M",
      "date": "09/04/2022",
      "descrption":
          "A warm greetings to the launch event of MLSC club conducted on 09/04/2022 event starts by 12:20PM at CSE conference hall",
      "imgurl": "https://mlsctiet.co.in/static/main/pics/mlsc_shield_new.png"
    },
    {
      "title": "CSE",
      "event": "DEPARTMENT EVENT",
      "descrption":
          "A warm greetings to the CSE department event conducted on 11/04/2022 event starts by 04:00PM at CSE conference hall",
      "time": "04:00 PM",
      "imgurl":
          "https://www.getfullformof.com/wp-content/uploads/2020/06/CSE-@.jpeg",
      "date": "11/04/2022",
    },
    {
      "title": "ECE",
      "event": "DEPARTMENT EVENT",
      "time": "02:20 PM",
      "descrption":
          "A warm greetings to the ECE department event conducted on 11/04/2022 event starts by 02:20PM at CSE conference hall",
      "date": "11/4/22",
      "imgurl":
          "https://ece.engin.umich.edu/wp-content/uploads/sites/2/2018/12/data-science-header-featured-1.jpg"
    },
    {
      "title": "TAMIL MANDRAM",
      "event": "CLUB EVENT",
      "time": "12:00 PM",
      "descrption":
          "A warm greetings to the launch event of TAMIL MANDRAM club conducted on 12/04/2022 event starts by 12:00PM at CSE conference hall",
      "date": "12/04/22",
      "imgurl": "https://i1.sndcdn.com/avatars-000306177477-46589q-t500x500.jpg"
    },
    {
      "title": "GDSC",
      "event": "CLUB EVENT",
      "time": "02:20 P.M",
      "date": "13/04/2022",
      "descrption":
          "A warm greetings to the launch event of GDSC club conducted on 13/04/2022 event starts by 02:20PM at CSE conference hall",
      "imgurl": "https://miro.medium.com/max/590/1*m40HCaIUz494Nx5Q3OI3WA.png"
    },
  ];

  final List<String> imageList = [
    "https://firebasestorage.googleapis.com/v0/b/event-management-94bbb.appspot.com/o/postImages%2F380165979.jpg?alt=media&token=76c6292f-95c8-46b0-8593-8f10ffd75804",
    "https://firebasestorage.googleapis.com/v0/b/event-management-94bbb.appspot.com/o/postImages%2F218U30JF1.jpg?alt=media&token=4423e3d7-576a-4b12-88be-2a764846ace2",
    "https://firebasestorage.googleapis.com/v0/b/event-management-94bbb.appspot.com/o/postImages%2Fsl10gvyyg.jpg?alt=media&token=eccfe54f-f199-4249-8dd2-061ba5a34837",
    "https://firebasestorage.googleapis.com/v0/b/event-management-94bbb.appspot.com/o/postImages%2F96p5Q19Y8.jpg?alt=media&token=72e21ba8-e59b-46cb-ae95-8a89f69ece1a",
    "https://firebasestorage.googleapis.com/v0/b/event-management-94bbb.appspot.com/o/postImages%2F3598799IJ.jpg?alt=media&token=a034b282-c0b0-4fa9-84cd-a46497b9ba6e",
    "https://firebasestorage.googleapis.com/v0/b/event-management-94bbb.appspot.com/o/postImages%2Fmy7q2jnpy.jpg?alt=media&token=e299cea2-0152-4b64-b2d4-5370ee52055a",
    "https://firebasestorage.googleapis.com/v0/b/event-management-94bbb.appspot.com/o/postImages%2FJ28237NKK.jpg?alt=media&token=8e0500ea-3906-4a31-82c8-62ee1daa1c82",
    "https://firebasestorage.googleapis.com/v0/b/event-management-94bbb.appspot.com/o/postImages%2F8891g0sd0.jpg?alt=media&token=1e214c8f-2d84-425c-9135-a59323a8cfeb",
  ];
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
          drawer: MyNavigationDrawer(),
          body: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.all(15),
                child: CarouselSlider.builder(
                  itemCount: imageList.length,
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    height: MediaQuery.of(context).size.height * 0.25,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    reverse: false,
                    aspectRatio: 5.0,
                  ),
                  itemBuilder: (context, i, id) {
                    return GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.white,
                            )),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            imageList[i],
                            width: 600,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      onTap: () {
                        var url = imageList[i];
                        print(url.toString());
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'UpComing  Events',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.45,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: datas.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        showDialogfun(context, datas[index]["imgurl"],
                            datas[index]["title"], datas[index]["descrption"]);
                      },
                      child: GlassmorphicContainer(
                        width: double.infinity,
                        height: 100,
                        margin: EdgeInsets.all(10),
                        borderRadius: 20,
                        blur: 200,
                        alignment: Alignment.bottomCenter,
                        border: 2,
                        linearGradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFFffffff).withOpacity(0.1),
                              Color(0xFFFFFFFF).withOpacity(0.05),
                            ],
                            stops: [
                              0.1,
                              1,
                            ]),
                        borderGradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFffffff).withOpacity(0.1),
                            Color((0xFFFFFFFF)).withOpacity(0.9),
                          ],
                        ),
                        child: Container(
                          margin: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            // color: Colors.grey
                          ),
                          child: ListTile(
                            leading: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(datas[index]["imgurl"]),
                                    fit: BoxFit.fill),
                              ),
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  setState(() {});
                                },
                                icon: Icon(Icons.notification_add)),
                            title: Text(
                              datas[index]["event"],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            isThreeLine: true,
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ("  ${datas[index]["title"]}"),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(datas[index]["date"]),
                                    Text(datas[index]["time"]),
                                    // Text(datas[index][]),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }

  showDialogfun(context, img, title, descrption) {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.55,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                          img,
                          width: 200,
                          height: 200,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        descrption,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RaisedButton(onPressed: () {}, child: Text("GO TO EVENT"))
                    ]),
              ),
            ),
          );
        });
  }

  Size get preferredSize => throw UnimplementedError();
}

class WaveClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    final lowPoint = size.height - 30;
    final highPoint = size.height - 60;
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width / 4, highPoint, size.width / 2, lowPoint);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, lowPoint);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
