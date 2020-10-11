
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
    if(descriptionCtrl.text.isEmpty) {
      showAlertDialog( context, "Informação Inválida",
          "O nome do produto deve ser fornecido.",
          () => _tabController.animateTo(0)
      );
      return null;
    }

    var quantity;
    try {
      quantity = double.parse(quantityCtrl.text);
    }  on FormatException catch (e) {
      showAlertDialog( context, "Informação Inválida",
          "A quantidade fornecida não é um valor válido.",
          () => _tabController.animateTo(1)
      );
      return null;
    }

    var dailySpent;
    try {
      dailySpent = double.parse(dailySpentCtrl.text);
    } on FormatException catch (e){
      showAlertDialog( context, "Informação Inválida",
          "O gasto medio fornecido não é um valor válido.",
          () => _tabController.animateTo(3)
      );
      return null;
    }

    return Product(
        description: descriptionCtrl.text,
        quantity: quantity,
        dailySpentMean: dailySpent,
        lastUpdate: entryDateCtrl.selectedDate
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

  void showAlertDialog(BuildContext context, title, message, Function onConfirm) {

    Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context).pop();
          if(onConfirm != null)
            onConfirm();
        }
    );

    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
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

