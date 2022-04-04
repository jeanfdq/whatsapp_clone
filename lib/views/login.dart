
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/utils/constants.dart';

class Login extends StatelessWidget {
  Login({ Key? key }) : super(key: key);

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration( color: kdarkGreenColor ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(children: [
                Image.asset("assets/images/whatsapp-logo.png"),
                TextField(
                controller: _emailController,
                autofocus: true,
                decoration: const InputDecoration( label: Text("E-mail: "), ),
                ),
                TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration( label: Text("Senha: "), ),
                )
            ],),
          ),
        ),
      ),
    );
  }
}