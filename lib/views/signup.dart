import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp_clone/models/account.dart';
import 'package:whatsapp_clone/utils/constants.dart';
import 'package:whatsapp_clone/utils/database/create_user.dart';
import 'package:whatsapp_clone/utils/extensions/stateless_extension.dart';
import 'package:whatsapp_clone/views/home.dart';

import '../components/custom_login_textfield.dart';
import '../components/vertical_space.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  static const id = "/signup";

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final isValidFields = true;
  final errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: InkWell(
          onTap: _hiddenKeyboard,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                      child: InkWell(
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        onTap: _goBack,
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.account_circle,
                  color: Colors.white,
                  size: 112,
                ),
                addVerticalSpace(32),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: SizedBox(
                    width: Get.width,
                    height: 280,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomLoginTextField(
                          controller: _nameController,
                          hint: "Nome completo",
                        ),
                        CustomLoginTextField(
                          controller: _emailController,
                          hint: "email@exemple.com.br",
                          keyboardType: TextInputType.emailAddress,
                        ),
                        CustomLoginTextField(
                          controller: _passwordController,
                          hint: "Senha com 6 números",
                          keyboardType: TextInputType.number,
                          isSecurity: true,
                        ),
                        ElevatedButton(
                          onPressed: _signUp,
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(kPrimaryLightColor),
                            minimumSize:
                                MaterialStateProperty.all(Size(Get.width, 50)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _hiddenKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  _goBack() {
    Navigator.of(Get.context!).pop();
  }

  _signUp() async {
    _hiddenKeyboard();

    if (_nameController.text.length < 3) {
      ShowSnackbarMessage(this).showSnack(
          "O nome deverá ter no mínimo 3 caracteres!",
          type: snackBarType.error);
    } else if (!GetUtils.isEmail(_emailController.text)) {
      ShowSnackbarMessage(this)
          .showSnack("E-mail informado inválido!", type: snackBarType.error);
    } else if (_passwordController.text.length != 6) {
      ShowSnackbarMessage(this).showSnack("Informe a senha com 6 digitos!",
          type: snackBarType.error);
    } else {

        final account = Account(id: const Uuid().v1(), name: _nameController.text, email: _emailController.text, imageProfile: "", password: _passwordController.text);

        final user = await createUser(account);
          if (user != null) {
            Get.offAllNamed(Home.id);
          } else {
            ShowSnackbarMessage(this).showSnack("Ops! Algo deu errado!", type: snackBarType.error);
          }
    }
  }
}
