
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/components/empty_center_text.dart';
import 'package:whatsapp_clone/components/progress_indicator_box.dart';
import 'package:whatsapp_clone/models/account.dart';
import 'package:whatsapp_clone/views/chat_contact.dart';

import '../utils/database/get_contacts.dart';

class Contacts extends StatelessWidget {
   const Contacts({Key? key}) : super(key: key);

   final emptyText = "Nenhum contato cadastrado!";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: FutureBuilder<List<Account>>(
        future: getContacts(),
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
                    ? setEmptyCenterText(emptyText)
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
                return setEmptyCenterText(emptyText);
              }
          }
        },
      ),
    );
  }

}
