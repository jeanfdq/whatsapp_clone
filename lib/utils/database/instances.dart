
//Fireabse=========================
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

FirebaseAuth instanceAuth(){
  return FirebaseAuth.instance;
}

FirebaseFirestore instanceDB(){
  return FirebaseFirestore.instance;
}

FirebaseStorage instanceStorage(){
  return FirebaseStorage.instance;
}