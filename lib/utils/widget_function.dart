
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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