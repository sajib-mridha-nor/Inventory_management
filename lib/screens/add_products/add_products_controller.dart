
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:path/path.dart';
 
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
import '../model/product_add.dart'  as a;
import '../model/product_response.dart';
import 'model/catagory.dart';
import 'model/manufacture.dart';
import 'model/vendor.dart';

class AddProductsController extends GetxController {

  var id=Get.arguments;
  var productId;
    var total = 0;
RxList items=<a.Items>[].obs;
var docMap=<String ,dynamic>{};
    var listItem=[];

  
  

  @override
  void onInit() {
   getRequireData();
    print("int id  kk ${id}");
    
 
 
     
    super.onInit();
  }
  final dioClient = DioClient(BASE_URL, Dio());
  GetStorage box = GetStorage();
 Item? item;
 
  

  Map<String, dynamic> map = {};
  Map<String, dynamic> sellmap = {};
  RxBool isLoading = false.obs;
  RxBool subLoading = false.obs;
  RxString productCode = "".obs;
   String? barCode;
List  <Catagory>? catagoryList=<Catagory>[];
List  <Manufacture>? manufactureList=<Manufacture>[];
List  <Vendor>? vendorList=<Vendor>[];

  scan(context,id) async {
    try {
      isLoading(true);
       

      final res = await dioClient.get("product/details/$id" ,options: Options(followRedirects: false, // default is true, change to false
          maxRedirects: 0,validateStatus: (status) => status! < 500,headers: {"Accept":"application/json"}));
      print("ff $res");
   item= ProductResponse.fromJson(res).data;
   box.write("productId", item!.id);
  
    
    
      print("ff ${item!.id}");
    
         
    
      isLoading(false);
    } catch (e) {
      isLoading(false);
      
      var error = NetworkExceptions.getDioException(e);
      var message = NetworkExceptions.getErrorMessage(error);
       print("catch $message");
      
    }
  }

  addProduct() async {
    try {
      subLoading(true);
      print("sub");
        docMap["product_image"] = await dio.MultipartFile.fromFile(
         docMap["product_image"],
          filename: basename( docMap["product_image"]));
      print("sub 2");

      final formData = dio.FormData.fromMap(docMap);

         

      final res = await dioClient.post("product-store" ,data: formData,options: Options(followRedirects: false, // default is true, change to false
          maxRedirects: 0,validateStatus: (status) => status! < 500,headers: {"Accept":"application/json"}));
      print("ff $res");
   
    
    
      print("ff $res");


           Get.snackbar(
        "Succeful !!",
        "${res["message"]}",
        backgroundColor: Colors.green.withOpacity(.6),
        snackPosition: SnackPosition.TOP,
      );
    Get.off(MainPage());
    
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


  getRequireData() async {
    try {
      isLoading(true);
       

      final resC = await dioClient.get("category" ,options: Options(followRedirects: false, // default is true, change to false
          maxRedirects: 0,validateStatus: (status) => status! < 500,headers: {"Accept":"application/json"}));
   catagoryList= CategoryResponse.fromJson(resC).data;
      print("catagoryList $resC");
      
      final resM = await dioClient.get("manufacture" ,options: Options(followRedirects: false, // default is true, change to false
          maxRedirects: 0,validateStatus: (status) => status! < 500,headers: {"Accept":"application/json"}));
   manufactureList= ManufactureResponse.fromJson(resM).data;
      print("mnaufa $manufactureList");
      final resV = await dioClient.get("purchase-vendor" ,options: Options(followRedirects: false, // default is true, change to false
          maxRedirects: 0,validateStatus: (status) => status! < 500,headers: {"Accept":"application/json"}));
   vendorList= VendorResponse.fromJson(resV).data;
      print("vendor $vendorList");

      

         
    
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
