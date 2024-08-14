import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import 'expense_history_controller.dart';

class ExpenseHistoryPage extends StatelessWidget {
    ExpenseHistoryPage({super.key});
final controller=Get.put(ExpenseHistoryController());
  @override
  Widget build(BuildContext context) {
     print(Jiffy.now().dateTime);
     var date= Jiffy.now().dateTime;
    var l=  date.toString().split(" ");
   var d= l[0].split("-");
   var finald="${d[2]+"/"+d[1]+"/"+d[0]}";
  
   print(finald);

    return   Scaffold(

      bottomSheet: Container(
        color: Colors.transparent,
        // height: 60,
        child: 
                                      Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Expanded(
                                              child: Padding(
                                                  child: Text("Total expense"),
                                                  padding:
                                                      EdgeInsets.only(left: 12))),
                                          Padding(
                                            padding: EdgeInsets.only(right: 8),
                                            child: Obx(()=>controller.isLoading.value==true?CupertinoActivityIndicator(): Text( "${controller.totalAmount.value} ৳"?? "129 ৳ ",style: TextStyle(fontSize: 16),)),
                                          )
                                        ],
                                      ),
                                    ),),
                          
      appBar: AppBar(title:   const Text(
                        "View Expense",
                       
                      ),),
      body:Obx(() => 
      
      controller.isLoading.value==true?Center(child: CircularProgressIndicator()): Column(children: [
             const SizedBox(height: 8,),

    

          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [
             const Text("Date",style: TextStyle(fontWeight: FontWeight.bold),),
             const SizedBox(width: 8,),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [   
                Row(children: [const Icon(Icons.calendar_month,size: 20,),const SizedBox(width: 8,),
                Text(
                              controller.  startDate??"12/12/2023",style: const TextStyle(fontWeight: FontWeight.bold),
                               
                              ),
                              
                            
                
                ]),   const SizedBox(width: 8,),
            
                              const SizedBox(
                                width: 20,
                                child: Divider(thickness: 2,)),    const SizedBox(width: 8,),
                Row(children: [const Icon(Icons.calendar_month,size: 20,),const SizedBox(width: 8,),
                Text(
                                finald??"12/12/2023",style: const TextStyle(fontWeight: FontWeight.bold),
                               
                              ),
                              
                            
                
                ]), 
              ],
            ),
          ],
        ),
     const SizedBox(height: 16,),
            const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(children: [
            
            Expanded(
              flex: 1,
              child: Text("#",style: TextStyle(fontWeight: FontWeight.bold),)),
            SizedBox(width: 4,),
               Expanded(
                flex: 2,
                child: Text("Date",style: TextStyle(fontWeight: FontWeight.bold),)),
            SizedBox(width: 4,),
        
            
            Expanded(
                flex: 2,
              
              child: Text("Catagory",style: TextStyle(fontWeight: FontWeight.bold),)),
            SizedBox(width: 4,),
            
            Expanded(
                flex: 2,
              
              child: Text("Amount",style: TextStyle(fontWeight: FontWeight.bold),)),
            SizedBox(width: 4,),
            
            Expanded(
                flex: 2,
              
              child: Text("details",style: TextStyle(fontWeight: FontWeight.bold),)),
            SizedBox(width: 4,),          
            
          ],),
        ),
     
      const SizedBox(height: 16,),
      const Divider(height: 1,),
      Expanded(child: ListView.builder(
        itemCount: controller.expenseHistory?.length,
        itemBuilder: (context, index) {
          final item=controller.expenseHistory?[index];
        return   ExpenseCard(
          details: item?.details,
          isOdd: index.isEven,amount: item!.amount,catagory: item.categoryName,date: Jiffy.parse(item.date.toString()).MMMd.toString(),);
      },)),
     


        




      ],),));
  }
}

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({
    super.key,this.amount,this.catagory,this.date,this.details,this.isOdd,this.index
  });

  final String? amount;
  final String? date;
  final String? catagory;
  final String? index;
  final String? details;
  final bool? isOdd;

  @override
  Widget build(BuildContext context) {
    return Container(
     decoration:isOdd==true?null: BoxDecoration(
       color:Theme.of(context).colorScheme.secondaryContainer ,
       border: Border(top: BorderSide(color: Theme.of(context).colorScheme.secondary.withOpacity(.5)))
     ),

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          
           Expanded(
             flex: 1,
             child: Text(index??"1",style: const TextStyle(fontWeight: FontWeight.normal),)),
           const SizedBox(width: 4,),
              Expanded(
               flex: 2,
               child: Text(
                date??
                "12 Sep",style: const TextStyle(fontWeight: FontWeight.normal),)),
           const SizedBox(width: 4,),
               
          
           Expanded(
               flex: 2,
             
             child: Text(
              catagory??
              "Water bill",style: const TextStyle(fontWeight: FontWeight.normal),)),
           const SizedBox(width: 4,),
          
           Expanded(
               flex: 2,
             
             child: Text(
              amount??
              "1209 ৳",style: const TextStyle(fontWeight: FontWeight.normal),)),
           const SizedBox(width: 4,),
          
           Expanded(
               flex: 2,
             
             child: Text(
              details??
              "the price paid or required for sured in money, time, or energy;",maxLines: 2,overflow: TextOverflow.ellipsis,style: const TextStyle(fontWeight: FontWeight.normal),)),
      
        
          
          
          
         ],),
      ),
    );
  }
}



class MyContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        // height: 200,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Text 1',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            Text(
              'Text 2',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            Text(
              'Text 3',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
