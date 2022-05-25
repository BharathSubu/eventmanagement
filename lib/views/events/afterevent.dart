import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:event_management/drawer/navigationdrawer.dart';
import 'package:event_management/services/crud.dart';
import 'package:event_management/services/mycolor.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:random_string/random_string.dart';

class AfterEvent extends StatefulWidget {
  final String eventresult;
  List<dynamic> gallery;
  final String index;

  AfterEvent(
      {required this.eventresult, required this.gallery, required this.index});
  @override
  State<AfterEvent> createState() => _AfterEventState();
}

class _AfterEventState extends State<AfterEvent> {
  String result = "";
  CrudMethods crudMethods = new CrudMethods();
  bool _isLoading = false;
  List<XFile> images = [];
  List<String> imageurls = [];
  updateReport(index) async {
    if (result != "") {
      crudMethods.updateEventResult(index, result).then((result) {
        setState(() {
          _isLoading = true;
        });
        Navigator.pop(context);
      });
    }
  }

  Future getImage() async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? selectedImages = await _picker.pickMultiImage();
    if (selectedImages != null) {
      if (selectedImages.isNotEmpty) {
        images.addAll(selectedImages);
      }
      print("Image List Length:" + images.length.toString());
      if (images.length > 0) {
        var url = await uploadFiles(images);
        print("imageurl $url");
        crudMethods.updateEventGallery(widget.index, url);
      }
    }
  }

  Future<List<String>> uploadFiles(List<XFile> _images) async {
    var imageUrls =
        await Future.wait(_images.map((_image) => uploadFile(_image)));
    print(imageUrls);
    return imageUrls;
  }

  Future<String> uploadFile(XFile _image) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference firebaseStorageRef =
        storage.ref().child("postImages").child("${randomAlphaNumeric(9)}.jpg");
    UploadTask task = firebaseStorageRef.putFile(File(_image.path));
    await task.whenComplete(() async {
      return await firebaseStorageRef.getDownloadURL();
    }).catchError((onError) {
      print(onError);
    });
    return await firebaseStorageRef.getDownloadURL();
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
            title: Text("EVENT REPORT"),
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),
          body: _isLoading
              ? Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.cyan)),
                )
              : SingleChildScrollView(
                  child: Column(children: [
                    TextField(
                      style: TextStyle(color: Mycolor.white),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                          hintText: "Report",
                          hintStyle: TextStyle(color: Colors.white38)),
                      onChanged: (val) {
                        result = val;
                      },
                    ),
                    Container(
                      margin: EdgeInsets.all(20).copyWith(bottom: 5),
                      child: RaisedButton(
                        onPressed: () {
                          print("lenght ${widget.gallery.length}");
                          updateReport(widget.index);
                          print("event result ${widget.eventresult}");
                        },
                        child: Text("Upload Report"),
                      ),
                    ),
                    Text(
                      "Report  ",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    if (widget.eventresult == "")
                      Container(
                        margin: EdgeInsets.all(20).copyWith(bottom: 0),
                        child: Card(
                          elevation: 5,
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Stack(children: [
                            CachedNetworkImage(
                              imageUrl:
                                  "https://cdn.dribbble.com/users/2382015/screenshots/6065978/no_result_still_2x.gif?compress=1&resize=400x300",
                              placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.cyan),
                              )),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              height: MediaQuery.of(context).size.height * 0.25,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            ),
                          ]),
                        ),
                      ),
                    if (widget.eventresult != "")
                      Padding(
                        padding: EdgeInsets.all(16).copyWith(bottom: 0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.25,
                          child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Text(
                                " ${widget.eventresult} ",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              )),
                        ),
                      ),
                    Container(
                      margin: EdgeInsets.all(20),
                      child: RaisedButton(
                        onPressed: () {
                          getImage();
                        },
                        child: Text("Upload Images"),
                      ),
                    ),
                    Text(
                      "Gallery",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    if (widget.gallery.length == 1)
                      Container(
                        margin: EdgeInsets.all(20).copyWith(bottom: 0),
                        child: Card(
                          elevation: 5,
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Stack(children: [
                            CachedNetworkImage(
                              imageUrl:
                                  "https://cdn.dribbble.com/users/2382015/screenshots/6065978/no_result_still_2x.gif?compress=1&resize=400x300",
                              placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.cyan),
                              )),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              height: MediaQuery.of(context).size.height * 0.25,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            ),
                          ]),
                        ),
                      ),
                    if (widget.gallery.length > 1)
                      Container(
                        margin: EdgeInsets.all(15),
                        child: CarouselSlider.builder(
                          itemCount: widget.gallery.length,
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
                                    widget.gallery[i],
                                    width: 600,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              onTap: () {
                                var url = widget.gallery[i];
                                print(url.toString());
                              },
                            );
                          },
                        ),
                      ),
                    SizedBox(
                      height: 20,
                    )
                  ]),
                ),
        ));
  }
}
