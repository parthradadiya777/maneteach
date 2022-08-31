import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../Api/controller/product_Controller.dart';
import '../cartpage/cartpage.dart';
import '../constant/color.dart';
import '../model/sqflite_model.dart';
import '../sqflite_service/sqflite_service.dart';
import 'controller/homecontroller.dart';

class HomePage extends GetView<ProductApiController> {
  
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() =>ProductApiController());



    double height1 = MediaQuery.of(context).size.height;
    double width1 = MediaQuery.of(context).size.width;
  controller.getProduct();
    final dbhelper = Producthelper.instance;




    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: appbar,
        centerTitle: true,
        title: const Text('Shopping Mall'),
        actions: [
          IconButton(onPressed: () {
            Get.to(()=>CartPage());

          }, icon: const Icon(Icons.shopping_cart))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        height: height1,
        width: width1,
        child: Obx(()=>controller.isLoading.value ==false? GridView.builder(
              itemCount:controller.p.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 2, crossAxisSpacing: 10),
              itemBuilder: (context, index) {

                return Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius:  BorderRadius.all( Radius.circular(10)),
                  ),
                  elevation: 10,
                  child: Column(
                    children: [
                      Expanded(flex: 2, child: Image.network(controller.p[index].featuredImage)),
                      Expanded(
                          child: Container(
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Price: ${controller.p[index].price}"),
                            IconButton(
                                onPressed: () {
                                 // inserdata();
                                  showDialog(context: context, builder: (_){
                                    return AlertDialog(
                                      title: const Text('Add Product'),
                                      content: const Text('Are You Sure Add Cart Page'),
                                      actions: [
                                        TextButton(onPressed: (){
                                          Get.back();

                                          Fluttertoast.showToast(msg: 'Your Product Added Successfully');
                                          dbhelper.insertProduct(Product.fromMapObject({
                                            dbhelper.colname: controller.p[index].title,
                                            dbhelper.colprice: controller.p[index].price.toString(),
                                            dbhelper.colimage: controller.p[index].featuredImage
                                          }));
                                          print( {dbhelper.colimage: controller.p[index].featuredImage});
                                        }, child: const Text('Yes')),
                                        TextButton(onPressed: (){
                                          Get.back();
                                        }, child: const Text('No')),
                                      ],
                                    );
                                  });


                              //    Get.to(()=>CartPage());
                                },
                                icon: const Icon(Icons.add_shopping_cart))
                          ],
                        ),
                      ))
                    ],
                  ),
                );
              }) : const Center(child: CircularProgressIndicator())
        ),
      ),
    );
  }

}
