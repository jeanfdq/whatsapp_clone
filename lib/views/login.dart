import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/utils/constants.dart';
import 'package:whatsapp_clone/utils/widget_function.dart';

import '../components/custom_login_textfield.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: kPrimaryColor),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset("assets/images/whatsapp-logo.png"),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
                  child: CustomLoginTextField(
                    controller: _emailController,
                    hint: "email@example.com.br",
                    keyboardType: TextInputType.emailAddress,
                    autoFocus: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
                  child: CustomLoginTextField(
                    controller: _passwordController,
                    hint: "informe sua senha",
                    keyboardType: TextInputType.number,
                    isSecurity: true,
                  ),
                ),
                addVerticalSpace(30),
                ElevatedButton(
                  onPressed: _loginAction,
                  child: const Text(
                    "LogIn",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(kPrimaryLightColor),
                    minimumSize:
                        MaterialStateProperty.all(Size(Get.width * 0.85, 55)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32))),
                  ),
                ),
                addVerticalSpace(15),
                Center(
                  child: InkWell(
                      child: const Text(
                    "Não tem conta? Clique aqui e cadastra-se!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  onTap: _signUpAction,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _loginAction() {
    log("message");
  }

  void _signUpAction(){
    log("message");
  }
}
