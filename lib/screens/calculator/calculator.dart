import 'package:flutter/material.dart';

import '../../widgets/custom_button.dart';
import '../auth/login_page.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
   final _formKey = GlobalKey<FormState>();
  
    double width=0;
    double length=0;
    double totalCover=0;
    double result=0;
  @override
  Widget build(BuildContext context) {
   

    return Scaffold(
        appBar: AppBar(
          title: const Text("Calculator"),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: <Widget>[
                          // SizedBox(height: 16),
                          //  Text("Registration", style: TextStyle(color: Colors.black, fontSize: 20),),
        
                          const SizedBox(
                            height: 60,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  const BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 10,
                                      offset: Offset(0, 3))
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[200]!))),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: CustomValueCard(
                                    textInputType: TextInputType.number,

                                          onChange: (t){
                                              width=double.parse(t);

                                            setState(() {
                                            });
                                          },
                                          lable: "Tile Size Width",
                                           hint: "Tile size  Width",

                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: CustomValueCard(
                                    textInputType: TextInputType.number,

                                          onChange: (t){
                                              length=double.parse(t);

                                            setState(() {
                                            });
                                          },
                                          lable: "Tile Size - Length",
                                          hint: "Tile size Length ",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[200]!))),
                                  child: CustomDropdown(
                                    initialValue: "inch",
                                    onChange: (value) {
                                      
                                    },
                                    items: ["inch", "square", "fit"],
                                    lable: "Types of measurements",
                                    hint: "inch",
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[200]!))),
                                  child: CustomValueCard(
                                    textInputType: TextInputType.number,
                                     
                                    onChange: (t){
                                        totalCover=double.parse(t);
                                        print(totalCover);

                                    setState(() {
                                    });
                                    },
                                    lable: "Total Area to Cover",
                                    error: "Total area",
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[200]!))),
                                  child: CustomDropdown(
                                    onChange: (value) {},
                                    items: ["inch", "square", "fit"],
                                    lable: "Types of measurements",
                                    hint: "square",
                                    initialValue: "square",

                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
        
                          Center(
                            child: Align(
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 150,
                                    child: 
                                    
                                    
                                    CustomButton(
                                      radius: 18,
                                      onPressed: () {
                                        
                                        if (_formKey.currentState!.validate()) {
                                          print(width);
                                          print(length);
                                            var sqinch= width*length;                        
                                         setState(() {
                                       
                                         
                                       result=  totalCover/(sqinch/144);
                                                print("ewkj ${result}");
                            
                                         });
                                        } 
                                      },
                                      title: "calculate",
                                      isLoading: false,
                                    ),
                                  ),
                                  SizedBox(width: 16,),
                                   OutlinedButton(
                                    style: ButtonStyle(shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Theme.of(context).primaryColor)
                                ))),
                                    onPressed: (){

                                      _formKey.currentState?.reset();
                                     
                                      setState(() {
                                         result=0;
                                        
                                      });
                                    }, child: Text("Clear"))
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              
                              decoration: BoxDecoration(color: Colors.green.withOpacity(.7)
                             , borderRadius: BorderRadius.circular(16)
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    
                                    children: [
                                      Text("Result :",style: TextStyle(fontSize: 18,color: Colors.white),),SizedBox(width:16,),
                                      Text("${result.toStringAsFixed(2)} ",style: TextStyle(fontSize: 20,color: Colors.black),), Text("pcs",style: TextStyle(fontSize: 16,color: Colors.black),),SizedBox(width: 100,),
                                    ],
                                  ),
                                ),
                              ),
                            ))

                        ],
                      ),
                    ),
                  ),
                ),
              ),
              
            ],
          ),
        ));
  }
}

class CustomValueCard extends StatelessWidget {
  const CustomValueCard(
      {super.key,
      this.initialVAlue,required this.onChange,this.require,
      this.lable,
      this.readOnly,this.error,
      this.lb,
      this.lt,this.minLength,this.textInputType,
      this.rb,
      this.rt,
      this.hint});

  final String? lable;
  final String? initialVAlue;
  final String? hint;
  final String? error;
  final bool? readOnly;
  final bool? require;
  final double? rb;
  final double? rt;
 final Function  onChange;
 final int? minLength;
 final TextInputType? textInputType;

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
            readOnly: false,
            // autofocus: true,
          
            initialValue: initialVAlue,
            textInputAction: TextInputAction.next,
            keyboardType: textInputType,
            decoration: InputDecoration(
                hintText: hint,
                counterText: "",
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
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 16)),
            onChanged: (value) {
               onChange(value);
            },
            validator: (value) {
              if ( require == false) {
                return null;
              }
              if (value == null || value.isEmpty) {
                if ( error == null) {
                  return  hint;
                }
                return  error;
              }
              if ( minLength != null) {
                if (value.length <  minLength!) {
                  if ( error == null) {
                    return  hint;
                  }
                  return  error;
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

class CustomDropdown extends StatefulWidget {
  final String hint;
  final String? error;
  final String? initialValue;
  final String? label;
  final TextStyle? labelStyle;
  final List<String> items;
  final bool? require;
  final Function(String? value) onChange;

  final String? lable;
  final String? initialVAlue;

  final bool? readOnly;
  final double? rb;
  final double? rt;

  final double? lt;
  final double? lb;

  const CustomDropdown(
      {Key? key,
      this.labelStyle,
      this.label,
      required this.items,
      this.require,
      required this.hint,
      this.error,
      required this.onChange,
      this.initialVAlue,
      this.lable,
      this.readOnly,
      this.lb,
      this.lt,
      this.rb,
      this.rt,
      this.initialValue})
      : super(key: key);

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? _currentSelectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: widget.label != null
              ? Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: widget.label,
                        style: widget.labelStyle ??
                            DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          widget.require == null || widget.require == true
                              ? const TextSpan(
                                  text: ' *',
                                  style: TextStyle(color: Colors.red))
                              : const TextSpan(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    )
                  ],
                )
              : null,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(widget.lt ?? 8),
                  topRight: Radius.circular(widget.rt ?? 8),
                  bottomLeft: Radius.circular(widget.lb ?? 8),
                  bottomRight: Radius.circular(widget.rb ?? 8)),
              color: Colors.black12),
          height: 50,
          child: FormField<String>(
            builder: (FormFieldState<String> state) {
              return DropdownButtonHideUnderline(
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  validator: (value) {
                    if (widget.require == false) {
                      return null;
                    }
                    if (value == null || value.isEmpty) {
                      if (widget.error == null) {
                        return widget.hint;
                      }
                      return widget.error;
                    }
                    return null;
                  },
                  value: widget.items.any((element) =>
                          element == _currentSelectedValue.toString().trim() ||
                          element == widget.initialValue)
                      ? (_currentSelectedValue ?? widget.initialValue)
                      : null,
                  decoration: const InputDecoration(
                      fillColor: Colors.black12,
                      border: InputBorder.none,
                      // enabledBorder: OutlineInputBorder(
                      //   borderSide: BorderSide(color: Theme.of(context).colorScheme.secondaryContainer),
                      //   borderRadius: BorderRadius.circular(12.0),

                      // ),
                      // focusedBorder: OutlineInputBorder(
                      //   borderSide: BorderSide(color: Theme.of(context).colorScheme.surfaceTint),
                      //   borderRadius: BorderRadius.circular(12.0),

                      // ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 14, horizontal: 16)),
                  hint: Text(
                    widget.hint,
                    style: const TextStyle(color: Colors.black54),
                  ),
                  isDense: true,
                  onChanged: (newValue) {
                    widget.onChange(newValue);
                    setState(() {
                      _currentSelectedValue = newValue!;
                      state.didChange(newValue);
                    });
                  },
                  items: widget.items.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, overflow: TextOverflow.ellipsis),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
