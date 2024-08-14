

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
 
import '../model/expense_history.dart';
import '../model/product_manufacture.dart';
import '../model/product_response.dart';
import '../model/stock_products.dart';
import '../model/suplirer.dart';

class ExpenseHistoryController extends GetxController {

  var id=Get.arguments;
  RxString? productId="".obs;
    var total = 0;
RxList items=<Item>[].obs;
var docMap={};
    var listItem=[];

  
  

  @override
  void onInit() {
    box.read("");
getExpenseHistory();

    
 
 
     
    super.onInit();
  }
  final dioClient = DioClient(BASE_URL, Dio());
  GetStorage box = GetStorage();
List <StockProduct>? item;
List <Suplirer>? suplirerList;
List <Expense>? expenseHistory;
String? startDate;
RxString totalAmount="0".obs;
 
  

  Map<String, dynamic> map = {};
  Map<String, dynamic> sellmap = {};
  RxBool isLoading = false.obs;
  RxBool subLoading = false.obs;
  RxString productCode = "".obs;

getExpenseHistory() async {
    try {
      isLoading(true);
      final res = await dioClient.get("expense-record-show" ,options: Options(followRedirects: false, // default is true, change to false
          maxRedirects: 0,validateStatus: (status) => status! < 500,headers: {"Accept":"application/json"}));
      print("ff $res");
 var data= ExpenseHistory.fromJson(res);
 expenseHistory=data.expense;
 totalAmount.value=data.totalAmount.toString();
 

  var d2=data.date?.split("-");
   startDate="${d2![2]+"/"+d2[1]+"/"+d2[0]}";


      isLoading(false);
    } catch (e) {
      isLoading(false);
      
      var error = NetworkExceptions.getDioException(e);
      var message = NetworkExceptions.getErrorMessage(error);
       print("catch $message");
      
    }
  }

  @override
  void onClose() {
    // pagingController.dispose();
    super.onClose();
  }
}
