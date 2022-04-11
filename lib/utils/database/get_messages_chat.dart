
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_clone/utils/database/current_user.dart';
import 'package:whatsapp_clone/utils/database/instances.dart';

Stream<QuerySnapshot<Map<String, dynamic>>> getMessagesChat(String contactId){

  final db = instanceDB();
  final stream = db
        .collection("messages")
        .doc(getCurrentUserId())
        .collection(contactId)
        .orderBy("data")
        .snapshots();
        return stream;

}