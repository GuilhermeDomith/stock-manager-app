
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_manager_app/blocs/product_bloc.dart';
import 'package:stock_manager_app/components/card_input_text.dart';
import 'package:stock_manager_app/models/product.dart';

class AddProductPage extends StatefulWidget{

  AddProductPage(this.scaffoldContext);

  final BuildContext scaffoldContext;

  @override
  State<StatefulWidget> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> with SingleTickerProviderStateMixin{

  TabController _tabController;
  ProductBloc _productBloc;

  TextEditingController descriptionCtrl;
  TextEditingController quantityCtrl;
  TextEditingController dailySpentCtrl;

  @override
  void initState() {
    super.initState();

    _productBloc = ProductBloc();

    descriptionCtrl = TextEditingController();
    quantityCtrl = TextEditingController();
    dailySpentCtrl = TextEditingController();

    _tabController = new TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    descriptionCtrl.dispose();
    quantityCtrl.dispose();
    dailySpentCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: TabBarView(
            controller: _tabController,
            children: [

              CardInputText(
                  label: 'Nome do Produto',
                  controller: descriptionCtrl,
                  onComplete: () => _tabController.animateTo(1),
              ),

              CardInputText(
                  label: 'Quantidade',
                  controller: quantityCtrl,
                  onComplete: () => _tabController.animateTo(2),
              ),

              CardInputText(
                label: 'Gasto Semanal (Média)',
                controller: dailySpentCtrl,
                  onComplete: () => saveNewProduct(context),
              ),

            ],
          ),
      ),
    );
  }

  saveNewProduct(BuildContext context) async {

    var description = descriptionCtrl.text;
    var dailySpent = dailySpentCtrl.text;
    var quantity = quantityCtrl.text;

    var product = Product(
        description: description,
        quantity: double.parse(quantity),
        dailySpentMean: double.parse(dailySpent),
        //lastUpdate: DateTime.now()
    );

    var success = await _productBloc.addProduct(product);

    print(success);

    if(success) {
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
      Scaffold.of(widget.scaffoldContext).showSnackBar(
          SnackBar(content: Text('Não foi possível adicionar o item.'))
      );
    }

    //_tabController.animateTo(3);
  }
}

