import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/horizontal_space.dart';

enum snackBarType { error, success, basic }

extension ShowSnackbarMessage on StatelessWidget {
  void showSnack(String text, {snackBarType type = snackBarType.basic, double fontSize = 16}) {
    final icon = type == snackBarType.basic
        ? null
        : type == snackBarType.error
            ? Icons.report_problem
            : Icons.done_all;
    final iconColor = type == snackBarType.error ? Colors.yellow : Colors.white;
    final snack = SnackBar(
      duration: const Duration(seconds: 2),
      content: Row(
        children: [
          Icon(
            icon,
            color: iconColor,
          ),
          addHorizontalSpace(5),
          Flexible(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      backgroundColor: type == snackBarType.basic
          ? Colors.grey
          : type == snackBarType.error
              ? Colors.red
              : Colors.green,
    );
    ScaffoldMessenger.of(Get.context!).showSnackBar(snack);
  }
}

extension HiddenKeyboard on StatelessWidget {

  act(){
    FocusManager.instance.primaryFocus?.unfocus();
  }

}