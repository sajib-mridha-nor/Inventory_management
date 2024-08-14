import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:inventory_management/screens/scan/sell_page.dart';
import 'package:inventory_management/screens/stock/stock_controller.dart';
import 'package:inventory_management/screens/stock_page.dart';
import 'package:inventory_management/widgets/custom_button.dart';
import 'package:lottie/lottie.dart';

import '../add_products/add_product.dart';
import 'modify_page.dart';

class StockListPage extends StatefulWidget {
  const StockListPage({super.key,this.title=false});
final bool title;
  @override
  State<StockListPage> createState() => _StockListPageState();
}

class _StockListPageState extends State<StockListPage> {

  final controller=Get.put(StockController());

  @override
  void initState() {

    controller.getStockProducts();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:widget.title==true?null: AppBar(
        title: Text(
          "Stock product",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Obx(()=>controller.isLoading.value==true?Center(child: CircularProgressIndicator()):
         Padding(
            padding: EdgeInsets.all(12.0),
            child:
            
             ListView.separated(
              separatorBuilder: (context, index) => Divider(),
            
              itemBuilder: (_, index) { 
                var item=controller.item?[index];
                
               return ProductCard(img:item?.productImage,
               catagory:item?.categoryName,
               model: item?.modelNo,totalStock: item?.purchaseQuantity,avblStock: item?.purchaseQuantityToAfterSell,
              onClick: () {
                Get.to(ModifyProductPage(image:item?.productImage,manufacture: item?.manufactureName,supplier: item?.purchaseVendor,
               catagory:item?.categoryName,size: "12\"*12\"",type: item?.type,
               model: item?.modelNo,quantity: item?.purchaseQuantityToAfterSell,));
              },
              
              );},
              itemCount: 2
            )),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, this.img,this.avblStock,this.catagory,this.model,this.totalStock,this.onClick});
  final String? img;
  final String? model;
  final String? catagory;
  final String? totalStock;
  final String? avblStock;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.all(4),
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
        
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
        Container(
          decoration: BoxDecoration(
          
            color: Colors.white,
                                     border: Border.all(
            color: Theme.of(context).colorScheme.secondaryContainer,width: 1

                                     ),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8)),
            child:img==null?Image.asset(
            "assets/1.jpg",
              height: 90,
              width: 90,
              fit: BoxFit.cover,
            ): Image.network(
           "https://etldev.xyz/inventory-tiels/${img}"?? "assets/1.jpg",
              height: 90,
              width: 90,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 8),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
        
            children: [
              Row(
                children: [
                  
                  const Text(
                    "Total Stock :",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(width: 8,),
                 
                    Text(
                   totalStock?? "560 ",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ), Lottie.asset('assets/chart.json',
                      height: 30, width: 30, fit: BoxFit.cover),
        
                  // Text("Catagory ",style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.normal),),
                 
                ],
              ),
              Row(
                children: [
                  
                  const Text(
                    "Available :",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(width: 8,),
                 
                    Text(
                  avblStock??  "230 ",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
        
                  // Text("Catagory ",style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.normal),),
                
                ],
              ),


 const SizedBox(
                height: 4,
              ),

   Row(
                children: [
                  
                  const Text(
                    "Catagory :",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(width: 8,),
                 
                   Text(
               catagory?? "Sliky Matt ",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
                ],
              ),
              
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  
                  const Text(
                    "Model no.:",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(width: 8,),
                 
                   Text(
                "6699-MKLJH ",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
                ],
              ),
           
             
            
            ],
          ),
        ),
       

        Align(
          alignment: Alignment.bottomCenter,
          child: Icon(Icons.arrow_forward_ios,size: 18,color: Theme.of(context).buttonTheme.colorScheme?.primary,))
          ],
        ),
      ),
    );
  }
}
