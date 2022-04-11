

import 'package:flutter/material.dart';

import 'vertical_space.dart';

void addDialog( BuildContext context, bool dismiss){
  if (dismiss) {
      Navigator.pop(context);
    } else {
      showDialog (
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: Colors.white,
                  width: 150,
                  height: 100,
                  child: Center(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircularProgressIndicator(),
                          addVerticalSpace(12),
                          const Text("...carregando")
                        ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
}