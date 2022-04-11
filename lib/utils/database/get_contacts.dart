

import '../../models/account.dart';
import 'current_user.dart';
import 'instances.dart';

Future<List<Account>> getContacts() async {
    final db = instanceDB();
    final snapshots = await db.collection("users").where("id", isNotEqualTo: getCurrentUserId()).get();

    List<Account> listOfContacts = snapshots.docs.map((item) {
      var map = item.data();
      final user = Account.fromMap(map);
      return user;
    }).toList();
    return listOfContacts;
  }