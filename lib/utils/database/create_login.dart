
import 'package:firebase_auth/firebase_auth.dart';

import 'instances.dart';

Future<User?> createLogin(String email, String password) async {

  final auth = instanceAuth();
      try {
        final userCredencial = await auth.signInWithEmailAndPassword(
            email: email, password: password);
        return userCredencial.user;
      } catch (e) {
        return null;
      }

}