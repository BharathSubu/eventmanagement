import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management/views/chats/message.dart';
import 'package:event_management/views/chats/utils.dart';

class FirebaseApi {
  static Future uploadMessage(
      {required String idUser,
      required String profileurl,
      required String username,
      required String message}) async {
    final refMessages = FirebaseFirestore.instance.collection("messages");

    final newMessage = Message(
      idUser: idUser,
      urlAvatar: profileurl,
      username: username,
      message: message,
      createdAt: DateTime.now(),
    );
    print(newMessage);
    await refMessages.add(newMessage.toJson());
  }

  static Stream<List<Message>> getMessages(String idUser) =>
      FirebaseFirestore.instance
          .collection("messages")
          .orderBy(MessageField.createdAt, descending: true)
          .snapshots()
          .transform(Utils.transformer(Message.fromJson));
}
