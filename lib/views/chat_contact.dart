
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/account.dart';

class ChatContact extends StatelessWidget {
  const ChatContact({ Key? key, required this.contact }) : super(key: key);

  static const id = "/ChatContact";

  final Account? contact;

  @override
  Widget build(BuildContext context) {

    if (contact == null) {
      Get.back();
    }

    return Scaffold(
      appBar: AppBar( title: Text(contact?.name ?? ""), ),
      body: Container(),
    );
  }
}