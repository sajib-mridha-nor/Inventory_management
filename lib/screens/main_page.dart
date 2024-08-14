import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:inventory_management/screens/auth/login_page.dart';
import 'package:inventory_management/screens/scan/sell_page.dart';
import 'package:inventory_management/screens/sell/sell_product_page.dart';
import 'package:inventory_management/screens/stock/stock_list_page.dart';
import 'package:inventory_management/screens/test.dart';
import 'package:inventory_management/screens/barcode_scanner_page.dart';
import 'package:inventory_management/utils/hexcolor.dart';
import 'dart:math' as math; 
import 'add_products/add_product.dart';

import 'package:lottie/lottie.dart';
import 'home/home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
    int _lastSelected = 0;

 final screens = [
      HomePage(),
     SellProductsPage(title: true,),
     StockListPage(title: true,),
     Scaffold(
      body:
      Center(
       child: ElevatedButton(child: Text("Logout"),onPressed: (){
        GetStorage().remove("token");
        Get.offAll(LogingPage());
       },),
     ),),

    
  ];
   StreamSubscription? barcodeScanRes;



  Widget _buildFab(BuildContext context) {
    final icons = [Icons.barcode_reader, Icons.qr_code_2, Icons.qr_code_scanner_outlined];
    
    return AnchoredOverlay(
      showOverlay: true,
      overlayBuilder: (context, offset) {
        return CenterAbout(
          position: Offset(offset.dx, offset.dy - icons.length * 35.0),
          child: FabWithIcons(
            icons: icons,
            onIconTapped: (t){},
          ),
        );
      },
      child: FloatingActionButton(
        backgroundColor: HexColor("#DAEDC7"),
        onPressed: () {},
        tooltip: 'Scan',
        child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Lottie.asset('assets/sc3.json',
                      height: 34, width: 34, fit: BoxFit.cover),
                ),
        elevation: 2.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorSchema = Theme.of(context).colorScheme;

    return   Scaffold(
      extendBody: true,
       bottomNavigationBar:  NavigationBar(
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            selectedIndex: _lastSelected,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            onDestinationSelected: (index) {
              _lastSelected=index;
              
              setState(() {
                _lastSelected = index;
              });
            },
            destinations: <NavigationDestination>[
           NavigationDestination(
                
                  icon:  Image.asset("assets/home.png",height: 24,width: 24,),
                  selectedIcon: Image.asset("assets/home.png",height: 24,width: 24,color:colorSchema.primary,),
                  label: "Home"),
                    NavigationDestination(
                  icon:   Image.asset("assets/order.png",height: 24,width: 24,),
                  selectedIcon:  Image.asset("assets/order.png",height: 24,width: 24,colorBlendMode: BlendMode.lighten,color:colorSchema.primary.withOpacity(.2),),
                  label: "Order"),
                    NavigationDestination(
                
                  icon:  Image.asset("assets/shopping-cart.png",height: 24,width: 24,),
                  selectedIcon: Image.asset("assets/shopping-cart.png",height: 24,width: 24,color:colorSchema.primary,),
                  label: "Products"),
              NavigationDestination(
                  icon: const Icon(
                    Icons.menu,
                  ),
                  selectedIcon: Icon(
                Icons.menu_outlined,
                    color: colorSchema.primary,
                  ),
                  label: "More"),
           
              
            
            
            ],
          ),
      
       
       
       
       
//         FABBottomAppBar(
//         centerItemText: 'Scan',
//         // color: Colors.grey,
//         selectedColor: Theme.of(context).colorScheme.primary,
//         notchedShape: CircularNotchedRectangle(),
//         onTabSelected: (index){
//           setState(() {
//       _lastSelected =  index;
//     });
//         },
//         items: [
//           FABBottomAppBarItem(iconData: Icons.home, text: 'Home'),
//           FABBottomAppBarItem(iconData: Icons.menu, text: 'More'),
         
//         ],
//       ),
// //       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       floatingActionButton: 
//        FloatingActionButton(
//         backgroundColor: HexColor("#DAEDC7"),
//         onPressed: ()async { 

//           // SimpleBarcodeScannerPage();
//           Get.to(SimpleBarcodeScannerPage(onClick: (value){
// Get.off(()=>SellPage(),arguments: {"id":"AS14785"});
// print(value);

//           },));
            // barcodeScanRes = await FlutterBarcodeScanner.getBarcodeStreamReceiver(
        //             "#ff6666", "Cancel", false, ScanMode.DEFAULT)!.listen((barcode) { 
                    
        //             print(barcode);
        //               if (barcode!=null) {
                     
        //                 //  print("res ${barcodeScanRes}");  
                     
        //                   //  barcodeScanRes?.onDone(() {   Get.to(SellPage()); }) ;
        //               } else {
        //                Get.snackbar(
        //           'Something wrong',
        //           'Successfully ',
        //         );                     
        //         }
                     
      
        //  }
         
        //  );
      //  print( "${barcodeScanRes?.cancel()}")    ;
         
          
         
      //    },
      //   tooltip: 'Scan',
      //   child: Padding(
      //             padding:
      //                 const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      //             child: Lottie.asset('assets/scan.json',
      //                 height: 34, width: 34, fit: BoxFit.cover),
      //           ),
      //   elevation: 2.0,
      // ),
    appBar: AppBar(
      // backgroundColor: Colors.transparent,
      title: Text("HR Tiles & Fittings",style: TextStyle(),),centerTitle: true,),
    body:
    
    
    screens[_lastSelected]
    );
  }
}
