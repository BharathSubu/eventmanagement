import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyCardImageView extends StatelessWidget {
  final String imageUrl;
  MyCardImageView({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: InkWell(
                onTap: () async {
                  var status = await Permission.storage.request();
                  if (status.isGranted) {
                    print(status);
                    try {
                      // Saved with this method.
                      var imageId =
                          await ImageDownloader.downloadImage(imageUrl);
                      if (imageId == null) {
                        return;
                      }

                      Fluttertoast.showToast(
                          msg: "Download Successful",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey[600],
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } on PlatformException catch (error) {
                      print(error);
                    } // it should print PermissionStatus.granted
                  }
                  if (status.isRestricted) {}
                },
                child: Icon(Icons.download),
              ),
            )
          ],
        ),
        backgroundColor: Colors.black,
        body: Center(
            child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width,
          child: CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.cyan),
                  )),
              imageBuilder: (context, imageProvider) => PhotoView(
                    imageProvider: imageProvider,
                    minScale: PhotoViewComputedScale.contained * 0.8,
                    maxScale: PhotoViewComputedScale.covered * 1.8,
                    initialScale: PhotoViewComputedScale.contained * 1.1,
                  )),
        )));
  }
}
