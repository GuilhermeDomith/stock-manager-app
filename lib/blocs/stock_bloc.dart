import 'package:rxdart/rxdart.dart';
import 'package:stock_manager_app/models/product.dart';
import 'package:stock_manager_app/models/replenishing.dart';
import 'package:stock_manager_app/services/stock_service.dart';

class StockBloc {

  final _service = StockService();
  final _controllerStock = BehaviorSubject<ProductList>();
  final _controllerLowStock = BehaviorSubject<ProductList>();

  get controllerStock => _controllerStock;
  get controllerLowStock => _controllerLowStock;

  Future<ProductList> listStock() async {
    ProductList products;

    try {
      products = await _service.listStock();
    } catch(e) {
      print(e.toString());
      products = _controllerStock.value;
    }

    if (_controllerStock.isClosed)
      return null;

    _controllerStock.sink.add(products);
    return products;
  }

  Future<ProductList> listLowStock() async {
    ProductList products;

    try {
      products = await _service.listLowStock();
    } catch(e) {
      print(e.toString());
      products = _controllerLowStock.value;
    }

    if (_controllerLowStock.isClosed)
      return null;

    _controllerLowStock.sink.add(products);
    return products;
  }

  Future<String> replenishingProduct(Replenishing replanishing) async {
    String message;
    try {
      message = await _service.replenishingProduct(replanishing);
    } catch(e) {
      print(e.toString());
    }
    return Future.value(message);
  }

  Future<bool> restoreLastUpdateProduct(int id) async {
    bool success = await _service.restoreLastUpdateProduct(id);
    return Future.value(success);
  }

  void dispose(){
    _controllerStock.close();
    _controllerLowStock.close();
  }

}