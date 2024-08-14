 
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management/screens/auth/login_page.dart';
import 'package:inventory_management/utils/hexcolor.dart';
import 'package:inventory_management/widgets/custom_button.dart';

import '../../widgets/custom_text_field.dart';
import '../FadeAnimation.dart';

 
class SingUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [

              // HexColor("#12483e"),
              // HexColor("#308066"),
              // HexColor("#679f87"),
              // HexColor("#b6c6bd"),
              // HexColor("#f1f1f1"),
            
              Colors.blue[900]!,
              Colors.blue[500]!,
              Colors.blue[100]!
            ]
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 80,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: <Widget>[
                    Center(child: Text("H.R. Tiles & Fittings", style: TextStyle(color: Colors.white, fontSize: 36))),
                  SizedBox(height: 10,),
                   Text("Welcome", style: TextStyle(color: Colors.white, fontSize: 20),),
               
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      
                      children: <Widget>[
                          // SizedBox(height: 16),
                  //  Text("Registration", style: TextStyle(color: Colors.black, fontSize: 20),),

                        SizedBox(height: 60,),
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              offset: Offset(0, 3)
                            )]
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[200]!))
                                ),
                                child:   CustomValueCard(
                                  onChange: (t){},
              
        
               
                
              hint: "Name",),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[200]!))
                                ),
                                child:  CustomValueCard(
                                  onChange: (t){},
           
                
              hint: "Email",),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[200]!))
                                ),
                                child:  CustomValueCard(
                                  onChange: (t){},
           
                
              hint: "Passsword",),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 32,),
                    
                       SizedBox(
                        width: 150,
                         child: CustomButton(radius: 18,
                          title: "Registration",
                          isLoading: false,),
                       ),
                        SizedBox(height: 50,),
                        Text("If you have account login", style: TextStyle(color: Colors.grey),),
                        SizedBox(height: 30,),
                        InkWell(
                          onTap: (){
                            Get.to(LogingPage());
                          },
                          child: Container(
                            height: 44,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.black
                            ),
                            child: Center(
                              child: Text("Loing", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomValueCard extends StatelessWidget {
  const CustomValueCard({
    super.key,this.initialVAlue,this.lable,this.readOnly,this.lb,this.lt,this.rb,this.rt,this.hint,required this.onChange
  });

  final String? lable; 
  final String? initialVAlue; 
  final String? hint; 
  final bool? readOnly; 
  final double? rb; 
  final double? rt; 
  final Function onChange;

  final double? lt; 
  final double? lb; 
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
                padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                    
        alignment: AlignmentDirectional.centerStart,
                     
        child: 

                    Container(
        
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
      topLeft: Radius.circular(lt??8),
        topRight: Radius.circular(rt??8),
        bottomLeft: Radius.circular(lb??8),
        bottomRight: Radius.circular(rb??8)
    ),
          // color: Colors.black12
          
          ),
                     child:   TextFormField(
          readOnly: false,
          autofocus: true,
     focusNode: FocusNode(),
          initialValue:initialVAlue,
            textInputAction:  TextInputAction.next,
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
            // if (widget.require == false) {
            //   return null;
            // }
            // if (value == null || value.isEmpty) {
            //   if (widget.error == null) {
            //     return widget.hint;
            //   }
            //   return widget.error;
            // }
            // if (widget.minLength != null) {
            //   if (value.length < widget.minLength!) {
            //     if (widget.error == null) {
            //       return widget.hint;
            //     }
            //     return widget.error;
            //   }
            // }
            return null;
          },
        ),
                     
    ))],
    );
  }
}


 