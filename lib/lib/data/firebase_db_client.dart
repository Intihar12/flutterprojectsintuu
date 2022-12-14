import 'dart:async';
import 'package:firebase_database/firebase_database.dart';

import '../ui/chat/chat_model.dart';




class FirebaseDbClient {
  final _chatDb = FirebaseDatabase.instance.reference().child('chat');

  Stream<List<ChatMsgModel>> getOrderChat(int requestId) {
    bool responseReceived = false;
    final subscription =
    _chatDb.child(_getOrderRef(requestId)).onValue.map((event) {
      responseReceived = true;
      final Map<dynamic, dynamic>? data = event.snapshot.value as Map?;
      List<ChatMsgModel>? chat = data?.values
          .map((e) => ChatMsgModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
      chat?.sort(
              (msg1, msg2) => msg1.dateAndTime!.compareTo(msg2.dateAndTime!));
      return chat ?? [];
    }).timeout(Duration(seconds: 10), onTimeout: (sink) {
      if (!responseReceived) {
        throw (TimeoutException('No Stream event'));
      }
    });
    return subscription;
  }

  Future<void> sendMessageOrderChat(int requestId, ChatMsgModel msg) async {
    _chatDb.child(_getOrderRef(requestId)).push().set(msg.toJson());
  }

  String _getOrderRef(int requestId) => 'Chat_No_$requestId';
}
