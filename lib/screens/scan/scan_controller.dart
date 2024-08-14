

// import 'package:dio/dio.dart' as dio;
// import 'package:dio/dio.dart';
 
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
// import 'package:inventory_management/screens/invoice/invoice.dart';
// import 'package:inventory_management/screens/main_page.dart';
// import 'package:inventory_management/screens/model/login_response.dart';

// import '../../utils/constant.dart';
// import '../../utils/network/dio_client.dart';
// import '../../utils/network/network_exceptions.dart';
// import '../../utils/url_luncher.dart';
// import '../model/product_response.dart';

// class ScanController extends GetxController {

//   var id=Get.arguments;
//   var productId;
  

//   @override
//   void onInit() {
//     print("int id  kk ${id}");
    
  
//   scan(id["id"]);
 
     
//     super.onInit();
//   }
//   final dioClient = DioClient(BASE_URL, Dio());
//   GetStorage box = GetStorage();
//  ProductResponse? productResponse;
 
  

//   Map<String, dynamic> map = {};
//   Map<String, dynamic> sellmap = {};
//   RxBool isLoading = false.obs;
//   RxBool subLoading = false.obs;

//   scan(id) async {
//     try {
//       isLoading(true);
       

//       final res = await dioClient.get("product/details/$id" ,options: Options(followRedirects: false, // default is true, change to false
//           maxRedirects: 0,validateStatus: (status) => status! < 500,headers: {"Accept":"application/json"}));
//       print("ff $res");
//    productResponse= ProductResponse.fromJson(res);
//    box.write("productId", productResponse!.data?[0].id);
  
    
    
//       print("ff ${productResponse!.data?[0].id}");

         
    
//       isLoading(false);
//     } catch (e) {
//       isLoading(false);
//       var error = NetworkExceptions.getDioException(e);
//       var message = NetworkExceptions.getErrorMessage(error);
      
//     }
//   }

//   sellProduct() async {
//     try {
//       subLoading(true);
//       final formData = dio.FormData.fromMap(map);
       

//       final res = await dioClient.post("sell-product/${box.read("productId")}" ,data: formData,options: Options(followRedirects: false, // default is true, change to false
//           maxRedirects: 0,validateStatus: (status) => status! < 500,headers: {"Accept":"application/json"}));
//       print("ff $res");
   
    
    
//       print("ff $productResponse");


//            Get.snackbar(
//         "Succeful !!",
//         "${res["message"]}",
//         backgroundColor: Colors.green.withOpacity(.6),
//         snackPosition: SnackPosition.TOP,
//       );
//     Get.to(MainPage());
    
//       subLoading(false);
//     } catch (e) {
//       subLoading(false);
//       var error = NetworkExceptions.getDioException(e);
//       var message = NetworkExceptions.getErrorMessage(error);
//        Get.snackbar(
//         "fail !!",
//         "${message}",
//         backgroundColor: Colors.red.withOpacity(.6),
//         snackPosition: SnackPosition.TOP,
//       );
      
//     }
//   }


//   @override
//   void onClose() {
//     // pagingController.dispose();
//     super.onClose();
//   }
// }
