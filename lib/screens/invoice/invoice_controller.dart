

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

class InvoiceController extends GetxController {

  @override
  void onInit() {
    getInvoice();
    launchURL(  "${BASE_URL}product/invoice/1");
    // TODO: implement onInit
    super.onInit();
  }
  final dioClient = DioClient(BASE_URL, Dio());
  GetStorage box = GetStorage();
  var response;
  

  Map<String, dynamic> map = {};
  RxBool isLoading = false.obs;

  getInvoice() async {
    try {
      isLoading(true);
       

      final res = await dioClient.get("product/invoice/1" ,options: Options(followRedirects: false, // default is true, change to false
          maxRedirects: 0,validateStatus: (status) => status! < 500,headers: {"Accept":"application/json"}));
     response=res;
      print("ff $res");

         
    
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
