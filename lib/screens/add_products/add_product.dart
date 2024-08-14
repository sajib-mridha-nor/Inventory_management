 

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:inventory_management/widgets/custom_button.dart';
import 'package:inventory_management/widgets/custom_file_picker.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/custom_text_field.dart';
import '../barcode_scanner_page.dart';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management/screens/scan/sell_page.dart';

import 'add_products_controller.dart';
 

class AddProduct extends StatefulWidget {
    AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  List<String> item=["Normal","Low","High"];  
 String barCode="Enter ...";  
 final controller=Get.put((AddProductsController())) ;
   final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return   Scaffold(appBar: AppBar(title: const Text("Add product",style: TextStyle(color: Colors.black),),),
    
    body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,

          child: Obx(()=>controller.isLoading.value==true?const Center(child: CircularProgressIndicator(),):
          Column(
              
            
              children: [
              const SizedBox(height: 20,),
                      Obx(()=>
                    CustomTextField1(
                      key: UniqueKey(),
                         isPasswordField: false,
                         isSceener: true,
                         keyboardType: TextInputType.number,
                        onScrenner: ()async {
                          debugPrint("unicked ${UniqueKey()}");
                                    var res = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>   const SimpleBarcodeScannerPage(),
                          ));
                            if (res is String) {
                         controller.productCode(res)  ;  
                        }
                                   
                         print("sdfjdkj ${controller.productCode.value}");
                               
                        },
                         
                          labelStyle: const TextStyle(fontSize: 18,color: Colors.black),
                          initialValue: controller.productCode.value,
                          
                          label: "Input product ID",onChange: (t){
                           controller.barCode=t;
                           debugPrint(controller.barCode);
                  
                         
                            
                          },hint: "Enter or Scane barcode..",),
                      ),  
                      
                        const SizedBox(height: 16,),
                         CustomDropdown(
                              labelStyle: const TextStyle(fontSize: 18,color: Colors.black),
                        label: "Category",
                        onChange: (item){
                           final id=  controller.catagoryList?.firstWhere((element) => element.name==item?.trim()).id;
                          controller.docMap["category_id"]=id.toString();
                        },
                        items: controller.catagoryList!.map((e) => e.name!).toList(),
                       hint: "Select Category",),
                
                        const SizedBox(height: 16,),
                         CustomDropdown(
                              labelStyle: const TextStyle(fontSize: 18,color: Colors.black),
                        label: "Type",
                        onChange: (item){
                  
                          controller.docMap["type"]=item.toString();
                        },
                        items: item,
                       hint: "Select Type",),
                
                        const SizedBox(height: 16,),
                         CustomDropdown(
                              labelStyle: const TextStyle(fontSize: 18,color: Colors.black),
                        label: "Size",
                        onChange: (item){
                          controller.docMap["size"]=item.toString();


                        },
                        items: item,
                       hint: "Select Size",),
                
                        const SizedBox(height: 16,),
                         CustomTextField1(
                       isPasswordField: false,
                       isSceener: false,
                
                        // txt: "Enter Your password",
                        labelStyle: const TextStyle(fontSize: 18,color: Colors.black),
                        
                        label: "Model",onChange: (t){
                          controller.docMap["model_no"]=t.toString();
                        
                          
                        },hint: "Enter Model.... ",),
                      
                        const SizedBox(height: 16,),
                         CustomDropdown(
                              labelStyle: const TextStyle(fontSize: 18,color: Colors.black),
                        label: "Manufacturer",
                        onChange: (item){
                        final id=  controller.manufactureList?.firstWhere((element) => element.manufactureName==item?.trim()).id;
                          controller.docMap["manufacturer_id"]=id.toString();
                  
                        },
                        items:  controller.manufactureList!.map((e) => e.manufactureName!).toList(),
                       hint: "Select Manufacturer",),
                
                
                      const SizedBox(height: 16,),
                      CustomTextField1(
                       isPasswordField: false,
                       isSceener: false,
                
                        // txt: "Enter Your password",
                        labelStyle: const TextStyle(fontSize: 18,color: Colors.black),
                        keyboardType: TextInputType.number,
                        
                        label: "Quantity",onChange: (t){
                     
                          controller.docMap["purchase_quantity"]=t.toString();
              
                          
                        },hint: "Enter Quantity.... ",),
                
                
                   
                
                
                      const SizedBox(height: 16,),
                      CustomDropdown(
                        label: "Supplier",
                        labelStyle: const TextStyle(fontSize: 18,color: Colors.black),
                  
                        onChange: (item){
                            final id=  controller.vendorList?.firstWhere((element) => element.vendorName==item?.trim()).id;
                          controller.docMap["purchase_supplier_id"]=id.toString();
                        },
                        items: controller.vendorList!.map((e) => e.vendorName!).toList(),
                       hint: "Enter Supplier..",),
                      const SizedBox(height: 16,),
                  
                       CustomFilePicker(
                        labelStyle: const TextStyle(fontSize: 18,color: Colors.black),
                       
                        hint: "Choose",
                        label: "Choose in image",
                        allowedExtensions: ["jpg","jpeg","png"],
                        onChange: (file){
          
                          controller.docMap["product_image"]=file.path;
                          print("object");
                        },),
                
                
                      const SizedBox(height: 20,),
                      CustomButton(isLoading:  controller.subLoading.value,title: "Add Product",
                      
                      
                      
                      onPressed:    controller.subLoading.value==true?null: (){
                                    if (_formKey.currentState!.validate()) {
                                      controller.barCode==null?
                                      controller.docMap["product_code"]=controller.productCode:
                                      controller.docMap["product_code"]=controller.barCode;

                                      
                                      debugPrint("${controller.docMap}");
                                      print("${controller.docMap}");
                                      controller.addProduct();
                                    
                                                
                                                  } 
                                        
                                      },)
            ],),
          ),
        ),
      ),
    ),
    );
  }
}