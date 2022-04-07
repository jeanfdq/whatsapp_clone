import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/components/base_alert_dialog.dart';

import '../utils/widget_function.dart';
import 'login.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  static const id = "/profile";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: InkWell(
              onTap: _logOut,
              child: const Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.orangeAccent,
        height: Get.height,
        width: Get.width,
      ),
    );
  }

  _logOut() {
    final dialog = BaseAlertDialog(
      title: "LogOut",
      content: "Deseja realmente sair do sistema?",
      yes: "Confirm",
      no: "Cancel",
      yesOnPressed: _yesDialogButton,
      noOnPressed: _noDialogButton,
    );
    Get.dialog(dialog, barrierDismissible: false);
  }

  void _yesDialogButton() {
    instanceAuth().signOut();
    Get.offNamedUntil(Login.id, (route) => false);
  }

  void _noDialogButton() {
    Get.back();
  }
}
