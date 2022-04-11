

import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp_clone/utils/database/instances.dart';

User? currentUser() {
  final user = instanceAuth().currentUser;
  return user; 
}

String getCurrentUserId(){
  return currentUser()?.uid ?? "";
}

Future<String> getProfileCurrentUser() async {
  final db = instanceDB();
  final snapshot = await db.collection("users").doc(currentUser()!.uid).get();

  final data = snapshot.data();
  return data?["imageProfile"] ?? "";
}