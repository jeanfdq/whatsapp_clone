import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone/components/empty_center_text.dart';
import 'package:whatsapp_clone/models/mensagem.dart';
import 'package:whatsapp_clone/utils/database/current_user.dart';
import 'package:whatsapp_clone/utils/database/save_photo_chat.dart';
import 'package:whatsapp_clone/utils/database/send_message_chat.dart';

import '../components/dialog.dart';
import '../components/progress_indicator_box.dart';
import '../models/account.dart';
import '../utils/constants.dart';
import '../utils/database/get_messages_chat.dart';
import '../utils/database/instances.dart';

class ChatContact extends StatelessWidget {
  ChatContact({Key? key, required this.contact}) : super(key: key);
  static const id = "/ChatContact";

  final Account? contact;
  final userId = getCurrentUserId();
  final db = instanceDB();
  final _streamController =
      StreamController<QuerySnapshot<Map<String, dynamic>>>.broadcast();
  final _scrollCotroller = ScrollController();

  final _messageController = TextEditingController();

  final emptyText = "Nenhum contato cadastrado!";

  @override
  Widget build(BuildContext context) {
    if (contact == null) {
      Get.back();
    } else {
      _getMessages();
      Timer(const Duration(milliseconds: 500), () {
        _goLastMessage();
      });
    }

    var stream = Expanded(
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _streamController.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ProgressIndicatorBox();
          } else if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
            if (!snapshot.hasData) {
              return setEmptyCenterText(emptyText);
            } else {
              final querySnapshots = snapshot.data;

              return querySnapshots!.docs.isEmpty
                  ? setEmptyCenterText(emptyText)
                  : ListView.builder(
                      controller: _scrollCotroller,
                      itemCount: querySnapshots.docs.length,
                      itemBuilder: (context, index) {
                        List<DocumentSnapshot> messages =
                            querySnapshots.docs.toList();
                        DocumentSnapshot message = messages[index];

                        final color =
                            message["idUserFrom"] == currentUser()!.uid
                                ? const Color(0xffd2ffa5)
                                : Colors.white;
                        final alignment =
                            message["idUserFrom"] == currentUser()!.uid
                                ? Alignment.centerRight
                                : Alignment.centerLeft;

                        return Align(
                          alignment: alignment,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: Get.width * 0.7,
                              height: message["tipo"] == "M" ? null : 150,
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(12),
                                  image: message["tipo"] == "M"
                                      ? null
                                      : DecorationImage(
                                          image:
                                              NetworkImage(message["urlImage"]),
                                          fit: BoxFit.cover)),
                              child: message["tipo"] == "M"
                                  ? Text(message["message"])
                                  : Container(),
                            ),
                          ),
                        );
                      },
                    );
            }
          } else {
            return setEmptyCenterText(emptyText);
          }
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
        Platform.isAndroid
            ? FloatingActionButton(
                backgroundColor: kPrimaryColor,
                child: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
                mini: true,
                onPressed: _sendMessage,
              )
            : CupertinoButton(
                child: const Text(
                  "enviar",
                  style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                ),
                onPressed: _sendMessage),
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
                backgroundImage: contact?.imageProfile == null
                    ? null
                    : NetworkImage(contact!.imageProfile),
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
                stream,
                chatBox,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _getMessages() {
    final stream = getMessagesChat(contact!.id);

    stream.listen((event) {
      _streamController.add(event);
    });
  }

  void _sendMessage() async {
    if (_messageController.text.trim().isNotEmpty) {
      final message = Mensagem(
          idUserFrom: userId,
          idUserTo: contact!.id,
          message: _messageController.text,
          urlImage: "",
          tipo: "M");

      sendMessageChat(message);
      _goLastMessage();
    }
  }

  void _sendPhoto() async {
    addDialog(Get.context!, false);

    final imageSelected =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (imageSelected != null) {
      
      final profileUrl = await savePhotoChat(imageSelected);

      final message = Mensagem(
          idUserFrom: userId,
          idUserTo: contact!.id,
          message: "",
          urlImage: profileUrl,
          tipo: "P");

      sendMessageChat(message);
      _goLastMessage();

      addDialog(Get.context!, true);
    } else {
      addDialog(Get.context!, true);
    }
  }

  void _goLastMessage() {
    _scrollCotroller.jumpTo(_scrollCotroller.position.maxScrollExtent);
  }
  
}
