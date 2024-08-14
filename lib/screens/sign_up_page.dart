 
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'dart:ui';

import '../utils/custom_dialog.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
 
 

class SignUpPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(16),
        // width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                
                  SizedBox(height: 40,),
        
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.5, 0.7, 0.9],
            colors: [
              Colors.blue[500]!,
              Colors.blue[400]!,
              Colors.blue[200]!,
              Colors.blue[100]!,
            ],
          ),),child:
        
            Text("Appointment Schedule",style: TextStyle(fontSize: 24,color: Colors.white,fontWeight: FontWeight.bold),),),
            
            // Container(
            //   // color: Colors.amber,
            //   width: fem*280,
            //   child: CircleAvatar(
            //     radius: 80,
            //     backgroundImage: AssetImage("assets/pp.png")),), 
                
                
                  SizedBox(height: 100,),
              CustomTextField(
                keyboardType: TextInputType.emailAddress,
               
                txt: "Enter Your Email",
                label: "Enter Your Email",onChange: (t){
                  print(t);
        
               
                },hint: "Email",),
        
        
              SizedBox(height: 20,),
              CustomTextField(
               isPasswordField: true,
        
                txt: "Enter Your password",
                
                label: "Enter Your password",onChange: (t){
                  print(t);

                  
                },hint: "passsword",),
        
        
              SizedBox(height: 20,),
              Obx(()=>
                 CustomButton(
                  
                  
                  title: "Login",onPressed: (){
                   
                },isLoading: false,),
              )
            
               ,   SizedBox(height: 120,),
            
            
            
          ],),
        ),
            ),
    );
  }
}