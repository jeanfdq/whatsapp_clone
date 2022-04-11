
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/account.dart';

Widget addVerticalSpace(double height ) {
  return SizedBox(height: height);
}

Widget addHorizontalSpace(double width) {
  return SizedBox(width: width);
}

Widget addSeparetedRow(){
  return Container(color: Colors.grey, height: 0.3, width: Get.width,);
}

//Fireabse=========================
FirebaseAuth instanceAuth(){
  return FirebaseAuth.instance;
}

FirebaseFirestore instanceDB(){
  return FirebaseFirestore.instance;
}

FirebaseStorage instanceStorage(){
  return FirebaseStorage.instance;
}

User? currentUser() {
  final user = instanceAuth().currentUser;
  return user; 
}

Future<String> getProfileCurrentUser() async {
  final db = instanceDB();
  final snapshot = await db.collection("users").doc(currentUser()!.uid).get();

  final data = snapshot.data();
  return data?["imageProfile"] ?? "";
}

Future<Account?> getUserData(String id) async {
  final db = instanceDB();
  final snapshot = await db.collection("users").doc(id).get();
  final map = snapshot.data();
  return map != null ? Account.fromMap(map) : null;
}

void addDialog( BuildContext context, bool dismiss){
  if (dismiss) {
      Navigator.pop(context);
    } else {
      showDialog (
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: Colors.white,
                  width: 150,
                  height: 100,
                  child: Center(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircularProgressIndicator(),
                          addVerticalSpace(12),
                          const Text("...carregando")
                        ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
}