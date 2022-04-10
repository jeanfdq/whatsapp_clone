
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/components/progress_indicator_box.dart';
import 'package:whatsapp_clone/models/account.dart';
import 'package:whatsapp_clone/utils/widget_function.dart';
import 'package:whatsapp_clone/views/chat_contact.dart';

class Contacts extends StatelessWidget {
   const Contacts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _getContacts();
    return Scaffold(
      body: FutureBuilder<List<Account>>(
        future: _getContacts(),
        initialData: const [],
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const ProgressIndicatorBox();

            case ConnectionState.active:
              return Container();

            case ConnectionState.none:
              return Container();

            case ConnectionState.done:
              if (snapshot.hasData) {
                final listOfContacts = snapshot.data ?? [];

                return listOfContacts.isEmpty
                    ? _noContactsText()
                    : ListView.builder(
                        itemCount: listOfContacts.length,
                        itemBuilder: (context, index) {
                          Account contact = listOfContacts[index];
                          return ListTile(
                            onTap: () => Navigator.of(context).push( MaterialPageRoute(builder: (context) => ChatContact(contact: contact))),
                            contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                            leading: CircleAvatar(
                                    radius: 22,
                                    backgroundColor: Colors.grey,
                                    backgroundImage: contact.imageProfile.isEmpty ? null : NetworkImage(contact.imageProfile),
                                  ),
                                  title: Text(
                                        contact.name,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                        contact.email,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal),
                                      ),
                              );
                          
                        },
                      );
              } else {
                return _noContactsText();
              }
          }
        },
      ),
    );
  }

  Future<List<Account>> _getContacts() async {
    final db = instanceDB();
    final snapshots = await db.collection("users").where("id", isNotEqualTo: currentUser()!.uid).get();

    List<Account> listOfContacts = snapshots.docs.map((item) {
      var map = item.data();
      final user = Account.fromMap(map);
      return user;
    }).toList();
    return listOfContacts;
  }

  Widget _noContactsText() {
    return const Center(
      child: Text("Nenhum contato cadastrado!"),
    );
  }

}
