import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:stock_manager_app/blocs/product_bloc.dart';
import 'package:stock_manager_app/blocs/stock_bloc.dart';
import 'package:stock_manager_app/components/alerts.dart';
import 'package:stock_manager_app/components/card_product.dart';
import 'package:stock_manager_app/components/connection.dart';
import 'package:stock_manager_app/components/progress.dart';
import 'package:stock_manager_app/models/product.dart';
import 'package:stock_manager_app/pages/home_page.dart';
import 'package:stock_manager_app/pages/replenishing_page.dart';

class StockPage extends StatefulWidget{

  StockPage(this.choice, {Key key}) : super(key:key);

  final Choice choice;

  static Widget newInstance(Choice choice) => StockPage(choice);

  @override
  State<StatefulWidget> createState() => _StockPageState(this.choice);
}

class _StockPageState extends State<StockPage>{

  _StockPageState(this.choice);

  final Choice choice;
  final title = 'Products Stock';

  StockBloc _stockBloc;
  ProductBloc _productBloc;

  @override
  void initState() {
    super.initState();
    _stockBloc = StockBloc();
    _productBloc = ProductBloc();
    this.refreshScreen();
  }

  @override
  void dispose() {
    super.dispose();
    _stockBloc.dispose();
    _productBloc.dispose();
  }

  Future<void> refreshScreen() async {
    _stockBloc.listStock();
    _stockBloc.listLowStock();
  }

  @override
  Widget build(BuildContext context) {

    final TextStyle textStyle = Theme.of(context).textTheme.headline4;

    return Scaffold(
      appBar: AppBar(title: Text(this.title)),
      body: Builder(
        builder: (context) =>
            _body(context)
      ),
    );
  }

  Widget _body(BuildContext scaffoldContext) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: RefreshIndicator(
        onRefresh: this.refreshScreen,
        child: Column(
          children: <Widget>[
            _listViewProductsAlert(scaffoldContext),
            _listViewProductsStock(scaffoldContext),
          ],
        ),
      ),
    );
  }

  Widget _listViewProductsAlert(BuildContext scaffoldContext) {
    return StreamBuilder(
        stream: _stockBloc.controllerLowStock.stream,
        builder: (BuildContext context, AsyncSnapshot<ProductList> snapshot) =>

            Container(
                child: snapshot.hasData && snapshot.data.products.length > 0
                ? Padding(
                    padding: EdgeInsets.all(8),
                    child: snapshot.hasData
                        ? Container(
                            height: 180,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data.products.length,
                                itemBuilder: ( _, int index) =>

                                    CardProductAlert(
                                        width: MediaQuery.of(context).size.width * 0.75,
                                        product: snapshot.data.products[index],
                                    )

                            ),
                          )
                        : Center(
                            child: snapshot.connectionState == ConnectionState.waiting
                                ? AppCircularProgressIndicator()
                                : LostConnection()
                          )
                  )
                :  null
            )
    );
  }

  Widget _listViewProductsStock(BuildContext scaffoldContext) {
    return StreamBuilder<ProductList>(
      stream: _stockBloc.controllerStock.stream,
      builder: ( _, AsyncSnapshot<ProductList> snapshot) =>

        Expanded(
            child: snapshot.hasData
                ? Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data.products.length,
                        itemBuilder: ( _, int index) =>

                            CardProduct(
                              //height: 120,
                              product: snapshot.data.products[index],
                              onEditClick: () => this.onClickEditProduct(
                                  scaffoldContext,
                                  snapshot.data.products[index]
                              ),
                              onDeleteClick: () => this.onClickDeleteProduct(
                                snapshot.data.products[index]
                              ),
                              onRestoreClick: () => this.onClickRestoreProduct(
                                  snapshot.data.products[index]
                              ),
                            ),

                      )
                  )
                : Center(
                      child: snapshot.connectionState == ConnectionState.waiting
                        ? AppCircularProgressIndicator()
                        : LostConnection()
                  )
          )
    );
  }
  
  void _deleteProduct(Product product) async {
    bool success = await _productBloc.deleteProduct(product.id);

    String message;
    if(!success) {
      message = 'Erro ao excluir o item de código ${product.id}';
    } else {
      refreshScreen();
      message = 'Item de código ${product.id} foi excluído';
    }

    Scaffold.of(this.context).showSnackBar(SnackBar(
        content: Text(message)));
  }

  void _restoreProduct(Product product) async {
    bool success = await _stockBloc.restoreLastUpdateProduct(product.id);

    String message;
    if(!success) {
      message = 'Erro ao restaurar o item de código ${product.id}';
    } else {
      refreshScreen();
      message = 'Item de código ${product.id} foi restaurado';
    }

    Scaffold.of(this.context).showSnackBar(SnackBar(
        content: Text(message)));
  }

  void onClickEditProduct(BuildContext scaffoldContext, Product product) {
    Navigator.push(
        scaffoldContext,
        MaterialPageRoute(builder:
            (context) => ReplenishingPage(scaffoldContext, product))
    );
  }

  void onClickRestoreProduct(Product product) {
    AppAlerts.showConfirmDialog(
        context,
        title: "Restaurar Estoque",
        message: 'Deseja restaurar a última atualização do item "${product.description}."',
        onConfirm: () => _restoreProduct(product)
    );
  }

  void onClickDeleteProduct(Product product) {
    AppAlerts.showConfirmDialog(
        context,
        title: "Excluir Item",
        message: 'Deseja excluir o item "${product.description}."',
        onConfirm: () => _deleteProduct(product)
    );
  }
}