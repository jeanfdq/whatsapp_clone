
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone/utils/database/current_user.dart';

import 'instances.dart';

Future<String> savePhotoChat(XFile image) async {

final currentUserId = getCurrentUserId();
final storage = instanceStorage();
      final root = storage.ref();
      final profile = root
          .child("messages")
          .child("$currentUserId.jpeg")
          .child(DateTime.now().microsecondsSinceEpoch.toString());
      final task = profile.putFile(File(image.path));
      final profileUrl = await (await task).ref.getDownloadURL();
      return profileUrl;

}