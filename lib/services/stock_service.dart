
import 'package:dio/dio.dart';
import 'package:stock_manager_app/models/replenishing.dart';
import 'package:stock_manager_app/services/service.dart';


class StockService extends CustomService{

  Future<String> replenishingProduct(Replenishing replenishing) async {
    var data = replenishing.toJson();
    var id = replenishing.productId;
    String message = null;

    try{
      var response = await api.post('/stock/products/$id', data: data);
      message = response.data['status'];
    }on DioError catch (e) {
      if(e.response.data.containsKey('status'))
        message = e.response.data['status'];
    }

    return message;
  }

}