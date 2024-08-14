import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:inventory_management/screens/invoice/invoice_controller.dart';
import 'package:share_plus/share_plus.dart';

import '../../utils/url_luncher.dart';

class InvoicePage extends StatelessWidget {
    InvoicePage({super.key});
  final controller=Get.put(InvoiceController());
  

  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [IconButton(onPressed: ()async{
        Share.share('check out my website https://example.com', subject: 'Look what I made!');

      }, icon: Icon(Icons.share)),IconButton(onPressed: (){

      }, icon: Icon(Icons.print))],),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Divider(height: 1,),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Center(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:  Html(
            data: """${controller.response}""",
          )
                  //  Image.asset("assets/invoice.png",height: 500,
                  // width: double.infinity,
                  // fit: BoxFit.cover,),
                ),
                ),
                SizedBox(height: 96,)
                ],),
          ),
        ],
      ),
    );
  }
}