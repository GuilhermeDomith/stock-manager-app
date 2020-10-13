
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:stock_manager_app/models/product.dart';
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

  Future<bool> restoreLastUpdateProduct(int id) async {
    try {
      var response = await api.post('/stock/products/$id/restore');
      return response.data['success'];
    } on DioError catch (e) {
      return e.response.data['success'];
    }
  }

  Future<ProductList> listStock() async {
    try {
      Response response = await api.get('/stock');
      var data = response.data;
      return ProductList.fromJson(data['items']);
    } catch(e){
      throw SocketException(e.toString());
    }
  }

  Future<ProductList> listLowStock() async {
    try {
      Response response = await api.get('/stock/low');
      var data = response.data;
      return ProductList.fromJson(data['items']);
    } catch(e){
      throw SocketException(e.toString());
    }
  }

}