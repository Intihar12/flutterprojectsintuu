import 'package:json_annotation/json_annotation.dart';



class ChatMsgModel {
  DateTime? dateAndTime;
  String? imageName;
  bool? isImage;
  String? message;
  String? receiverId;
  String ?senderId;

  ChatMsgModel({
    this.dateAndTime,
    this.imageName,
    this.isImage,
    this.message,
    this.receiverId,
    this.senderId,
  });

  factory ChatMsgModel.fromJson(Map<String, dynamic> json) {
   return ChatMsgModel(
      dateAndTime: json['date_and_time'] == null
          ? null
          : DateTime.parse(json['date_and_time'] as String),
      imageName: json['image_name'] as String?,
      isImage: json['is_image'] as bool?,
      message: json['message'] as String?,
      receiverId: json['receiver_id'] as String?,
      senderId: json['sender_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'date_and_time': dateAndTime?.toIso8601String(),
      'image_name': imageName,
      'is_image': isImage,
      'message': message,
      'receiver_id': receiverId,
      'sender_id': senderId,
    };
  }
}
