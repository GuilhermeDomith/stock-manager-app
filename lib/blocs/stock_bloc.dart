import 'dart:io';

import 'package:rxdart/rxdart.dart';
import 'package:stock_manager_app/models/product.dart';
import 'package:stock_manager_app/models/replenishing.dart';
import 'package:stock_manager_app/services/product_service.dart';
import 'package:stock_manager_app/services/stock_service.dart';

class StockBloc {

  final _service = StockService();

  Future<String> replenishingProduct(Replenishing replanishing) async {
    String message = null;

    try {
      message = await _service.replenishingProduct(replanishing);
    } catch(e) {
      print(e.toString());
    }

    return Future.value(message);
  }

}