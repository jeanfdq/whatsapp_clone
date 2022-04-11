import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone/models/last_chat.dart';
import 'package:whatsapp_clone/models/mensagem.dart';

import '../components/progress_indicator_box.dart';
import '../models/account.dart';
import '../utils/constants.dart';
import '../utils/widget_function.dart';

class ChatContact extends StatelessWidget {
  ChatContact({Key? key, required this.contact}) : super(key: key);
  static const id = "/ChatContact";

  final Account? contact;
  final userId = currentUser()!.uid;
  final db = instanceDB();
  final _streamController =
      StreamController<QuerySnapshot<Map<String, dynamic>>>.broadcast();
  

  final _messageController = TextEditingController();

  void _getMessages() {
    db
        .collection("messages")
        .doc(userId)
        .collection(contact!.id)
        .orderBy("data")
        .snapshots()
        .listen((event) {
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

      await db
          .collection("messages")
          .doc(userId)
          .collection(contact!.id)
          .add(message.toMap());
      _messageController.clear();

      await db
          .collection("messages")
          .doc(contact!.id)
          .collection(userId)
          .add(message.toMap());
      _messageController.clear();

      _saveLastMessage(message);

      
    }
  }

  void _sendPhoto() async {
    addDialog(Get.context!, false);

    final imageSelected =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (imageSelected != null) {
      final storage = instanceStorage();
      final root = storage.ref();
      final profile = root
          .child("messages")
          .child("$userId.jpeg")
          .child(DateTime.now().microsecondsSinceEpoch.toString());
      final task = profile.putFile(File(imageSelected.path));
      final profileUrl = await (await task).ref.getDownloadURL();

      final message = Mensagem(
          idUserFrom: userId,
          idUserTo: contact!.id,
          message: "",
          urlImage: profileUrl,
          tipo: "P");

      await db
          .collection("messages")
          .doc(userId)
          .collection(contact!.id)
          .add(message.toMap());
      _messageController.clear();

      await db
          .collection("messages")
          .doc(contact!.id)
          .collection(userId)
          .add(message.toMap());
      _messageController.clear();

      _saveLastMessage(message);

      addDialog(Get.context!, true);
    } else {
      addDialog(Get.context!, true);
    }
  }

  Widget _noContactsText() {
    return const Center(
      child: Text("Nenhum contato cadastrado!"),
    );
  }

  void _saveLastMessage(Mensagem message) async {

    var user = await getUserData(message.idUserTo);
      if (user != null) {
        final lastChat = LastChat(userId: userId, messageUserId: user.id, messageUserName: user.name, messageUserProfile: user.imageProfile, message: message.message, urlPhoto: message.urlImage, typeMessage: message.tipo);
        await db
          .collection("last_message")
          .doc(userId)
          .collection("message")
          .doc(contact!.id)
          .set(lastChat.toMap());
      }
      user = await getUserData(message.idUserFrom);
      if (user != null) {
        final lastChat = LastChat(userId: message.idUserTo, messageUserId: user.id, messageUserName: user.name, messageUserProfile: user.imageProfile, message: message.message, urlPhoto: message.urlImage, typeMessage: message.tipo);
        await db
          .collection("last_message")
          .doc(contact!.id)
          .collection("message")
          .doc(userId)
          .set(lastChat.toMap());
      }
  }

  @override
  Widget build(BuildContext context) {
    if (contact == null) {
      Get.back();
    } else {
      _getMessages();
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
              return _noContactsText();
            } else {
              final querySnapshots = snapshot.data;

              return querySnapshots!.docs.isEmpty
                  ? _noContactsText()
                  : ListView.builder(
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
            return _noContactsText();
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
}
