import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/utils/widget_function.dart';

import '../components/progress_indicator_box.dart';
import 'chat_contact.dart';

class Chat extends StatelessWidget {
  Chat({Key? key}) : super(key: key);

  final userId = currentUser()!.uid;
  final db = instanceDB();
  final _streamController =
      StreamController<QuerySnapshot<Map<String, dynamic>>>.broadcast();

  void _getLastMessages() {
    db
        .collection("last_message")
        .doc(userId)
        .collection("message")
        .snapshots()
        .listen((event) {
      _streamController.add(event);
    });
  }

  Widget _noMessagesText() {
    return const Center(
      child: Text("Nenhum mensagem!"),
    );
  }

  @override
  Widget build(BuildContext context) {

    _getLastMessages();
    
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: _streamController.stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const ProgressIndicatorBox();
        } else if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.done) {
          if (!snapshot.hasData) {
            return _noMessagesText();
          } else {
            final querySnapshots = snapshot.data;

            return querySnapshots!.docs.isEmpty
                ? _noMessagesText()
                : ListView.builder(
                    itemCount: querySnapshots.docs.length,
                    itemBuilder: (context, index) {
                      List<DocumentSnapshot> messages =
                          querySnapshots.docs.toList();
                      DocumentSnapshot message = messages[index];

                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: InkWell(
                              onTap: () async {
                                final contact =
                                    await getUserData(message["messageUserId"]);
                                if (contact != null) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          ChatContact(contact: contact)));
                                }
                              },
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    backgroundImage: NetworkImage(
                                        message["messageUserProfile"]),
                                    radius: 24,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          message["messageUserName"],
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        message["typeMessage"] == "M"
                                            ? Text(
                                                message["message"],
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              )
                                            : Row(
                                                children: [
                                                  const Icon(
                                                    Icons.photo_camera,
                                                    color: Colors.grey,
                                                    size: 16,
                                                  ),
                                                  addHorizontalSpace(5),
                                                  const Text(
                                                    "Photo",
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 13,
                                                    ),
                                                  )
                                                ],
                                              ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Divider(),
                        ],
                      );
                    },
                  );
          }
        } else {
          return _noMessagesText();
        }
      },
    );
  }
}
