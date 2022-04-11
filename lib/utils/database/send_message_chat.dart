import 'package:whatsapp_clone/utils/database/current_user.dart';
import 'package:whatsapp_clone/utils/database/instances.dart';

import '../../models/last_chat.dart';
import '../../models/mensagem.dart';
import 'user_data.dart';

void sendMessageChat(Mensagem message) async {
  final db = instanceDB();
  
  await db
      .collection("messages")
      .doc(message.idUserFrom)
      .collection(message.idUserTo)
      .add(message.toMap());

  await db
      .collection("messages")
      .doc(message.idUserTo)
      .collection(message.idUserFrom)
      .add(message.toMap());

      _saveLastMessage(message);
}

void _saveLastMessage(Mensagem message) async {
  final  userId = getCurrentUserId();
  final db = instanceDB();
    var user = await getUserData(message.idUserTo);
    if (user != null) {
      final lastChat = LastChat(
          userId: userId,
          messageUserId: user.id,
          messageUserName: user.name,
          messageUserProfile: user.imageProfile,
          message: message.message,
          urlPhoto: message.urlImage,
          typeMessage: message.tipo);
      await db
          .collection("last_message")
          .doc(userId)
          .collection("message")
          .doc(message.idUserTo)
          .set(lastChat.toMap());
    }
    user = await getUserData(message.idUserFrom);
    if (user != null) {
      final lastChat = LastChat(
          userId: message.idUserTo,
          messageUserId: user.id,
          messageUserName: user.name,
          messageUserProfile: user.imageProfile,
          message: message.message,
          urlPhoto: message.urlImage,
          typeMessage: message.tipo);
      await db
          .collection("last_message")
          .doc(message.idUserTo)
          .collection("message")
          .doc(userId)
          .set(lastChat.toMap());
    }
  }
