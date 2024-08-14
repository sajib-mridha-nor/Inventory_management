import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:inventory_management/screens/stock/stock_controller.dart';
import 'package:inventory_management/widgets/custom_button.dart';
import 'package:inventory_management/widgets/custom_file_picker.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/custom_text_field.dart';
import '../barcode_scanner_page.dart';


class ModifyProductPage extends StatefulWidget {
    ModifyProductPage({super.key,this.catagory,this.size,this.manufacture,this.model,this.quantity,this.supplier,this.type,this.image});
      String? model;
    final String? type;
    final String? catagory;
    final String? manufacture;
    final String? quantity;
    final String? image;
    final String? size;
    final String? supplier;

  @override
  State<ModifyProductPage> createState() => _ModifyProductPageState();
}

class _ModifyProductPageState extends State<ModifyProductPage> {
  List<String> typeList=["high","normal","low",];

  List<String> sizeList=["10\"*10\"","12\"*12\"","18\"*18\"","8\"*8\""];

  final  controller=Get.put(StockController());

  var  txtcnt=TextEditingController();
 var box=  GetStorage();

  @override
  void initState() {
  // widget. model= box.read("model");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.model;
    return   Scaffold(appBar: AppBar(title: Text("Modify product",style: TextStyle(color: Colors.black),),),
    
    body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(children: [
          SizedBox(height: 20,),
                
                    CustomTextField1(
                     isPasswordField: false,
                     isSceener: true,
                    //  editeCont: txtcnt,
                     initialValue:widget.model,
                    onScrenner: ()async {
                     Get.to(SimpleBarcodeScannerPage(
                            onClick: (value) {
                               Navigator.pop(context,);

                                 widget.model=value;
                            box.write("model", value);
                            print("${  widget.model}");

                             
                              setState(() {
                             
                              });
                             
                            },
                          ));

                           
                    },
                              
                      // txt: "Enter Your password",
                      labelStyle: TextStyle(fontSize: 18,color: Colors.black),
                      
                      
                      label: "Model No.",onChange: (t){
                                   controller.productId!(t);
                            
                        
                      },hint: "product code",),
                
                    SizedBox(height: 16,),
                     CustomDropdown(
                          labelStyle: TextStyle(fontSize: 18,color: Colors.black),
                    label: "Category",
                    onChange: (item){},
                    initialValue: "low",
                    items:typeList ,
                   hint: "Select",),
            
                    SizedBox(height: 16,),
                     CustomDropdown(
                          labelStyle: TextStyle(fontSize: 18,color: Colors.black),
                    label: "Type",
                    initialValue: "low",

                    onChange: (item){},
                    items: typeList,
                   hint: "Selectct",),
            
                    SizedBox(height: 16,),
                     CustomDropdown(
                          labelStyle: TextStyle(fontSize: 18,color: Colors.black),
                    label: "Size",
                    initialValue:widget.size,
                    onChange: (item){},
                    items:sizeList,
                   hint: "Select",),
            
                    SizedBox(height: 16,),
                  
                     CustomDropdown(
                          labelStyle: TextStyle(fontSize: 18,color: Colors.black),
                    label: "Manufacturer",
                    initialValue:widget.manufacture ,

                    onChange: (item){},
                    items: controller.manufactureList!.map((e) => e.manufactureName.toString()).toList(),
                   hint: "Select",),
            
            
                  SizedBox(height: 16,),
                  CustomTextField1(
                   isPasswordField: false,
                   isSceener: false,
                   initialValue: widget.quantity,
            
                    // txt: "Enter Your password",
                    labelStyle: TextStyle(fontSize: 18,color: Colors.black),
                    
                    label: "Available Quantity",onChange: (t){
                      print(t);
          
                      
                    },hint: "Enter Quantity.... ",),
            
            
               
            
            
                  SizedBox(height: 16,),
                  CustomDropdown(
                    label: "Supplier",
                    initialValue: widget.supplier,
                    labelStyle: TextStyle(fontSize: 18,color: Colors.black),

                    onChange: (item){},
            items: controller.suplirerList!.map((e) => e.vendorName.toString()).toList(),

                   hint: "Choose",),
                  SizedBox(height: 16,),

                   CustomFilePicker(
                    initialImg: "https://etldev.xyz/inventory-tiels/${widget.image}",
                    labelStyle: TextStyle(fontSize: 18,color: Colors.black),
                   
                    hint: "Choose",
                    // endIcon: Icon(Icons.photo_library),
                    label: "Choose in image",
                    allowedExtensions: ["jpg","jpeg","png"],
                    onChange: (file){
                      print("object");
                    },),
            
            
                  SizedBox(height: 20,),
                  CustomButton(isLoading: false,title: "Update Product",
                  
                radius: 12,
                  )
        ],),
      ),
    ),
    );
  }
}