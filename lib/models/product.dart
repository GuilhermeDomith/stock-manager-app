
import 'package:stock_manager_app/utils/datetime_converter.dart';

class Product {

  static final dtconverter = CustomDateTimeConverter();

  int id;
  String description;
  double quantity;
  DateTime lastUpdate;
  double dailySpentMean;
  DateTime endDateForecast;

  Product({
    this.id,
    this.description,
    this.quantity,
    this.lastUpdate,
    this.dailySpentMean,
    this.endDateForecast
  });


  factory Product.fromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as int,
      description: json['description'] as String,
      quantity: json['quantity'] == null
          ? null
          : json['quantity'].toDouble(),
      lastUpdate: json['last_update'] == null
          ? null
          : dtconverter.fromJson(json['last_update'] as String),
      dailySpentMean: json['mean_spend'] == null
        ? null
        : json['mean_spend'].toDouble(),
      endDateForecast: json['date_to_finish'] == null
        ? null
        : dtconverter.fromJson(json['date_to_finish'] as String),
  );

  Map<String, dynamic> toJson() => {
      'id': this.id,
      'description': this.description,
      'quantity': this.quantity,
      'last_update': dtconverter.toJson(this.lastUpdate),
      'mean_spend': this.dailySpentMean,
      'date_to_finish': dtconverter.toJson(this.endDateForecast),
  };

}

class ProductList {

  ProductList(this.products);

  final List<Product> products;

  factory ProductList.fromJson(List<dynamic> json){
    final products = json
        ?.map((product) => Product.fromJson(product))
        ?.toList();

    return ProductList(products);
  }
}