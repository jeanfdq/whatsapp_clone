
import '../../models/account.dart';
import 'instances.dart';

Future<Account?> getUserData(String id) async {
  final db = instanceDB();
  final snapshot = await db.collection("users").doc(id).get();
  final map = snapshot.data();
  return map != null ? Account.fromMap(map) : null;
}