//import 'package:firebase_chat_example/api/firebase_api.dart';
import 'package:event_management/views/chats/firebase_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NewMessageWidget extends StatefulWidget {
  final String idUser;
  final String profileurl;
  final String username;
  final String forum;

  NewMessageWidget(
      {required this.idUser,
      required this.profileurl,
      required this.username,
      required this.forum});

  @override
  _NewMessageWidgetState createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> {
  FocusNode myFocusNode = new FocusNode();
  final _controller = TextEditingController();
  String message = '';

  void sendMessage() async {
    if (widget.idUser.contains("srec.ac.in") ||
        widget.idUser.contains("bharathsubu2002")) {
      await FirebaseApi.uploadMessage(
          idUser: widget.idUser,
          username: widget.username,
          profileurl: widget.profileurl,
          message: message,
          forum: widget.forum);
    } else {
      Fluttertoast.showToast(
          msg: "Use College Mail",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.grey.shade200.withOpacity(0.2),
        padding: EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                minLines: 1,
                maxLines: 3,
                focusNode: myFocusNode,
                controller: _controller,
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                enableSuggestions: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200.withOpacity(0.2),
                  labelText: 'Type your message',
                  labelStyle: TextStyle(
                      color: myFocusNode.hasFocus ? Colors.white : Colors.white,
                      fontSize: 18),
                  enabledBorder: const OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  border: OutlineInputBorder(
                    gapPadding: 10,
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),
                onChanged: (value) => setState(() {
                  message = value;
                }),
              ),
            ),
            SizedBox(width: 20),
            GestureDetector(
              onTap: message.trim().isEmpty ? null : sendMessage,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
                child: Icon(Icons.send, color: Colors.white),
              ),
            ),
          ],
        ),
      );
}
