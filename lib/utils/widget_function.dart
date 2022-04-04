
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget addVerticalSpace(double height ) {
  return SizedBox(height: height);
}

Widget addHorizontalSpace(double width) {
  return SizedBox(width: width);
}

Widget addSeparetedRow(){
  return Container(color: Colors.grey, height: 0.3, width: Get.width,);
}