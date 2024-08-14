

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
 
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:inventory_management/screens/invoice/invoice.dart';
import 'package:inventory_management/screens/main_page.dart';
import 'package:inventory_management/screens/model/login_response.dart';
import 'package:inventory_management/screens/sell/sell_product_page.dart';

import '../../utils/constant.dart';
import '../../utils/network/dio_client.dart';
import '../../utils/network/network_exceptions.dart';
import '../../utils/url_luncher.dart';
import '../model/product_manufacture.dart';
import '../model/product_response.dart';
import '../model/stock_products.dart';
import '../model/suplirer.dart';

class StockController extends GetxController {

  var id=Get.arguments;
  RxString? productId="".obs;
    var total = 0;
RxList items=<Item>[].obs;
var docMap={};
    var listItem=[];

  
  

  @override
  void onInit() {
    box.read("");
    getRequireData();

    
 
 
     
    super.onInit();
  }
  final dioClient = DioClient(BASE_URL, Dio());
  GetStorage box = GetStorage();
List <StockProduct>? item;
List <Suplirer>? suplirerList;
List <Manufacture>? manufactureList;
 
  

  Map<String, dynamic> map = {};
  Map<String, dynamic> sellmap = {};
  RxBool isLoading = false.obs;
  RxBool subLoading = false.obs;
  RxString productCode = "".obs;

getStockProducts() async {
    try {
      isLoading(true);
      final res = await dioClient.get("stock" ,options: Options(followRedirects: false, // default is true, change to false
          maxRedirects: 0,validateStatus: (status) => status! < 500,headers: {"Accept":"application/json"}));
      print("ff $res");
  item= StockProducts.fromJson(res).data;

      isLoading(false);
    } catch (e) {
      isLoading(false);
      
      var error = NetworkExceptions.getDioException(e);
      var message = NetworkExceptions.getErrorMessage(error);
       print("catch $message");
      
    }
  }

  getRequireData()async{

     try {
      isLoading(true);
      final manufactureRes = await dioClient.get("manufacture" ,options: Options(followRedirects: false, // default is true, change to false
          maxRedirects: 0,validateStatus: (status) => status! < 500,headers: {"Accept":"application/json"}));
      print("ff $manufactureRes");
  manufactureList= ProductsManufacture.fromJson(manufactureRes).data;

      final supRes = await dioClient.get("purchase-vendor" ,options: Options(followRedirects: false, // default is true, change to false
          maxRedirects: 0,validateStatus: (status) => status! < 500,headers: {"Accept":"application/json"}));
      print("ff $supRes");
  suplirerList= ProductsSuplirer.fromJson(supRes).data;


  //     final res = await dioClient.get("manufacture" ,options: Options(followRedirects: false, // default is true, change to false
  //         maxRedirects: 0,validateStatus: (status) => status! < 500,headers: {"Accept":"application/json"}));
  //     print("ff $res");
  // var item= ProductsManufacture.fromJson(res).data;

      isLoading(false);
    } catch (e) {
      isLoading(false);
      
      var error = NetworkExceptions.getDioException(e);
      var message = NetworkExceptions.getErrorMessage(error);
       print("catch $message");
      
    }

  }

  sellProduct() async {
    try {
      subLoading(true);
      final formData = dio.FormData.fromMap(map);
       

      final res = await dioClient.post("sell-product}" ,data: formData,options: Options(followRedirects: false, // default is true, change to false
          maxRedirects: 0,validateStatus: (status) => status! < 500,headers: {"Accept":"application/json"}));
      print("ff $res");
   
    
    
      print("ff $res");


           Get.snackbar(
        "Succeful !!",
        "${res["message"]}",
        backgroundColor: Colors.green.withOpacity(.6),
        snackPosition: SnackPosition.TOP,
      );
    Get.to(MainPage());
    
      subLoading(false);
    } catch (e) {
      subLoading(false);
      var error = NetworkExceptions.getDioException(e);
      var message = NetworkExceptions.getErrorMessage(error);
       Get.snackbar(
        "fail !!",
        "${message}",
        backgroundColor: Colors.red.withOpacity(.6),
        snackPosition: SnackPosition.TOP,
      );
      
    }
  }


  @override
  void onClose() {
    // pagingController.dispose();
    super.onClose();
  }
}
