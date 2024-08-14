import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
 
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:inventory_management/screens/main_page.dart';
import 'package:inventory_management/screens/model/login_response.dart';

import '../../utils/constant.dart';
import '../../utils/network/dio_client.dart';
import '../../utils/network/network_exceptions.dart';

class AuthController extends GetxController {
  final dioClient = DioClient(BASE_URL, Dio());
  GetStorage box = GetStorage();
  LoginResonse? loginResonse;

  Map<String, dynamic> map = {};
  RxBool isLoading = false.obs;

  login() async {
    try {
      isLoading(true);
      final formData = dio.FormData.fromMap(map);

      final res = await dioClient.post("login", data: formData,options: Options(followRedirects: false, // default is true, change to false
          maxRedirects: 0,validateStatus: (status) => status! < 500,headers: {"Accept":"application/json"}));
      print("ff $res");
     loginResonse= LoginResonse.fromJson(res);
      print("ff $loginResonse");

      box.write("token", loginResonse?.accessToken.toString());
      box.write("user", loginResonse);

      print("ff $res");
      Get.snackbar(
        "Succeful !!",
        "Succeful Loging ",
        backgroundColor: Colors.green.withOpacity(.6),
        snackPosition: SnackPosition.TOP,
      );
      Get.offAll(MainPage());
      isLoading(false);
    } catch (e) {
      isLoading(false);
      var error = NetworkExceptions.getDioException(e);
      var message = NetworkExceptions.getErrorMessage(error);
      Get.snackbar(
        "Try againg",
        "$message",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }


  @override
  void onClose() {
    // pagingController.dispose();
    super.onClose();
  }
}
