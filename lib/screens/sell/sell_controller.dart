

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
import '../model/product_add.dart'  as a;
import '../model/product_response.dart';

class SellController extends GetxController {

  var id=Get.arguments;
  var productId;
 
 
    var total = 0;
RxList items=<a.Items>[].obs;
var docMap=<String,dynamic>{};
    var listItem=[];

  
  

  @override
  void onInit() {
    box.read("");
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

  scan(context,id) async {
    try {
      isLoading(true);
       

      final res = await dioClient.get("product/details/$id" ,options: Options(followRedirects: false, // default is true, change to false
          maxRedirects: 0,validateStatus: (status) => status! < 500,headers: {"Accept":"application/json"}));
      print("ff $res");
   item= ProductResponse.fromJson(res).data;
   box.write("productId", item!.id);
  
    
    
      print("ff ${item!.id}");
      CustomBottomSheet(Get.put(SellController()),context,"${item?.productImage}","${item?.modelNo}","${item?.categoryName}" ,"${item!.unitPrice}","${item?.purchaseQuantity}",);

         
    
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
    var mac={
      
      "customer_name":docMap["customer_name"],
      "customer_address":docMap["customer_address"],
      "phone":docMap["phone"],
      "cart":[
       {
        
        "product": {"id":docMap["product"]},
         "sell_qty": docMap["sell_qty"],
       
       
       }]
    
    
    
    };
      final formData = dio.FormData.fromMap(docMap);
      print(docMap);
       

      final res = await dioClient.post("sell-product" ,data: formData,options: Options(followRedirects: false, // default is true, change to false
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
