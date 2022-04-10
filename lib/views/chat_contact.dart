import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/models/mensagem.dart';

import '../models/account.dart';
import '../utils/constants.dart';
import '../utils/widget_function.dart';

class ChatContact extends StatelessWidget {
  ChatContact({Key? key, required this.contact}) : super(key: key);

  static const id = "/ChatContact";

  final Account? contact;
  final _messageController = TextEditingController();

  final List<String> listOfgMsg = [
    "Mensagem 1",
    "Mensagem 2",
    "Mensagem 3",
    "Mensagem 4"
  ];

  void _sendMessage() async {

    if (_messageController.text.trim().isNotEmpty) {

        final currentUserID = currentUser()!.uid;
        final message = Mensagem(idUserFrom: currentUserID, idUserTo: contact!.id, message: _messageController.text, urlImage: "", tipo: "M");

        final db = instanceDB();
        await db.collection("messages").doc(currentUserID).set(message.toMap());
        _messageController.clear();
    }

  }
  void _sendPhoto() {}

  @override
  Widget build(BuildContext context) {
    if (contact == null) {
      Get.back();
    }

    var listMessage = Expanded(
      child: ListView.builder(
        itemCount: listOfgMsg.length,
        itemBuilder: (context, index) {

          final color = index % 2 == 0 ? const Color(0xffd2ffa5) : Colors.white;
          final alignment = index % 2 == 0 ? Alignment.centerRight : Alignment.centerLeft;

          return Align(
            alignment: alignment,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container( 
                width: Get.width * 0.7,
                padding: const EdgeInsets.all(12.0) ,
                decoration: BoxDecoration( color: color, borderRadius: BorderRadius.circular(12), ),
                child: Text(listOfgMsg[index]),
              ),
            ),
          );
        },
      ),
    );

    var chatBox = Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.add_a_photo),
                    iconSize: 22,
                    color: kPrimaryColor,
                    onPressed: _sendPhoto,
                  ),
                ),
              ),
            ),
          ),
        ),
        FloatingActionButton(
          backgroundColor: kPrimaryColor,
          child: const Icon(
            Icons.send,
            color: Colors.white,
          ),
          mini: true,
          onPressed: _sendMessage,
        )
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: CircleAvatar( 
                backgroundColor: Colors.grey,
                backgroundImage: contact?.imageProfile == null ? null : NetworkImage(contact!.imageProfile),
                radius: 18,
              ),
            ),
            Text(contact?.name ?? ""),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                listMessage,
                chatBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
