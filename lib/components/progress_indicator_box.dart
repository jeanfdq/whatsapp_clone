
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/widget_function.dart';

class ProgressIndicatorBox extends StatelessWidget {
  const ProgressIndicatorBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      color: Colors.black.withOpacity(0.2),
      child: Center(
        child: Container(
          width: 180,
          height: 110,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                addVerticalSpace(12),
                const Text("... aguarde")
              ],
            ),
          ),
        ),
      ),
    );
  }
}