import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:stock_manager_app/blocs/product_bloc.dart';
import 'package:stock_manager_app/components/card_product_alert.dart';
import 'package:stock_manager_app/components/connection.dart';
import 'package:stock_manager_app/models/product.dart';
import 'package:stock_manager_app/pages/home_page.dart';

class StockAlertsPage extends StatefulWidget{
  const StockAlertsPage(this.choice, {Key key}) : super(key: key);

  final Choice choice;

  @override
  State<StatefulWidget> createState() => _StockAlertsState(this.choice);

  static Widget newInstance(Choice choice) => StockAlertsPage(choice);
}

class _StockAlertsState extends State<StockAlertsPage>{
  _StockAlertsState(this.choice);

  ProductBloc _productBloc;

  final Choice choice;
  final title = "Stock Alerts";

  @override
  void initState() {
    _productBloc = ProductBloc();
    _productBloc.listProductsInAlert();
    super.initState();
  }

  @override
  void dispose() {
    _productBloc.dispose();
    super.dispose();
  }

  Future<void> refreshList() async{
    _productBloc.listProductsInAlert();
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<ProductList>(
      stream: _productBloc.controller.stream,
      builder: ( _, AsyncSnapshot<ProductList> snapshot) {

        return Scaffold(
          appBar: AppBar(title: Text(this.title),),
          body: Container(
            padding: EdgeInsets.all(16),
            child: snapshot.hasData
                ? RefreshIndicator(
                    onRefresh: this.refreshList,
                    child: ListView.builder(
                      itemCount: snapshot.data.products.length,
                      itemBuilder: ( _, int index) =>

                          Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: CardProductAlert(
                                //height: 150,
                                product: snapshot.data.products[index],
                              )
                          )

                    ),
                  )
                : Center(
                  child: snapshot.connectionState == ConnectionState.waiting
                    ? CircularProgressIndicator()
                    : LostConnection()
                ),
          ),
        );
      },
    );
  }
}