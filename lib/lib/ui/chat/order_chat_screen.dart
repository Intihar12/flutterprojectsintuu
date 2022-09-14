import 'package:antrakuserinc/ui/values/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/firebase_db_client.dart';
import '../../data/repository.dart';
import '../../data/singleton/singleton.dart';
import 'chat_model.dart';

class OrderChatPage extends StatefulWidget {
  static const _bubbleGap = 40.0;
  static const _bubbleRadius = 25.0;
  static const _paddingChatField = 8.0;
  final int requestId;
  final String theirName;
  final String orderID;
  OrderChatPage({
    required this.requestId,
    required this.theirName,
    required this.orderID,
  });

  @override
  _OrderChatPageState createState() => _OrderChatPageState();
}

class _OrderChatPageState extends State<OrderChatPage> {
  static const _insetM = 15.0;
  final _chatController = TextEditingController();
  final _dbClient = FirebaseDbClient();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${widget.theirName} "),
              Text(
                "Order# ANT${widget.orderID}",
                style: textTheme.subtitle1!.copyWith(color: MyColors.white),
              ),
            ],
          ),
          backgroundColor: MyColors.primaryColor,
        ),
        body: StreamBuilder<List<ChatMsgModel>>(
          stream: _dbClient.getOrderChat(widget.requestId),
          builder: (context, snapshot2) {
            if (snapshot2.hasData) {
              return _buildContent(context, snapshot2.data!,
                  int.parse(GetStorage().read('user_id')));
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  Widget _buildContent(
      BuildContext context, List<ChatMsgModel> data, int userId) {
    final chatList = data.reversed.toList();
    final textTheme = Theme.of(context).textTheme;
    final chatFieldBorder = OutlineInputBorder(
      borderSide: BorderSide(
        width: 1,
        color: MyColors.primaryColor,
      ),
      borderRadius: BorderRadius.circular(25.0),
    );
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(
              horizontal: _insetM,
            ),
            reverse: true,
            itemCount: chatList.length,
            itemBuilder: (context, index) {
              final model = chatList[index];
              return Padding(
                padding: const EdgeInsets.only(
                  top: OrderChatPage._bubbleGap,
                ),
                child: int.parse(model.senderId!) == userId
                    ? _buildChatBubble(context, model.message ?? '')
                    : _buildTheirChatBubble(context, model.message ?? ''),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              right: OrderChatPage._paddingChatField,
              left: OrderChatPage._paddingChatField,
              top: OrderChatPage._paddingChatField,
              bottom: 15.00),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _chatController,
                  style: textTheme.bodyText2,
                  decoration: InputDecoration(
                    hintText: 'Send Message',
                    hintStyle: textTheme.bodyText2,
                    border: chatFieldBorder,
                    focusedBorder: chatFieldBorder,
                  ),
                ),
              ),
              GestureDetector(
                child: SizedBox(
                  width: 48,
                  child: Icon(
                    Icons.send,
                    color: MyColors.primaryColor,
                    size: 20,
                  ),
                ),
                onTap: () => _onSend(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChatBubble(BuildContext context, String msg) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              padding: EdgeInsets.all(_insetM),
              child: Text(
                msg,
                style: TextStyle(
                  color: MyColors.white,
                ),
              ),
              decoration: BoxDecoration(
                color: MyColors.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(OrderChatPage._bubbleRadius),
                  topRight: Radius.circular(OrderChatPage._bubbleRadius),
                  bottomLeft: Radius.circular(OrderChatPage._bubbleRadius),
                ),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              'Sent ${TimeOfDay.now().hour}:${TimeOfDay.now().minute}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
      ],
    );
  }

  void _onSend() async {
    final msg = _chatController.text;
    //  final user = Repository().getLoginData();
    final int? userId = int.parse(GetStorage().read('user_id'));
    if (msg.isNotEmpty) {
      await _dbClient
          .sendMessageOrderChat(
              widget.requestId,
              ChatMsgModel(
                message: msg,
                imageName: "",
                receiverId: SingleToneValue.instance.driverID.toString(),
                senderId: userId.toString(),
                dateAndTime: DateTime.now(),
                isImage: false,
              ))
          .whenComplete(() async {
        _chatController.clear();
        await Repository().sendMessage(msg);
      });
    }
  }

  Widget _buildTheirChatBubble(BuildContext context, String msg) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              padding: EdgeInsets.all(_insetM),
              child: Text(
                msg,
                style: TextStyle(
                  color: MyColors.white,
                ),
              ),
              decoration: BoxDecoration(
                color: MyColors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(OrderChatPage._bubbleRadius),
                  topRight: Radius.circular(OrderChatPage._bubbleRadius),
                  bottomRight: Radius.circular(OrderChatPage._bubbleRadius),
                ),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              'Received',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
      ],
    );
  }
}
