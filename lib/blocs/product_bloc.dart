import 'dart:io';

import 'package:rxdart/rxdart.dart';
import 'package:stock_manager_app/models/product.dart';
import 'package:stock_manager_app/services/product_service.dart';

class ProductBloc {

  final _service = ProductService();
  final _controller = BehaviorSubject<ProductList>();
  get controller => _controller;

  Future<bool> get hasConnectivity async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return Future.value(true);
      }
    } on SocketException {
      return Future.value(false);
    }
    return Future.value(false);
  }

  Future<ProductList> listProducts() async {

    if (! await this.hasConnectivity)
      return _controller.value;

    ProductList products;

    try {
      products = await _service.listProducts();
    } catch(e) {
      print(e.toString());
      products = _controller.value;
    }

    if (_controller.isClosed)
      return null;

    _controller.sink.add(products);
    return products;
  }

  Future<ProductList> listProductsInAlert() async {

    if (! await this.hasConnectivity)
      return _controller.value;

    ProductList products;

    try {
      products = await _service.listProductsInAlert();
    } catch(e) {
      print(e.toString());
      products = _controller.value;
    }

    if (_controller.isClosed)
      return null;

    _controller.sink.add(products);
    return products;
  }

  Future<bool> addProduct(Product product) async {
    bool success;

    try {
      success = await _service.addProduct(product);
    } catch(e) {
      print(e.toString());
      success = false;
    }

    return Future.value(success);
  }

  Future<bool> deleteProduct(int id) async {
    bool success;

    try {
      success = await _service.deleteProduct(id);
    } catch(e) {
      print(e.toString());
      success = false;
    }

    return Future.value(success);
  }

  void dispose(){
    _controller.close();
  }
}