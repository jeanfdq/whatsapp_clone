import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp_clone/models/account.dart';
import 'package:whatsapp_clone/utils/database/create_login.dart';
import 'package:whatsapp_clone/utils/database/current_user.dart';

import 'instances.dart';

Future<User?> createUser(Account account) async {
  final user = await createLogin(account.email, account.password);

  if (user != null) {
    user.updateDisplayName(account.name);
    final db = instanceDB();
    account.id = getCurrentUserId();
    await db.collection("users").doc(account.id).set(account.toMap());
    return user;
  }

  return null;
}
