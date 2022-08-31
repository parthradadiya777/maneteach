import 'dart:developer';

import 'package:get/get.dart';
import 'package:manektech/Api/model/model.dart';
import '../serices/product_services.dart';

class ProductApiController extends GetxController with StateMixin {
dynamic p = [].obs;
var isLoading = true.obs;
 getProduct({var page}) async{
  try {
  var resp = await ProductServices().ProductServiceList();
  log('aaya dekho data aaya');
  log('data fron controller before condition ==>  $resp');
if(resp != null){
  log('data fron controller==> $resp');
p= resp.data;
  isLoading(false);
  update();
}
} on Exception catch (e) {
  log('error in contrioller ==>  $e');
}





}
 @override
  void onInit() {
    ProductApiController().getProduct();
    // TODO: implement onInit
    super.onInit();
  }

}