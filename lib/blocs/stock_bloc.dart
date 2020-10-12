import 'package:stock_manager_app/models/replenishing.dart';
import 'package:stock_manager_app/services/stock_service.dart';

class StockBloc {

  final _service = StockService();

  Future<String> replenishingProduct(Replenishing replanishing) async {
    String message;
    try {
      message = await _service.replenishingProduct(replanishing);
    } catch(e) {
      print(e.toString());
    }
    return Future.value(message);
  }

}