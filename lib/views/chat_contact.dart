import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/account.dart';
import '../utils/constants.dart';

class ChatContact extends StatelessWidget {
  const ChatContact({Key? key, required this.contact}) : super(key: key);

  static const id = "/ChatContact";

  final Account? contact;

  void _sendMessage() {}
  void _sendPhoto() {}

  @override
  Widget build(BuildContext context) {
    if (contact == null) {
      Get.back();
    }

    var listMessage = Expanded(child: Container( color: Colors.transparent,),);
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
        title: Text(contact?.name ?? ""),
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
