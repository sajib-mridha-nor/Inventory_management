import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:inventory_management/screens/expense/expense_history.dart';
import 'package:inventory_management/screens/sell/sell_controller.dart';
import 'package:inventory_management/utils/hexcolor.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_date_picker.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/custom_text_field.dart';
import '../barcode_scanner_page.dart';
import '../invoice/invoice.dart';
import 'package:lottie/lottie.dart';

import '../model/product_response.dart';
import '../scan/sell_page.dart';
import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import 'expense_controller.dart';

class ExpensePage extends StatefulWidget {
  ExpensePage({super.key});

  @override
  State<ExpensePage> createState() => _SellPageState();
}

class _SellPageState extends State<ExpensePage> {
  final _formKey = GlobalKey<FormState>();

  var total = 0;
  var draggableScrollableController = DraggableScrollableController();
  var box = GetStorage();
  final controller = Get.put(ExpenseController());

  var item = ["df", "sdf", "sdf"];
  @override
  void initState() {
    box.write("item", item);
    // TODO: implement initState
    super.initState();
  }

  RxInt i = 0.obs;
  var isBarrier = false;

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
                    Get.to(() => ExpenseHistoryPage());
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: HexColor("#FF6A01").withOpacity(.9),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "View Expense",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Icon(
                              FluentIcons.arrow_right_16_regular,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
          ),
        ),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            "Recode Expense",
            style: TextStyle(color: Colors.black),
          ),
          shape: const Border(
              bottom: BorderSide(
            color: Colors.black54,
            width: .5,
          )),
        ),
        body: Obx(() => controller.isLoading.value == true
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Container(
                      padding: const EdgeInsets.all(26.0),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8)),
                          color: Theme.of(context).cardTheme.shadowColor),
                      child: Column(
                        children: <Widget>[
                          CustomDropdown(
                            labelStyle: const TextStyle(
                                fontSize: 16, color: Colors.black),
                            label: "Expense Category",
                            onChange: (item) {
                             final id= controller.expenseCatagory?.firstWhere((element) => element.name==item).id;
                             print(id);


                              controller.docMap["category_id"] = id;
                            },
                            items: controller.expenseCatagory!
                                .map((e) => e.name.toString())
                                .toList(),
                            hint: "Select",
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomTextField1(
                            isPasswordField: false,
                            isSceener: false,
                            keyboardType: TextInputType.number,

                            // txt: "Enter Your password",
                            labelStyle: const TextStyle(
                                fontSize: 16, color: Colors.black),

                            label: "Expense amount",
                            onChange: (t) {
                              controller.docMap["amount"] = t;
                        print(t);

                            },
                            hint: "Enter amount.... ",
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomTextField1(
                            isPasswordField: false,
                            isSceener: false,

                            // txt: "Enter Your password",
                            labelStyle: const TextStyle(
                                fontSize: 16, color: Colors.black),

                            label: "Expense details",
                            onChange: (t) {
                        controller.docMap["details"] = t;
                        print(t);

                            },
                            hint: "Enter details.... ",
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        
                           CustomDatePicker(
                               labelStyle: const TextStyle(
                                fontSize: 16, color: Colors.black),
                            hint: 'Selecte date', label: 'Expense date', onChange: ( v) { 
                             var d= v.toString().split(" ");

                             controller.docMap["date"]=d[0];


                              print(d[0]);
                             },),
                         
                          const SizedBox(
                            height: 36,
                          ),
                          Align(
                              alignment: Alignment.centerRight,
                              child: Obx(()=>
                          Material(
                            borderRadius: BorderRadius.circular(8),
                                        color: HexColor("#FF6A01").withOpacity(1),
                                        shadowColor:     Colors.grey.withOpacity(0.5),

                            child: InkWell(
                          
                                    onTap:controller.subLoading.value==true?null: (){
                                  if (_formKey.currentState!.validate()) {
                                    print(controller.map);
                                    controller.sellProduct();
                                  
                                              
                                                } 
                                      
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                      
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            topRight: Radius.circular(8),
                                            bottomLeft: Radius.circular(8),
                                            bottomRight: Radius.circular(8)),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 0),
                                        child: Center(
                                            child: Text(
                                          "Add Expense",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal),
                                        )),
                                      ),
                                    ),
                                  ),
                          ),
                              )),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Divider(),
                  const Padding(
                    padding: EdgeInsets.all(26.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Divider(),
                        SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  )
                ],
              )));
  }
}

Future<dynamic> CustomBottomSheet(SellController controller,
    BuildContext context, model, catagory, price, aviableQ) {
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
                              child: Image.asset(
                                "assets/1.jpg",
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
                        controller.items.add(controller.item);
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
  const CustomItem(
      {super.key,
      this.catagory,
      this.model,
      this.onDelete,
      this.quantity,
      this.img});

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
                      img ?? "assets/2.jpg",
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
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          model ?? "6699-MKLJH ",
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          catagory ?? "Floore tiles ",
                          style: const TextStyle(
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
                            const Text(
                              "Quantity",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                            const SizedBox(
                              width: 70,
                            ),
                            Text(
                              quantity ?? "90",
                              style: const TextStyle(
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
                    child: Container(
                  // color: Colors.amber,
                  child: IconButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: onDelete,
                      icon: const Icon(
                        Icons.delete,
                        size: 22,
                        weight: 18,
                        opticalSize: 12,
                        color: Colors.red,
                      )),
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
                constraints:
                    BoxConstraints.loose(const Size(double.infinity, 50)),
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
