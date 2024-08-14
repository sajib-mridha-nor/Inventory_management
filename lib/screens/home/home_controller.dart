

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
import '../model/today_sell.dart';
import '../model/total_customer.dart';
import '../model/total_sell.dart';
import '../model/total_stock.dart';

class HomeController extends GetxController {

  @override
  void onInit() {
    getStatic();
    // launchURL(  "${BASE_URL}product/invoice/1");
    // TODO: implement onInit
    super.onInit();
  }
  final dioClient = DioClient(BASE_URL, Dio());
  GetStorage box = GetStorage();
  var response;
  

  Map<String, dynamic> map = {};
  RxBool isLoading = false.obs;
  TotalCustomer? totalCustomer ;
  TotalSell? totalSell ;
  TodaySell? todaySell ;
  TotalStock? totalStock ;

  getStatic() async {
    try {
      isLoading(true);
       

      final resC = await dioClient.get("total-customer" ,options: Options(followRedirects: false, // default is true, change to false
          maxRedirects: 0,validateStatus: (status) => status! < 500,headers: {"Accept":"application/json"}));
   totalCustomer= TotalCustomer.fromJson(resC);
      print("ff $resC");
      final resTdS = await dioClient.get("today-sell" ,options: Options(followRedirects: false, // default is true, change to false
          maxRedirects: 0,validateStatus: (status) => status! < 500,headers: {"Accept":"application/json"}));
   todaySell= TodaySell.fromJson(resTdS);
      print("ff $resTdS");
      final resS = await dioClient.get("total-stock" ,options: Options(followRedirects: false, // default is true, change to false
          maxRedirects: 0,validateStatus: (status) => status! < 500,headers: {"Accept":"application/json"}));
   totalStock= TotalStock.fromJson(resS);
      print("ff $resS");
      final res = await dioClient.get("total-sell" ,options: Options(followRedirects: false, // default is true, change to false
          maxRedirects: 0,validateStatus: (status) => status! < 500,headers: {"Accept":"application/json"}));
   totalSell= TotalSell.fromJson(res);
      print("ff $res");

      
    
      isLoading(false);
    } catch (e) {
      isLoading(false);
      var error = NetworkExceptions.getDioException(e);
      var message = NetworkExceptions.getErrorMessage(error);
      print(message);
      
    }
  }


  @override
  void onClose() {
    // pagingController.dispose();
    super.onClose();
  }
}
