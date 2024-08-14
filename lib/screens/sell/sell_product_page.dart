import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:inventory_management/screens/model/product_add.dart' as a;
import 'package:inventory_management/screens/sell/sell_controller.dart';
import 'package:inventory_management/utils/hexcolor.dart';

import '../../widgets/custom_button.dart';
import '../barcode_scanner_page.dart';
import '../invoice/invoice.dart';
import 'package:lottie/lottie.dart';

import '../model/product_add.dart';
import '../model/product_response.dart';
import '../scan/sell_page.dart';
import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class SellProductsPage extends StatefulWidget {
  SellProductsPage({super.key,this.title=false});
  final bool title ;

  @override
  State<SellProductsPage> createState() => _SellPageState();
}

class _SellPageState extends State<SellProductsPage> {
  final _formKey = GlobalKey<FormState>();

  var total = 0;
  var draggableScrollableController = DraggableScrollableController();
  var box = GetStorage();
  final controller = Get.put(SellController());

  int item = 0;
  @override
  void initState() {
    box.write("item", item);
    // TODO: implement initState
    super.initState();
  }

  RxInt i = 0.obs;
  var isBarrier=false;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
        bottomSheet: SizedBox(
          height: 44,
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    print(controller.map);
                    showDialog(
                      
                      barrierDismissible: isBarrier,
  context: context,
  builder: (context) {
    String contentText = "Content of Dialog";
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          
          actionsPadding:  const EdgeInsets.symmetric(horizontal: 16,vertical: 6),
          // insetPadding:  EdgeInsets.all(4),
          iconPadding:  const EdgeInsets.all(4),
          titlePadding:  const EdgeInsets.fromLTRB(16,16,16,4),
          titleTextStyle: const TextStyle(fontSize: 18,color: Colors.black),
          contentPadding:  const EdgeInsets.symmetric(horizontal: 12),
          

          title: const Text("Enter customer name,address & phone no. confirm to sell"),
          content: SizedBox(
            height: MediaQuery.of(context).size.height*.52,
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    const SizedBox(height: 8.0),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          CustomTexCard(
                            onChange: (v) {
                              controller.docMap["customer_name"] = v;
                            },
                            lable: "Customer Name",
                            hint: "Enter customer name",
                          ),
                          const SizedBox(height: 16.0),
                          CustomTexCard(
                            onChange: (v) {
                              controller.docMap["customer_address"] =
                                  v;
                            },
                            lable: "Customer address",
                            hint: "Enter customer address",
                          ),
                          const SizedBox(height: 16.0),
                          CustomTexCard(
                            textInputType: TextInputType.phone,
                            onChange: (v) {
                              controller.docMap["phone"] = v;
                            },
                            lable: "Customer phone",
                            hint: "Enter customer phone",
                          ),
                          const SizedBox(height: 8.0),
                         
                        ],
                      ),
                    ),
                      
                   
                  ],
                ),
              ),
            ),
          ),
                      actions: [  
                        
                               OutlinedButton(
                                style: const ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 16,vertical: 0))),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),const SizedBox(width: 0,),
                         Obx(
                                    () => 
                                    
                                    CustomButton(
                                      elivation: 0,
                                      radius: 24,
                                      textStyle: const TextStyle(fontSize: 16,color: Colors.white),
                                    
                                        onPressed: () {
                                          if (_formKey.currentState!.validate()) {
                                            print(controller.docMap);
                                            controller.sellProduct();
                                          }
                                        },
                                        isLoading: controller.subLoading.value,
                                        title: "Confirm"),
                                  )
                                  
                                  ],
                   
         
        );
      },
    );
  },
);
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: HexColor("#FF6A01").withOpacity(.9),
                      // border: Border.all(
                      //     color: Theme.of(context).colorScheme.primary),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0)),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      child: Center(
                          child: Text(
                        "Checkout",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                )),
          ),
        ),
        resizeToAvoidBottomInset: false,
        appBar:widget.title==true?null:  AppBar(
          title: const Text(
            "Sell product",
            style: TextStyle(color: Colors.black),
          ),
          shape: const Border(
              bottom: BorderSide(
            color: Colors.black54,
            width: .5,
          )),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              // SizedBox(height: 16.0),

              Container(
                  child: 
                   
                  
                  
                  
                  
                  
                  
                  CustomValueCard(
                    key: UniqueKey(),
                  
                      onSearch: () {
                        controller.scan(context, controller.productCode.value);
                      },
                      onChange: (t) {
                        controller.productCode(t.toString());
                        print(controller.productCode.value);
                         controller.barCode=t;
                           debugPrint(controller.barCode);


                        
                      },
                      hint: "Input product Id",
                      onClick: () async{


                      
                                    var res = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>   const SimpleBarcodeScannerPage(),
                          ));

                       
                          

                            if (res.toString().trim()=="-1") {
return;
                      
                        }else{
                            print("pirint form res 0 ${res}");

                          controller.scan(context, res);
                        }
                                   
                      






                      })),

              const SizedBox(
                height: 12,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Your Selected Items $item"),
                    // Text("Total ${controller.item?.unitPrice??0} ৳"),
                ],
              ),
              const SizedBox(
                height: 16,
              ),

              Obx(() => SizedBox(
                    height: MediaQuery.of(context).size.height * .6,
                    child: ListView.separated(
                        shrinkWrap: false,
                        itemBuilder: (context, index) { 
                        final Items i=  controller.items[index];
                         return   CustomItem(
                          img:i. item?.productImage,
                          model: i.item!.productCode,
                          catagory:i. item?.categoryName,
                          quantity:i.q.toString(),

                          onDelete: () {
                            controller.items.removeAt(index);
                          },
                        );},
                        separatorBuilder: (context, index) => const Divider(
                              height: 1,
                              indent: 8,
                              endIndent: 8,
                            ),
                        itemCount: controller.items.length),
                  )),
            ])));
  }
}

Future<dynamic> CustomBottomSheet(SellController controller,
    BuildContext context,img, model, catagory, price, aviableQ) {
  return showFlexibleBottomSheet(
    useRootScaffold: false,
    // draggableScrollableController: draggableScrollableController,
    minHeight: 0,
    initHeight: 0.5,
    maxHeight: 1,
// headerHeight: 200,
// bottomSheetBorderRadius: BorderRadius.circular(12),
    context: context,
    isModal: true,
    isCollapsible: true,
    isDismissible: true,
// draggableScrollableController: draggableScrollableController,
    isExpand: true, isSafeArea: true,

    builder: (BuildContext context, s, double offset) {
      return StatefulBuilder(builder: (BuildContext context,
          StateSetter setState /*You can rename this!*/) {
        return SingleChildScrollView(
          controller: s,
          child: Container(
            // height: 600,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.clear))
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).colorScheme.primary),
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8)),
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8)),
                              child: Image.network(
                               "https://etldev.xyz/inventory-tiels/${img}"?? "assets/1.jpg",
                                height: 110,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text("Model No"),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                model ?? "9879796798",
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * .6,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Category"),
                                        Text(
                                          catagory ?? "Flore tiles",
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 26,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Unit price"),
                                        Text(
                                          price ?? "120 ৳",
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Available quantity"),
                          Text(
                            aviableQ ?? "18",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Quantity",
                            style: TextStyle(fontSize: 16),
                          ),
                          Container(
                            child: QuantityContainer(
                              initialQuantity: 1,
                              onChanged: (t) {
                                controller.docMap["sell_qty"] = t;

                                print(t);
                              },
                            ),
                          )
                        ],
                      ),
                      const Divider(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        print(GetStorage().read("ProductsDoc"));

                        // Navigator.pop(context);

                        // Get.back(canPop: true);
                        // box.write("item", item);
                        print(controller.docMap);
                        controller.docMap["product"] = {"id": 8};
                        print(controller.docMap);
                        controller.items.add(a.Items(q:controller.docMap["sell_qty"],item: controller.item ));
                        controller.listItem.add(controller.docMap);
                        GetStorage().write(
                            "ProductsDoc", {"docMap": controller.listItem});
                        GetStorage().write(
                            "PageProducts", {"docMap": controller.items});
                        print(GetStorage().read("ProductsDoc"));
                        print(GetStorage().read("PageProducts"));
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: HexColor("#FF6A01").withOpacity(.9),
                          border: Border.all(
                              color: Theme.of(context).colorScheme.primary),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8)),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                            "Add Cart",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                )
              ],
            ),
          ),
        );
      });
    },
    anchors: [0, .5, 1],
  );
}

class CustomItem extends StatelessWidget {
  const CustomItem({
    super.key,this.catagory,this.model,this.onDelete,this.quantity,this.img
  });

  final String? model;
  final String? catagory;
  final String? quantity;
  final String? img;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            margin: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8)),
                    child: Image.network(
                     "https://etldev.xyz/inventory-tiels/${img}"?? "assets/2.jpg",
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                  Expanded(
                    flex: 6,
                    child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         SizedBox(
                              height: 8,
                            ),
                          Text(
                         model?? "6699-MKLJH ",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                          Text(
                         catagory?? "Floore tiles ",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                          Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Quantity",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                            SizedBox(
                              width: 70,
                            ),
                            Text(
                             quantity?? "90",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                                  ),
                  ),
                  Expanded(
                
                    child:  Container(
                              // color: Colors.amber,
                              child: IconButton(
                                padding: EdgeInsets.all(0),
                                onPressed: onDelete, icon: const Icon(Icons.delete,size: 22,
                              weight: 18,opticalSize: 12,
                              color: Colors.red,)),
                            ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomValueCard extends StatelessWidget {
  const CustomValueCard(
      {super.key,
      this.initialVAlue,
      required this.onChange,
      this.lable,
      this.readOnly = false,
      this.lb,
      this.lt,
      this.rb,
      this.rt,
      this.hint,
      this.error,
      this.require,
      this.minLength,
      this.onClick,
      this.onSearch,
      this.textInputType});

  final String? lable;
  final String? initialVAlue;
  final String? hint;
  final bool? readOnly;
  final double? rb;
  final double? rt;
  final Function onChange;
  final VoidCallback? onSearch;
  final VoidCallback? onClick;
  final TextInputType? textInputType;
  final String? error;
  final bool? require;
  final int? minLength;

  final double? lt;
  final double? lb;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // width: MediaQuery.of(context).size.width*.8,
          // height:MediaQuery.of(context).size.width*.2,
          decoration: BoxDecoration(
              border:
                  Border.all(color: Theme.of(context).primaryColor, width: .5),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(lt ?? 8),
                  topRight: Radius.circular(rt ?? 8),
                  bottomLeft: Radius.circular(lb ?? 8),
                  bottomRight: Radius.circular(rb ?? 8)),
              color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  lable ?? "Input/Scan for add to sell products ",
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              const Divider(
                indent: 8,
                endIndent: 8,
                height: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 9,
                    child: Container(
                      color: Colors.white10,
                      width: 260,
                      child: TextFormField(
                        readOnly: readOnly!,
                        autofocus: false,
                        focusNode: FocusNode(),
                        initialValue: initialVAlue,
                        textInputAction: TextInputAction.next,
                        keyboardType: textInputType,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: onSearch,
                                icon: const Icon(Icons.search)),
                            hintText: hint,
                            counterText: "",
                            hintStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                letterSpacing: 0),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 14, horizontal: 16)),
                        onChanged: (value) {
                          onChange(value);
                        },
                        validator: (value) {
                          if (require == false) {
                            return null;
                          }
                          if (value == null || value.isEmpty) {
                            if (error == null) {
                              return hint;
                            }
                            return error;
                          }
                          if (minLength != null) {
                            if (value.length < minLength!) {
                              if (error == null) {
                                return hint;
                              }
                              return error;
                            }
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: InkWell(
                          onTap: onClick,
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(lt ?? 0),
                                    topRight: Radius.circular(rt ?? 8),
                                    bottomLeft: Radius.circular(lb ?? 0),
                                    bottomRight: Radius.circular(rb ?? 8)),
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                              ),
                              child: Lottie.asset("assets/scan.json",
                                  height: 42, width: 42)),
                        ),
                      ))
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

dialog(
  context,
) {
  var time;
  var clr;
  Get.dialog(
    StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Material(
                    child: Column(
                  children: [],
                )),
              ),
            ),
          ),
        ],
      );
    }),
  );
}

class MyApp extends StatelessWidget {
  final List<IconData> icons = const [
    Icons.message,
    Icons.call,
    Icons.mail,
    Icons.notifications,
    Icons.settings,
  ];

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(builder: (context) {
        return Scaffold(
          body: DraggableBottomSheet(
            minExtent: 150,
            useSafeArea: false,
            curve: Curves.easeIn,
            previewWidget: Container(
              color: Colors.red,
            ),
            expandedWidget: _expandedWidget(),
            backgroundWidget: _backgroundWidget(),
            maxExtent: MediaQuery.of(context).size.height * 0.8,
            onDragging: (pos) {},
          ),
        );
      }),
    );
  }

  Widget _backgroundWidget() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Draggable Bottom Sheet Example'),
        backgroundColor: Colors.deepOrange,
      ),
      body: SizedBox(
        height: 400,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(vertical: 32),
          itemCount: icons.length,
          itemBuilder: (context, index) => Container(
            height: 200,
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icons[index], color: Colors.white, size: 60),
          ),
          separatorBuilder: (context, index) => const SizedBox(width: 10),
        ),
      ),
    );
  }

  Widget _previewWidget() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.pink,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            width: 40,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Drag Me',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: icons.map((icon) {
                return Container(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: Colors.pink, size: 40),
                );
              }).toList())
        ],
      ),
    );
  }

  Widget _expandedWidget() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.pink,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: <Widget>[
          const Icon(Icons.keyboard_arrow_down, size: 30, color: Colors.white),
          const SizedBox(height: 8),
          const Text(
            'Hey...I\'m expanding!!!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              itemCount: icons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icons[index], color: Colors.pink, size: 40),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final pageIndexNotifier = ValueNotifier(0);

    WoltModalSheetPage page1(BuildContext modalSheetContext) {
      return WoltModalSheetPage.withSingleChild(
        stickyActionBar: Container(
          height: 20,
          color: Colors.amber,
        ),
        pageTitle: Container(
          height: 20,
          color: Colors.indigo,
        ),
        topBarTitle: Container(
          height: 20,
          color: Colors.blueGrey,
        ),
        closeButton: Container(
          height: 20,
          color: Colors.teal,
        ),
        mainContentPadding: const EdgeInsetsDirectional.all(16),
        child: const Padding(
            padding: EdgeInsets.only(bottom: 120, top: 16),
            child: Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Text(
                '''
Pagination involves a sequence of screens the user navigates sequentially. We chose a lateral motion for these transitions. When proceeding forward, the next screen emerges from the right; moving backward, the screen reverts to its original position. We felt that sliding the next screen entirely from the right could be overly distracting. As a result, we decided to move and fade in the next page using 30% of the modal side.
''',
              ),
            )),
      );
    }

    WoltModalSheetPage page2(BuildContext modalSheetContext) {
      return WoltModalSheetPage.withCustomSliverList(
        mainContentPadding: EdgeInsetsDirectional.zero,
        stickyActionBar: Container(
          height: 20,
          color: Colors.cyan,
        ),
        pageTitle: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            height: 20,
            color: Colors.blue,
          ),
        ),
        heroImageHeight: 200,
        heroImage: const Image(
          image: AssetImage('lib/assets/images/material_colors_hero.png'),
          fit: BoxFit.cover,
        ),
        topBarTitle: Container(
          height: 20,
          color: Colors.red,
        ),
        backButton: Container(
          height: 20,
          color: Colors.green,
        ),
        closeButton: Container(
          height: 20,
          color: Colors.black,
        ),
        sliverList: SliverList(
          delegate: SliverChildBuilderDelegate(
            (_, index) => Container(
              height: 20,
              color: Colors.amber,
            ),
            childCount: 2,
          ),
        ),
      );
    }

    return MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) {
            return Center(
              child: SizedBox(
                width: 200,
                child: Container(
                  height: 20,
                  color: Colors.lime,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class QuantityContainer extends StatefulWidget {
  final int initialQuantity;
  final Function(int) onChanged;

  QuantityContainer({required this.initialQuantity, required this.onChanged});

  @override
  _QuantityContainerState createState() => _QuantityContainerState();
}

class _QuantityContainerState extends State<QuantityContainer> {
  late int quantity;
  String msg = "";
  int available = 100000;
  var controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    quantity = widget.initialQuantity;
    controller.text = quantity.toString();
  }

  void incrementQuantity() {
    setState(() {
      if (available > quantity) {
        msg = "";

        quantity++;
        widget.onChanged(quantity);
        controller.text = quantity.toString();
      } else {
        msg = "Stock limite over";
      }
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
        widget.onChanged(quantity);
        controller.text = quantity.toString();
        msg = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(0)),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.remove,
                    color: Colors.amber,
                  ),
                  onPressed: decrementQuantity,
                ),
              ),
              SizedBox(
                height: 25,
                width: 80,
                child: TextField(
                  controller: controller,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    if (available > int.parse(value)) {
                      msg = "";

                      widget.onChanged(int.parse(value));
                      quantity = int.parse(value);
                    } else {
                      controller.text = available.toString();
                      quantity = available;
                      msg = "Stock limite over";
                    }
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(8)),
                ),
                child: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: incrementQuantity,
                ),
              ),
            ],
          ),
        ),
        Text(msg)
      ],
    );
  }
}

class DialogBody extends StatefulWidget {
  DialogBody({super.key, required this.lables});
  List lables;
  @override
  State<DialogBody> createState() => _DialogBodyState();
}

class _DialogBodyState extends State<DialogBody> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 8,
        runSpacing: 8,
        children: widget.lables.map((lable) {
          return FilterChip(
              label: Text(lable),
              selected: false,
              onSelected: (val) {
                if (val) {
                } else {}
                setState(() {});
              });
        }).toList());
  }
}

class CustomTexCard extends StatelessWidget {
  const CustomTexCard(
      {super.key,
      this.initialVAlue,
      required this.onChange,
      this.lable,
      this.readOnly = false,
      this.lb,
      this.lt,
      this.rb,
      this.rt,
      this.hint,
      this.error,
      this.require,
      this.minLength,
      this.textInputType});

  final String? lable;
  final String? initialVAlue;
  final String? hint;
  final bool? readOnly;
  final double? rb;
  final double? rt;
  final Function onChange;
  final TextInputType? textInputType;
  final String? error;
  final bool? require;
  final int? minLength;

  final double? lt;
  final double? lb;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            lable ?? "Model No.",
            style: const TextStyle(fontSize: 16),
          ),
        ),
        const SizedBox(height: 8.0),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(lt ?? 8),
                  topRight: Radius.circular(rt ?? 8),
                  bottomLeft: Radius.circular(lb ?? 8),
                  bottomRight: Radius.circular(rb ?? 8)),
              color: Colors.black12),
          child: TextFormField(
            readOnly: readOnly!,
            autofocus: true,
            // focusNode: FocusNode(),
            initialValue: initialVAlue,
            textInputAction: TextInputAction.next,
            keyboardType: textInputType,
            decoration: InputDecoration(
                hintText: hint,
                counterText: "",
                constraints: BoxConstraints.loose(const Size(double.infinity, 50)),
                hintStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    letterSpacing: 0),
                border: InputBorder.none,

                // enabledBorder: OutlineInputBorder(
                //   // borderSide: BorderSide(color: Theme.of(context).colorScheme.secondaryContainer),
                //   borderRadius: BorderRadius.circular(8.0),

                // ),
                // focusedBorder: OutlineInputBorder(

                //   // borderSide: BorderSide(color: Theme.of(context).colorScheme.surfaceTint),
                //   borderRadius: BorderRadius.circular(8.0),

                // ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 10)),
            onChanged: (value) {
              onChange(value);
            },
            validator: (value) {
              if (require == false) {
                return null;
              }
              if (value == null || value.isEmpty) {
                if (error == null) {
                  return hint;
                }
                return error;
              }
              if (minLength != null) {
                if (value.length < minLength!) {
                  if (error == null) {
                    return hint;
                  }
                  return error;
                }
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
