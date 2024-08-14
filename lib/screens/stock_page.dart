import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:inventory_management/screens/scan/sell_page.dart';
import 'package:inventory_management/widgets/custom_button.dart';
import 'package:lottie/lottie.dart';

import 'add_products/add_product.dart';

class StockPage extends StatelessWidget {
  const StockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Stock product",style: TextStyle(color: Colors.black),),),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            ProductCard(
              img: "assets/2.jpg",
            ),
            SizedBox(
              height: 16,
            ),
            ProductCard(
              img: "assets/1.jpg",


            ),
            SizedBox(
              height: 16,
            ),
            ProductCard(
              img: "assets/3.png",


            ),
            SizedBox(
              height: 16,
            ),
            ProductCard(
              img: "assets/4.png",


            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, this.img});
  final String? img;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Get.to(()=>SellPage(),arguments: {"id":"AS14785"});
      },
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
          //             gradient: LinearGradient(
          //    begin: Alignment.bottomLeft,
          //    end: Alignment.topRight,
          //    colors: [
            
          //      Colors.blue.withOpacity(.2),   Colors.white,
          //    ],
          //  ),
          color: Colors.white,
          //                          border: Border.all(
          // color: Colors.black12,width: 1

          //                          ),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
        ),
        child: Center(
            child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
          //             gradient: LinearGradient(
          //    begin: Alignment.bottomLeft,
          //    end: Alignment.topRight,
          //    colors: [
            
          //      Colors.blue.withOpacity(.2),   Colors.white,
          //    ],
          //  ),
          color: Colors.white,
          //                          border: Border.all(
          // color: Colors.black12,width: 1

          //                          ),
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
                child: Image.asset(
                  img ?? "assets/1.jpg",
                  height: 88,
                  width: 70,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      Lottie.asset('assets/chart.json',
                          height: 34, width: 34, fit: BoxFit.cover
                          
                          ),
                
                      // Text("Catagory ",style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.normal),),
                      const SizedBox(
                        width: 4,
                      ),
                      const Text(
                        "560 pics",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
               
                const SizedBox(
                  height: 2,
                ),
                const Text(
                  "6699-MKLJH ",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),

               
                const SizedBox(
                  height: 8,
                ),
                const Row(
                  children: [
                    Text(
                      "Catagory :",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Sliky Matt ",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
                width: 68,
                child: SubmitButton(
                  title: "Sell",
                  onClick: () {},
                ))
          ],
        )),
      ),
    );
  }
}
