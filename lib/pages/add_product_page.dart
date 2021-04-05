
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_manager_app/blocs/product_bloc.dart';
import 'package:stock_manager_app/components/alerts.dart';
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
  DatePickerController entryDateCtrl;

  @override
  void initState() {
    super.initState();

    _productBloc = ProductBloc();

    descriptionCtrl = TextEditingController();
    quantityCtrl = TextEditingController();
    dailySpentCtrl = TextEditingController(text: '100');
    entryDateCtrl = DatePickerController();

    _tabController = new TabController(vsync: this, length: 4);
  }

  @override
  void dispose() {
    _tabController.dispose();
    descriptionCtrl.dispose();
    quantityCtrl.dispose();
    dailySpentCtrl.dispose();
    entryDateCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
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

              CardInputDate(
                label: 'Data de Entrada',
                description: 'Em que data esta quantidade entrou no estoque?',
                controller: entryDateCtrl,
                onComplete: () => _tabController.animateTo(3),
              ),

              CardInputText(
                label: 'Gasto Semanal',
                description: 'Qual o gasto médio deste produto por semana?',
                controller: dailySpentCtrl,
                onComplete: () => saveNewProduct(context),
              ),

            ],
          ),
      ),
    );
  }

  Product validate() {

    var dialog = (msg, toTab) {
      AppAlerts.showOkDialog(
          context,
          title: "Informação Inválida",
          message: msg,
          onClose: () => _tabController.animateTo(toTab));
      return null;
    };

    if(descriptionCtrl.text.isEmpty)
      return dialog("O nome do produto deve ser fornecido.", 0);

    var quantity;
    try {
      quantity = double.parse(quantityCtrl.text);
    }  on FormatException {
      return dialog("A quantidade fornecida não é um valor válido.", 1);
    }

    var weeklySpent;
    try {
      weeklySpent = double.parse(dailySpentCtrl.text);
    } on FormatException {
      return dialog("O gasto medio fornecido não é um valor válido.", 3);
    }

    var dailySpent = weeklySpent / 7;
    print(dailySpent);

    return Product(
        description: descriptionCtrl.text,
        quantity: quantity,
        dailySpentMean: dailySpent,
        lastUpdate: entryDateCtrl.date
    );
  }

  saveNewProduct(BuildContext context) async {

    var product = this.validate();
    if(product == null)
      return;

    var success = await _productBloc.addProduct(product);

    print(success);

    if(success) {
      Navigator.pop(context);
      Scaffold.of(widget.scaffoldContext).showSnackBar(
          SnackBar(content: Text('Item adicionado.'))
      );
    } else {
      Navigator.pop(context);
      Scaffold.of(widget.scaffoldContext).showSnackBar(
          SnackBar(content: Text('Não foi possível adicionar o item.'))
      );
    }

    //_tabController.animateTo(3);
  }
}

