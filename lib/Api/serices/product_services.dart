import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:manektech/Api/model/model.dart';

class ProductServices extends GetConnect{
   var  uri = 'http://205.134.254.135/~mobile/MtProject/public/api/product_list.php';


 Future ProductServiceList({page}) async {
  //
  try {
  final response = await get(uri,headers: {
   'token':'eyJhdWQiOiI1IiwianRpIjoiMDg4MmFiYjlmNGU1MjIyY2MyNjc4Y2FiYTQwOGY2MjU4Yzk5YTllN2ZkYzI0NWQ4NDMxMTQ4ZWMz'
  },);
  
  var jsonresponce = json.decode(response.body);
  log("json responce=>$jsonresponce");
  if(response.statusCode ==200){
    
    var data = ProductModel.fromJson(jsonresponce) ;
    log('data from service ==> $data');
    return data;
  }
} on Exception catch (e) {
log("erro is this =>$e.toString()");
  // TODO
}


  }

  
}