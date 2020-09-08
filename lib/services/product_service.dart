
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stock_manager_app/models/product.dart';
import 'package:stock_manager_app/services/service.dart';


class ProductService extends CustomService{

  Future<ProductList> listProducts() async {
    try {
      Response response = await api.get('/products');

      return ProductList.fromJson(response.data);
    } catch(e){
      throw SocketException(e.toString());
    }
  }

  Future<ProductList> listProductsInAlert() async {
    try {
      Response response = await api.get('/products');

      return ProductList.fromJson(response.data);
    } catch(e){
      throw SocketException(e.toString());
    }
  }

  Future<bool> addProduct(Product product) async {
    var data = product.toJson();
    Response response = await api.post('/products', data: data);
    return true;
  }

  Future<bool> deleteProduct(int id) async {
    Response response = await api.delete('/products/${id}');
    return true;
  }

  Future<bool> getProduct(int id) async {
    Response response = await api.get('/products/${id}');
    return true;
  }

}