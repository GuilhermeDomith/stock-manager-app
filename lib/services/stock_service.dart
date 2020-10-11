
import 'package:dio/dio.dart';
import 'package:stock_manager_app/models/replenishing.dart';
import 'package:stock_manager_app/services/service.dart';


class StockService extends CustomService{

  Future<String> replenishingProduct(Replenishing replenishing) async {
    var data = replenishing.toJson();
    var id = replenishing.productId;

    try {
      var response = await api.post('/stock/products/$id', data: data);
      return response.data['message'];
    } on DioError catch (e) {
      return e.response.data['message'];
    }

  }

}