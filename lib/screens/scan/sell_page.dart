// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:get/get.dart';

// import '../../widgets/custom_button.dart';
// import '../invoice/invoice.dart';
// import 'scan_controller.dart';

// class SellPage extends StatefulWidget {
//   SellPage({super.key});

//   @override
//   State<SellPage> createState() => _SellPageState();
// }

// class _SellPageState extends State<SellPage> {
//   final controller = Get.put(ScanController());
//      final _formKey = GlobalKey<FormState>();
  

//   var total = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Sell product",
//           style: TextStyle(color: Colors.black),
//         ),
//        shape: Border(
//     bottom: BorderSide(
//       color: Colors.black54,
//       width: .5,
//     )
//   ),
//       ),
//       body: Obx(() => controller.isLoading.value == false
//           ? Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: SingleChildScrollView(
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
                    
//                     children: [
//                       SizedBox(height: 16.0),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           children: <Widget>[
//                             CustomValueCard(
//                                       onChange: (v){
//                                         controller.map["customer_name"]=v;
//                                       },
                              
//                               lable: "Customer Name",
//                               hint: "Enter customer name",
//                             ),
//                             SizedBox(height: 16.0),
//                             CustomValueCard(
//                                       onChange: (v){
//                                         controller.map["customer_address"]=v;
                              
//                                       },
                              
//                               lable: "Customer address",
//                               hint: "Enter customer address",
//                             ),
//                             SizedBox(height: 16.0),
//                             CustomValueCard(
//                               textInputType: TextInputType.phone,
//                                       onChange: (v){
//                                         controller.map["phone"]=v;
                              
//                                       },
                              
//                               lable: "Customer phone",
//                               hint: "Enter customer phone",
//                             ),
//                             SizedBox(height: 46.0),
//                             CustomValueCard(
//                                readOnly: true,
//                                       onChange: (){},
                              
//                               initialVAlue: controller
//                                   .productResponse!.data![0].productCode
//                                   .toString(),
//                             ),
//                             SizedBox(height: 16.0),
//                             Row(
//                               children: [
//                                 Expanded(
//                                     child: CustomValueCard(
//                                       onChange: (){},
                              
//                                       readOnly: true,
                              
//                                   lable: "Category",
//                                   rb: 0,
//                                   rt: 0,
//                                   initialVAlue: controller
//                                       .productResponse!.data![0].categoryId
//                                       .toString(),
//                                 )),
//                                 SizedBox(
//                                   width: 8,
//                                 ),
//                                 Expanded(
//                                     child: CustomValueCard(
//                                       onChange: (){},
                              
//                                       readOnly: true,
//                                   lable: "Type",
//                                   initialVAlue: controller
//                                       .productResponse!.data![0].type
//                                       .toString(),
//                                   lb: 0,
//                                   lt: 0,
//                                 )),
//                               ],
//                             ),
//                             SizedBox(height: 16.0),
//                             Row(
//                               children: [
//                                 Expanded(
//                                     child: CustomValueCard(
//                                       onChange: (t){
                                     
                
                
//                                       },
//                                       readOnly: true,
                              
//                                   lable: "Unit Price",
                                  
//                                   rb: 0,
//                                   rt: 0,
//                                   initialVAlue: controller
//                                       .productResponse!.data![0].unitPrice,
//                                 )),
//                                 SizedBox(
//                                   width: 8,
//                                 ),
//                                 Expanded(
//                                     child: CustomValueCard(

//                                       onChange: (v){
                
//                                         controller.map["sell_qty"]=v;
//                                         var unit= int.parse(v);
//                               unit==null?null:    total=   unit* int.parse(controller
//                                       .productResponse!.data![0].unitPrice!);
//                                       setState(() {
                                        
//                                       });
                                      
                              
//                                       },
                              
//                                   lable: "Quantity",
//                                 textInputType: TextInputType.number,
//                                   hint: "Enter Quantity.. ",
                              
//                                   lb: 0, lt: 0,
//                                 )),
//                               ],
//                             ),
//                             SizedBox(height: 28.0),
//                             Padding(
//                               padding: const EdgeInsets.fromLTRB(4, 8, 4, 4),
//                               child: Card(
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.max,
//                                     children: <Widget>[
//                                       Expanded(
//                                           child: Padding(
//                                               child: Text("Total amount"),
//                                               padding:
//                                                   EdgeInsets.only(left: 12))),
//                                       Padding(
//                                         padding: EdgeInsets.only(right: 8),
//                                         child: Text("$total ৳ ",style: TextStyle(fontSize: 18),),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Obx(()=>
//                          CustomButton(
                          
//                             onPressed: () {
//                               if (_formKey.currentState!.validate()) {
//                                 print(controller.map);
//                                 controller.sellProduct();
                                          
//                                             } 
//                             },
//                             isLoading: controller.subLoading.value,
//                             title: "Sell"),
//                       )
//                     ],
//                   ),
//                 ),
//               ))
//           : Center(child: CircularProgressIndicator())),
//     );
//   }
// }

// class CustomValueCard extends StatelessWidget {
//   const CustomValueCard(
//       {super.key,
//       this.initialVAlue,required this.onChange,
//       this.lable,
//       this.readOnly=false,
//       this.lb,
//       this.lt,
//       this.rb,
//       this.rt,
//       this.hint,this.error,this.require,this.minLength,
//       this.textInputType});

//   final String? lable;
//   final String? initialVAlue;
//   final String? hint;
//   final bool? readOnly;
//   final double? rb;
//   final double? rt;
//   final Function onChange;
//   final TextInputType? textInputType;
//     final String? error;
//   final bool? require;
//  final int? minLength;

//   final double? lt;
//   final double? lb;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
//           alignment: AlignmentDirectional.centerStart,
//           child: Text(
//             lable ?? "Model No.",
//             style: TextStyle(fontSize: 18),
//           ),
//         ),
//         SizedBox(height: 8.0),
//         Container(
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(lt ?? 8),
//                   topRight: Radius.circular(rt ?? 8),
//                   bottomLeft: Radius.circular(lb ?? 8),
//                   bottomRight: Radius.circular(rb ?? 8)),
//               color: Colors.black12),
//           child: TextFormField(
//             readOnly: readOnly!,
//             autofocus: true,
//             focusNode: FocusNode(),
//             initialValue: initialVAlue,
//             textInputAction: TextInputAction.next,
//             keyboardType: textInputType,
//             decoration: InputDecoration(
//                 hintText: hint,
//                 counterText: "",
//                 hintStyle: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.normal,
//                     letterSpacing: 0),
//                 border: InputBorder.none,

//                 // enabledBorder: OutlineInputBorder(
//                 //   // borderSide: BorderSide(color: Theme.of(context).colorScheme.secondaryContainer),
//                 //   borderRadius: BorderRadius.circular(8.0),

//                 // ),
//                 // focusedBorder: OutlineInputBorder(

//                 //   // borderSide: BorderSide(color: Theme.of(context).colorScheme.surfaceTint),
//                 //   borderRadius: BorderRadius.circular(8.0),

//                 // ),
//                 contentPadding:
//                     const EdgeInsets.symmetric(vertical: 14, horizontal: 16)),
//             onChanged: (value) {
//              onChange(value);
//             },
//             validator:(value) {
//               if ( require == false) {
//                 return null;
//               }
//               if (value == null || value.isEmpty) {
//                 if ( error == null) {
//                   return  hint;
//                 }
//                 return  error;
//               }
//               if ( minLength != null) {
//                 if (value.length <  minLength!) {
//                   if ( error == null) {
//                     return  hint;
//                   }
//                   return  error;
//                 }
//               }
//               return null;
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
