

import 'package:stock_manager_app/utils/datetime_converter.dart';

class Replenishing {

  static final dtconverter = CustomDateTimeConverter();

  int productId;
  double availableQuantity;
  DateTime availableOnDate;
  double addQuantity;
  DateTime addOnDate;

  Replenishing({
    this.productId,
    this.availableQuantity,
    this.availableOnDate,
    this.addQuantity,
    this.addOnDate
  });

  Map<String, dynamic> toJson() => {
    'availableQuantity': this.availableQuantity,
    'availableOnDate': dtconverter.toJson(this.availableOnDate),
    'addQuantity': this.addQuantity,
    'addOnDate': dtconverter.toJson(this.addOnDate),
  };
}