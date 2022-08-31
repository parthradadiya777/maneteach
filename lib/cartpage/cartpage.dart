import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:manektech/homepage/homepage.dart';
import 'package:pagination_view/pagination_view.dart';
import 'package:sqflite/sqflite.dart';
import '../constant/color.dart';
import '../homepage/controller/homecontroller.dart';
import '../model/sqflite_model.dart';
import '../sqflite_service/sqflite_service.dart';
import 'controller/cartpagecontroller.dart';

class CartPage extends GetView<cartPageController> {
  List<Product>? notelist;
  int? count = 0;



  Homecontroller homecontroller = Homecontroller();

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() =>cartPageController());

    double height1 = MediaQuery
        .of(context)
        .size
        .height;
    double width1 = MediaQuery
        .of(context)
        .size
        .width;


    if (notelist == null) {
      notelist = <Product>[];
    }

    var totalprice = 0.0;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: appbar,
        centerTitle: true,
        title: Text('Product List'),
      ),
      body:
           Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                flex: 9,
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: 200,
                  width: width1,
                  child: FutureBuilder(
                    future: Producthelper().fetchdata(),
                    builder: (context,AsyncSnapshot snapshot) {
                      if(snapshot.hasData){
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {

                            return Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                            height: height1 * 0.15,
                                            color: Colors.lightBlue,
                                            width: width1,
                                            child: Text(index.toString())
                                        )),
                                    Expanded(
                                        flex: 2,
                                        child: Column(
                                          children: [
                                            Text('Product : ${snapshot.data[index].name}'),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceAround,
                                              children: [
                                                Text('Price'),
                                                Text(snapshot.data![index].price.toString()),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceAround,
                                              children: [
                                                Text('Quantity'),
                                                Text('1'),
                                              ],
                                            ),
                                            IconButton(onPressed: (){
                                              showDialog(context: context, builder: (_){
                                                return AlertDialog(
                                                  title: Text('Delete Product'),
                                                  content: Text('Are You Sure Delete Product'),
                                                  actions: [
                                                    TextButton(onPressed: (){

                                                      Producthelper().deleteNote(snapshot.data[index].id);
                                                      Get.back();
                                                      Fluttertoast.showToast(msg: 'Product Deleted Successfully');
                                                      Get.off(()=>HomePage() );


                                                    }, child: Text('Yes')),
                                                    TextButton(onPressed: (){
                                                      Get.back();
                                                    }, child: Text('No'))

                                                  ],
                                                );
                                              });
                                            }, icon: Icon(Icons.delete))
                                          ],
                                        ))
                                  ],
                                )
                            );
                          });
                    }else{
                        return Center(child: CircularProgressIndicator());
                      }
    }
                  ),
                ),),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: FutureBuilder(
                          future: Producthelper().fetchdata(),
                          builder: (context,AsyncSnapshot snapshot) {
                            //  controller.count= snapshot.data.length.obs;
                            if(snapshot.hasData) {
                              return Container(
                                  width: width1,
                                  color: Colors.yellow,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text('Total Item : ${snapshot.data.length}'),
                                      //Text('Grand Total : ${controller.totalprice}'),

                                    ],
                                  ));
                            }else{
                              return Center(child: CircularProgressIndicator(),);
                            }
                          }
                      )),
                  Expanded(
                      flex: 1,
                      child: Container(
                      width: width1,
                      color: Colors.yellow,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                       //   Text('Total Item : ${snapshot.data.length}'),
                          Obx(()=> Text('Grand Total : ${controller.totalprice.value}')),
                        ],
                      ))
                  )
                ],
              ),

            ],
          ),

      );

  }
  //


}



