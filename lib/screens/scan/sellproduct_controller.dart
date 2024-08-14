

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
 
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:inventory_management/screens/invoice/invoice.dart';
import 'package:inventory_management/screens/main_page.dart';
import 'package:inventory_management/screens/model/login_response.dart';

import '../../utils/constant.dart';
import '../../utils/network/dio_client.dart';
import '../../utils/network/network_exceptions.dart';
import '../../utils/url_luncher.dart';
import '../model/product_response.dart';

class SellProductController extends GetxController {

  var id=Get.arguments;

  @override
  void onInit() {
    print("int id  kk ${id}");
  
  scan(id["id"]);
 
     
    super.onInit();
  }
  final dioClient = DioClient(BASE_URL, Dio());
  GetStorage box = GetStorage();
 ProductResponse? productResponse;
  

  Map<String, dynamic> map = {};
  RxBool isLoading = false.obs;

  scan(id) async {
    try {
      isLoading(true);
       

      final res = await dioClient.get("product/details/$id" ,options: Options(followRedirects: false, // default is true, change to false
          maxRedirects: 0,validateStatus: (status) => status! < 500,headers: {"Accept":"application/json"}));
      print("ff $res");
   productResponse= ProductResponse.fromJson(res);
    
    
      print("ff $productResponse");

         
    
      isLoading(false);
    } catch (e) {
      isLoading(false);
      var error = NetworkExceptions.getDioException(e);
      var message = NetworkExceptions.getErrorMessage(error);
      
    }
  }


  @override
  void onClose() {
    // pagingController.dispose();
    super.onClose();
  }
}
