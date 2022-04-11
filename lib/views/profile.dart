import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone/components/base_alert_dialog.dart';
import 'package:whatsapp_clone/models/account.dart';
import 'package:whatsapp_clone/utils/constants.dart';
import 'package:whatsapp_clone/utils/database/current_user.dart';

import '../components/dialog.dart';
import '../utils/database/instances.dart';
import 'login.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  static const id = "/profile";

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final userID = getCurrentUserId();

  final _nameController = TextEditingController();
  String imageUrl = "";
  bool showLoading = false;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: InkWell(
                onTap: _getImageProfile,
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: kPrimaryColor,
                  backgroundImage:
                      imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
                  child: Center(
                    child: Visibility(
                      visible: imageUrl.isEmpty,
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
            const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                "Edit",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: _nameController,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                autofocus: true,
                decoration: const InputDecoration(
                    label: Text(
                      "Nome:",
                      style: TextStyle(color: kPrimaryColor),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(32, 20, 20, 16),
                    hintText: "Informe seu nome",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    floatingLabelBehavior: FloatingLabelBehavior.never),
              ),
            ),
            ElevatedButton(
              onPressed: _saveProfile,
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(8),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
                  fixedSize:
                      MaterialStateProperty.all(Size(Get.width * 0.6, 45))),
              child: const Text(
                "save",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ));
  }

  _getUserData() async {

    await instanceDB().collection("users").doc(userID).get().then((snapshot) {
      final map = snapshot.data();
      if (map != null) {
        final user = Account.fromMap(map);

        setState(() {
          _nameController.text = user.name;
          imageUrl = user.imageProfile;
        });
      }
    });
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
    addDialog(context, false);
    final imageSelected =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    
    if (imageSelected != null) {
      final storage = instanceStorage();
      final root = storage.ref();
      final profile = root.child("profile").child("$userID.jpeg");
      UploadTask task = profile.putFile(File(imageSelected.path));
      final profileUrl = await (await task).ref.getDownloadURL();

      await instanceDB()
          .collection("users")
          .doc(userID)
          .update({"imageProfile": profileUrl});

      setState(() {
        imageUrl = profileUrl;
      });
      addDialog(context, true);
    } else {
      addDialog(context, true);
    }
  }

  void _saveProfile() async {
    addDialog(context, false);
    await instanceDB()
        .collection("users")
        .doc(userID)
        .update({"name": _nameController.text, "imageProfile": imageUrl});
    addDialog(context, true);
    Get.back();
  }
}
