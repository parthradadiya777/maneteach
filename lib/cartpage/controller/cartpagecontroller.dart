import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pagination_view/pagination_view.dart';
import 'package:sqflite/sqflite.dart';

import '../../constant/color.dart';
import '../../model/sqflite_model.dart';
import '../../sqflite_service/sqflite_service.dart';

class cartPageController extends GetxController{

  RxInt? count = 0.obs;
 RxList<Product>? notelist;
  RxInt page = 0.obs;
  PaginationViewType ?paginationViewType;
  GlobalKey<PaginationViewState> ?key;
  //int page = 1;

  bool isLoading = false;


  RxInt totalprice = 0.obs;

  void calcTotal() async{
    int total = (await Producthelper().calculateTotal())[0]['Total'];
    print(total);
    totalprice.value = total;

    print(totalprice);
    update();
  }
@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    calcTotal();

  }
}