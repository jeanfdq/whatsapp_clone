
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone/components/base_alert_dialog.dart';
import 'package:whatsapp_clone/utils/constants.dart';

import '../utils/widget_function.dart';
import 'login.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  static const id = "/profile";

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String imageProfile = "";

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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: InkWell(
                onTap: _getImageProfile,
                child:  CircleAvatar(
                  radius: 70,
                  backgroundColor: kPrimaryColor,
                  backgroundImage: imageProfile.isEmpty ? null : FileImage(File(imageProfile)),
                  child: Center(
                    child: Visibility(
                      visible: imageProfile.isEmpty ? true : false,
                      child: const Icon(
                        Icons.account_circle,
                        size: 130,
                        color: kPrimaryLightColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Text(
              "Edit",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: kPrimaryColor),
            )
          ],
        ));
  }

  void _logOut() {
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

   _getImageProfile() async {
     
    final imageSelected =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (imageSelected != null) {
      setState(() {
        imageProfile = imageSelected.path;
      });
    }
  }
}
