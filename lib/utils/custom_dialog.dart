 
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/color_schemes.g.dart'; 
void customDialog(title,midline) {
  Get.defaultDialog(
    
    title: "$title",
middleText: midline,
    backgroundColor: Colors.white.withOpacity(.9),
    titleStyle: TextStyle(
      color: Colors.green,
    ),
    middleTextStyle: TextStyle(color: Colors.black54),
    
    textCancel: "Okay",
    // "ঠিক আছে",
    titlePadding: EdgeInsets.only(top: 16),
    contentPadding: EdgeInsets.only(bottom: 16,left: 8,top: 8,right: 8),
    cancelTextColor: Colors.black,
    confirmTextColor: Colors.black,
    buttonColor: lightColorScheme.primary,
    barrierDismissible: false,
    radius: 20,
   
  );
}
