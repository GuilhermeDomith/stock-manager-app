import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:stock_manager_app/blocs/product_bloc.dart';
import 'package:stock_manager_app/components/card_product_alert.dart';
import 'package:stock_manager_app/components/connection.dart';
import 'package:stock_manager_app/models/product.dart';
import 'package:stock_manager_app/pages/home_page.dart';

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

  ProductBloc _productBloc1;
  ProductBloc _productBloc2;

  @override
  void initState() {
    super.initState();

    _productBloc1 = ProductBloc();
    _productBloc2 = ProductBloc();

    _productBloc1.listProducts();
    _productBloc2.listProductsInAlert();
  }

  @override
  void dispose() {
    super.dispose();
    _productBloc1.dispose();
    _productBloc2.dispose();
  }

  Future<void> refreshScreen() async {
    _productBloc1.listProducts();
    _productBloc2.listProductsInAlert();
  }

  @override
  Widget build(BuildContext context) {

    final TextStyle textStyle = Theme.of(context).textTheme.headline4;

    return Scaffold(
      appBar: AppBar(title: Text(this.title)),
      body: _body(),
    );
  }

  _body() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: RefreshIndicator(
        onRefresh: this.refreshScreen,
        child: Column(
          children: <Widget>[
            _listViewProductsAlert(),
            _listViewProductsStock(),
          ],
        ),
      ),
    );
  }

  _listViewProductsAlert() {
    return StreamBuilder(
        stream: _productBloc1.controller.stream,
        builder: (BuildContext context, AsyncSnapshot<ProductList> snapshot) =>

            Padding(
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
                            ? CircularProgressIndicator()
                            : LostConnection()
                      )
            )
    );
  }

  _listViewProductsStock() {
    return StreamBuilder<ProductList>(
      stream: _productBloc1.controller.stream,
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
                              onDeleteClick: () =>
                                  showAlertDialog(
                                      context,
                                      snapshot.data.products[index],
                                      () => _deleteProduct(snapshot.data.products[index])
                                  ),
                            ),

                      )
                  )
                : Center(
                      child: snapshot.connectionState == ConnectionState.waiting
                          ? CircularProgressIndicator()
                      : LostConnection()
                  )
          )
    );
  }
  
  _deleteProduct(Product product) async {
    bool success = await _productBloc1.deleteProduct(product.id);

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

  showAlertDialog(BuildContext context, Product product, Function onConfirm) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("CONFIRMAR"),
      onPressed: () {
        Navigator.of(context).pop();
        onConfirm();
      }
    );

    Widget cancelButton = FlatButton(
      child: Text("CANCELAR"),
      onPressed: () => Navigator.of(context).pop(),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Excluir Item"),
      content: Text('Deseja excluir o item "${product.description}."'),
      actions: [
        cancelButton,
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}