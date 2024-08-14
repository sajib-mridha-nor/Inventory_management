import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:inventory_management/screens/calculator/calculator.dart';
import 'package:inventory_management/screens/home/home_controller.dart';
import 'package:inventory_management/screens/stock/stock_list_page.dart';
import 'package:inventory_management/screens/stock_page.dart';

import '../add_products/add_product.dart';
import '../expense/Expense_page.dart';
import '../scan/sell_page.dart';
import '../sell/sell_product_page.dart';
import '../sign_up_page.dart';

class HomePage extends StatelessWidget {
    HomePage({
    super.key,
  });

  final controller=Get.put(HomeController());
  Future<void> _onRefresh()async{
   return controller.getStatic();

  }

  @override
  Widget build(BuildContext context) {
    var clr = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: RefreshIndicator(
          onRefresh: () => _onRefresh(),
          child: ListView(
            // mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8), color: clr.primary),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                    child: Obx(()=>
                        Column(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: clr.primary),
                            child: Center(
                                child: Text(
                              "Total Overview",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                         Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.white),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              flex: 5,
                                              child: CustomStaticCard(
                                                isLoading: controller.isLoading.value,
                                                clr: clr.secondaryContainer,
                                                value: controller.totalStock?.totalStock.toString(),
                                              )),
                                          SizedBox(
                                            width: 6,
                                          ),
                                          SizedBox(
                                              height: 36,
                                              width: 4,
                                              child: VerticalDivider(
                                                color: clr.tertiaryContainer,
                                                thickness: 1,
                                              )),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: CustomStaticCard(
                                                isLoading: controller.isLoading.value,
                    
                                              img: "assets/average.png",
                                              label: "Total sell",
                                              clr: clr.tertiaryContainer,
                                  value: controller.totalSell?.totalSell.toString(),
                    
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.white),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 5,
                                            child: CustomStaticCard(
                                                isLoading: controller.isLoading.value,
                    
                                              img: "assets/customer.png",
                                              label: "Total Customer",
                                              clr: clr.primary.withOpacity(.5),
                                                value: controller.totalCustomer?.totalCustomer.toString(),
                    
                                            ),
                                          ),
                                          SizedBox(
                                            width: 6,
                                          ),
                                          SizedBox(
                                              height: 36,
                                              width: 4,
                                              child: VerticalDivider(
                                                color: clr.tertiaryContainer,
                                                thickness: 1,
                                              )),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: CustomStaticCard(
                                                isLoading: controller.isLoading.value,
                    
                                              img: "assets/sell.png",
                                              label: "Today Sell",
                                              clr: clr.secondaryContainer.withOpacity(.8),
                                                value: controller.todaySell?.todaySell.toString(),
                                            
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                             
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              //   SizedBox(height: 34,) ,
              // Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       Transform.rotate(
              //         angle: -6.7,
              //         child: InkWell(
              //          onTap: (){
              //            Get.to(AddProduct());
              //          },
              //           child: GlassContainer(
              //                     height: 100,
              //                     width: 140,
              //                     blur: 4,
              //                     color: Colors.yellow,
              //                     // gradient: LinearGradient(
              //                     //   begin: Alignment.topLeft,
              //                     //   end: Alignment.bottomRight,
              //                     //   colors: [
              //                     //     Colors.white.withOpacity(0.2),
              //                     //     Colors.blue.withOpacity(0.3),
              //                     //   ],
              //                     // ),
              //                     //--code to remove border
              //                     border: Border.fromBorderSide(BorderSide.none),
              //                     shadowStrength: 5,
              //                     shape: BoxShape.rectangle,
              //                     borderRadius: BorderRadius.circular(16),
              //                     // shadowColor: Colors.grey.withOpacity(1),
              //                     child:  Container(
              //                     padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 16),
        
              //                     decoration: BoxDecoration(
              //                        gradient: LinearGradient(
              //               begin: Alignment.topLeft,
              //               end: Alignment.bottomRight,
              //               colors: [
              //                 Colors.blue.withOpacity(.3),
              //                 Colors.pink.withOpacity(.3),
              //               ],
              //             ),
              //                       // color: Theme.of(context).colorScheme.secondary,
              //                       borderRadius: const BorderRadius.only(
              //                         topLeft: Radius.circular(10),
              //                               topRight: Radius.circular(10),
              //                               bottomLeft: Radius.circular(10),
              //                               bottomRight: Radius.circular(10)
              //                       ),
              //                       // boxShadow: [
              //                       //   BoxShadow(
              //                       //         color: Colors.grey.withOpacity(.9),
              //                       //         spreadRadius: 2,
              //                       //         blurRadius: 5,
              //                       //         offset: const Offset(0, 2), // changes position of shadow
              //                       //   ),
              //                       // ],
              //                     ),
              //                            child:    const Center(child: Text("Add Product",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),)),
        
              //                   ),
        
              //                   ),
              //         ),
              //          ),SizedBox(height: 16,),
              // Transform.rotate(
              //         angle: 6.7,
        
              //         child: InkWell(onTap: (){
              //          Get.to(StockPage());
              //         },
              //           child: GlassContainer(
              //                     height: 100,
              //                     width: 140,
              //                     blur: 4,
              //                     color: Colors.white.withOpacity(0.1),
              //                     gradient: LinearGradient(
              //                       begin: Alignment.topLeft,
              //                       end: Alignment.bottomRight,
              //                       colors: [
              //                         Colors.white.withOpacity(0.2),
              //                         Colors.blue.withOpacity(0.3),
              //                       ],
              //                     ),
              //                     //--code to remove border
              //                     border: Border.fromBorderSide(BorderSide.none),
              //                     shadowStrength: 5,
              //                     shape: BoxShape.circle,
              //                     borderRadius: BorderRadius.circular(16),
              //                     shadowColor: Colors.white.withOpacity(0.24),
              //                     child:  Container(
        
              //                     padding: EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 8),
        
              //                     decoration: BoxDecoration(
              //                        gradient: LinearGradient(
              //               begin: Alignment.topLeft,
              //               end: Alignment.bottomRight,
              //               colors: [
              //                 Colors.blue.withOpacity(.5),
              //                 Colors.pink.withOpacity(.5),
              //               ],
              //             ),
              //                       // color: Theme.of(context).colorScheme.secondary,
              //                       borderRadius: const BorderRadius.only(
              //                         topLeft: Radius.circular(10),
              //                               topRight: Radius.circular(10),
              //                               bottomLeft: Radius.circular(10),
              //                               bottomRight: Radius.circular(10)
              //                       ),
              //                       boxShadow: [
              //                         BoxShadow(
              //                               color: Colors.yellow.withOpacity(.9),
              //                               spreadRadius: 2,
              //                               blurRadius: 5,
              //                               offset: const Offset(0, 2), // changes position of shadow
              //                         ),
              //                       ],
              //                     ),
              //                            child:    const Center(child: Text("Sell Products",
        
              //                            textAlign: TextAlign.center,
              //                            style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),)),
        
              //                   ),
        
              //                   ),
              //         ),
              //          ),
              //     ],
              //   ),
        
              //   SizedBox(height: 64,) ,
              // Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       Transform.rotate(
              //         angle: 6.7,
        
              //         child: InkWell(
              //          onTap: (){
              //           Get.to(StockListPage());
        
              //          },
              //           child: GlassContainer(
              //                     height: 100,
              //                     width: 140,
              //                     blur: 4,
              //                     color: Colors.white.withOpacity(0.1),
              //                     gradient: LinearGradient(
              //                       begin: Alignment.topLeft,
              //                       end: Alignment.bottomRight,
              //                       colors: [
              //                         Colors.white.withOpacity(0.2),
              //                         Colors.blue.withOpacity(0.3),
              //                       ],
              //                     ),
              //                     //--code to remove border
              //                     border: Border.fromBorderSide(BorderSide.none),
              //                     shadowStrength: 5,
              //                     shape: BoxShape.circle,
              //                     borderRadius: BorderRadius.circular(16),
              //                     shadowColor: Colors.grey.withOpacity(1),
              //                     child:  Container(
              //                     padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 16),
        
              //                     decoration: BoxDecoration(
              //                        gradient: LinearGradient(
              //               begin: Alignment.topLeft,
              //               end: Alignment.bottomRight,
              //               colors: [
              //                 Colors.blue.withOpacity(.3),
              //                 Colors.pink.withOpacity(.3),
              //               ],
              //             ),
              //                       // color: Theme.of(context).colorScheme.secondary,
              //                       borderRadius: const BorderRadius.only(
              //                         topLeft: Radius.circular(10),
              //                               topRight: Radius.circular(10),
              //                               bottomLeft: Radius.circular(10),
              //                               bottomRight: Radius.circular(10)
              //                       ),
              //                       boxShadow: [
              //                         BoxShadow(
              //                               color: Colors.grey.withOpacity(.9),
              //                               spreadRadius: 2,
              //                               blurRadius: 5,
              //                               offset: const Offset(0, 2), // changes position of shadow
              //                         ),
              //                       ],
              //                     ),
              //                            child:    const Center(child: Text("Stock",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),)),
        
              //                   ),
        
              //                   ),
              //         ),
              //          ),SizedBox(height: 16,),
              // Transform.rotate(
              //         angle: -6.7,
        
              //         child: GlassContainer(
              //                   height: 100,
              //                   width: 140,
              //                   blur: 4,
              //                   color: Colors.white.withOpacity(0.1),
              //                   gradient: LinearGradient(
              //                     begin: Alignment.topLeft,
              //                     end: Alignment.bottomRight,
              //                     colors: [
              //                       Colors.white.withOpacity(0.2),
              //                       Colors.blue.withOpacity(0.3),
              //                     ],
              //                   ),
              //                   //--code to remove border
              //                   border: Border.fromBorderSide(BorderSide.none),
              //                   shadowStrength: 5,
              //                   shape: BoxShape.circle,
              //                   borderRadius: BorderRadius.circular(16),
              //                   shadowColor: Colors.white.withOpacity(0.24),
              //                   child:  Container(
        
              //                   padding: EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 8),
        
              //                   decoration: BoxDecoration(
              //                     color: Colors.blue.withOpacity(.6),
              //                      gradient: LinearGradient(
              //             begin: Alignment.topLeft,
              //             end: Alignment.bottomRight,
              //             colors: [
              //               Colors.blue.withOpacity(.5),
              //               Colors.pink.withOpacity(.5),
              //             ],
              //           ),
              //                     // color: Theme.of(context).colorScheme.secondary,
              //                     borderRadius: const BorderRadius.only(
              //                       topLeft: Radius.circular(10),
              //                             topRight: Radius.circular(10),
              //                             bottomLeft: Radius.circular(10),
              //                             bottomRight: Radius.circular(10)
              //                     ),
              //                     boxShadow: [
              //                       BoxShadow(
              //                             color: Colors.white24.withOpacity(.9),
              //                             spreadRadius: 2,
              //                             blurRadius: 5,
              //                             offset: const Offset(0, 2), // changes position of shadow
              //                       ),
              //                     ],
              //                   ),
              //                          child:    const Center(child: Text("Expense",
        
              //                          textAlign: TextAlign.center,
              //                          style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),)),
        
              //                 ),
        
              //                 ),
              //          ),
              //     ],
              //   ),
              //   SizedBox(height: 80,),
              //     Transform.rotate(
              //         angle: -.7,
        
              //         child: InkWell(
              //          onTap: (){
              //            Get.to(Calculator());
              //          },
              //           child: GlassContainer(
              //                     height: 100,
              //                     width: 140,
              //                     blur: 4,
              //                     color: Colors.white.withOpacity(0.1),
              //                     gradient: LinearGradient(
              //                       begin: Alignment.topLeft,
              //                       end: Alignment.bottomRight,
              //                       colors: [
              //                         Colors.blue.withOpacity(0.2),
              //                         Colors.green.withOpacity(0.3),
              //                       ],
              //                     ),
              //                     //--code to remove border
              //                     border: Border.fromBorderSide(BorderSide.none),
              //                     shadowStrength: 5,
              //                     shape: BoxShape.circle,
              //                     borderRadius: BorderRadius.circular(16),
              //                     shadowColor: Colors.grey.withOpacity(1),
              //                     child:  Container(
              //                     padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 16),
        
              //                     decoration: BoxDecoration(
              //                        gradient: LinearGradient(
              //               begin: Alignment.topLeft,
              //               end: Alignment.bottomRight,
              //               colors: [
              //                 Colors.indigo.withOpacity(.3),
              //                 Colors.blue.withOpacity(.3),
              //               ],
              //             ),
              //                       // color: Theme.of(context).colorScheme.secondary,
              //                       borderRadius: const BorderRadius.only(
              //                         topLeft: Radius.circular(10),
              //                               topRight: Radius.circular(10),
              //                               bottomLeft: Radius.circular(10),
              //                               bottomRight: Radius.circular(10)
              //                       ),
              //                       boxShadow: [
              //                         BoxShadow(
              //                               color: Colors.grey.withOpacity(.9),
              //                               spreadRadius: 2,
              //                               blurRadius: 5,
              //                               offset: const Offset(0, 2), // changes position of shadow
              //                         ),
              //                       ],
              //                     ),
              //                            child:    const Center(child: Text("Calculator",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),)),
        
              //                   ),
        
              //                   ),
              //         ),
              //          )
              //
              ,
              SizedBox(
                height: 32,
              ),
              Container(
                // height: MediaQuery.of(context).size.longestSide,
                // width: MediaQuery.of(context).size.longestSide,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(34.0),
                        topRight: Radius.circular(34.0)),
                    boxShadow: [
                      BoxShadow(
                        color: clr.primary.withOpacity(.3),
                        spreadRadius: 0,
                        blurRadius: 1,
                        offset: const Offset(0, -2), // changes position of shadow
                      ),
                    ],
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              flex: 5,
                              child: CustomButtonCard(
                                onClick: () {
                                  Get.to(AddProduct());
                                },
                                clr: clr.secondaryContainer.withOpacity(1),
                                label: "Add Products",
                              )),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              flex: 5,
                              child: CustomButtonCard(
                                onClick: (){
                                  Get.to(SellProductsPage());
                                },
                                img: "assets/returns.png",
                                clr: clr.tertiaryContainer,
                                label: "Sell Products",
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                              child: CustomButtonCard(
                                onClick: (){
                                  Get.to(Calculator());
                                },
                            clr: clr.tertiaryContainer,img: "assets/calculator.png",label: "Calculator",
                          ))),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              flex: 5,
                              child: CustomButtonCard(
                                onClick: () {
                                  Get.to(StockListPage());
                                },
                                clr: clr.tertiaryContainer,
                                img:  "assets/stock.png",
                                label: "Stock",
                              )),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              flex: 5,
                              child: CustomButtonCard(
                                onClick: (){
                                  Get.to(ExpensePage());
        
                                },
                                clr: clr.secondaryContainer,
                                img:  "assets/budget.png",
                                label: "Expense",
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButtonCard extends StatelessWidget {
  const CustomButtonCard(
      {super.key, required this.clr, this.img, this.label, this.onClick});

  final Color clr;
  final String? img;
  final String? label;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    return InkWell(
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.secondary.withOpacity(.5),
              // color: Colors.grey.shade300,
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          // border: Border.all(color: clr.secondary),
        ),
        padding: EdgeInsets.all(12.0),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                        padding: const EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8), color: clr),
                        child: Image.asset(
                          img ?? "assets/warehouse.png",
                          height: 32,
                          width: 32,
                        )),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(label ?? "Add Product",
                      style: textTheme.labelMedium?.copyWith(fontSize: 16)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomStaticCard extends StatelessWidget {
  const CustomStaticCard(
      {super.key, required this.clr, this.img, this.label,required this.isLoading, this.value});

  final Color clr;
  final String? img;
  final String? label;
  final String? value;
  final bool isLoading;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: clr),
            child: Image.asset(
              img ?? "assets/worker.png",
              height: 30,
              width: 30,
            )),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label ?? "Total Stock",
                style: TextStyle(color: Colors.black45, fontSize: 12),
              ),
              SizedBox(
                height: 4,
              ),
              isLoading==true?SizedBox(child: CupertinoActivityIndicator()):
              Text(
                value ?? "508",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
