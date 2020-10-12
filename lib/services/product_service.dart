
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:stock_manager_app/models/product.dart';
import 'package:stock_manager_app/services/service.dart';


class ProductService extends CustomService{

  Future<ProductList> listProducts() async {
    try {
      Response response = await api.get('/products');
      var data = response.data;
      return ProductList.fromJson(data['items']);
    } catch(e){
      throw SocketException(e.toString());
    }
  }

  Future<ProductList> listProductsInAlert() async {
    try {
      Response response = await api.get('/products');
      var data = response.data;
      return ProductList.fromJson(data['items']);
    } catch(e){
      throw SocketException(e.toString());
    }
  }

  Future<bool> addProduct(Product product) async {
    var data = product.toJson();
    Response response = await api.post('/products', data: data);
    return response.data['success'];
  }

  Future<bool> deleteProduct(int id) async {
    Response response = await api.delete('/products/$id');
    print(response.data['success']);
    return response.data['success'];
  }

  Future<bool> getProduct(int id) async {
    Response response = await api.get('/products/$id');
    return response.data['success'];
  }

}