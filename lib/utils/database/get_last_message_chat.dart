import 'package:cloud_firestore/cloud_firestore.dart';

import 'current_user.dart';
import 'instances.dart';

Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessagesChat() {
  final db = instanceDB();
  final stream = db
      .collection("last_message")
      .doc(getCurrentUserId())
      .collection("message")
      .snapshots();
  return stream;
}
