
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/views/profile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  static const id = "/home";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "WhatsApp",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          centerTitle: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: InkWell(
                onTap: _goToProfile,
                child: const Icon(
                  Icons.account_circle,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
          ],
          bottom: const TabBar(
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 2,
            tabs: [
              Tab(
                  child: Icon(
                Icons.forum,
                color: Colors.white,
                size: 22,
              )),
              Tab(
                  child: Icon(
                Icons.perm_contact_calendar,
                color: Colors.white,
                size: 22,
              )),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Text("Tab1"),
            Text("Tab2"),
          ],
        ),
      ),
    );
  }

  _goToProfile() {
    Get.toNamed(Profile.id);
  }

}
