
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:stock_manager_app/blocs/stock_bloc.dart';
import 'package:stock_manager_app/components/card_input_text.dart';
import 'package:stock_manager_app/models/product.dart';
import 'package:stock_manager_app/models/replenishing.dart';

class ReplenishingPage extends StatefulWidget{

  ReplenishingPage(this.scaffoldContext, this.product);

  final BuildContext scaffoldContext;
  final Product product;

  @override
  State<StatefulWidget> createState() => _ReplenishingPageState();
}

class _ReplenishingPageState extends State<ReplenishingPage> with SingleTickerProviderStateMixin {

  TabController _tabController;
  StockBloc _stockBloc;

  TextEditingController availableQuantityCtrl;
  DatePickerController availableOnDateCtrl;
  TextEditingController addQuantityCtrl;
  DatePickerController addOnDateCtrl;

  @override
  void initState() {
    super.initState();

    _stockBloc = StockBloc();

    availableQuantityCtrl = TextEditingController();
    availableOnDateCtrl = DatePickerController();
    addQuantityCtrl = TextEditingController();
    addOnDateCtrl = DatePickerController();

    _tabController = new TabController(vsync: this, length: 4);
  }

  @override
  void dispose() {
    _tabController.dispose();
    availableQuantityCtrl.dispose();
    availableOnDateCtrl.dispose();
    addQuantityCtrl.dispose();
    addOnDateCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String product = widget.product.description;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: TabBarView(
            controller: _tabController,
            children: [

              CardInputText(
                  label: 'Quantidade Disponível',
                  description: 'Antes de adicionar ao estoque, me conte. Qual a quantidade disponível antes da reposição?',
                  controller: availableQuantityCtrl,
                  onComplete: () => _tabController.animateTo(1),
              ),

              CardInputDate(
                label: 'Data de Contagem',
                description: 'Em qual data essa quantidade disponível foi checada?',
                controller: availableOnDateCtrl,
                onComplete: () => _tabController.animateTo(2),
              ),

              CardInputText(
                  label: 'Quantidade à Adicionar',
                  description: 'Qual a quantidade deseja repor do produto "$product"',
                  controller: addQuantityCtrl,
                  onComplete: () => _tabController.animateTo(3),
              ),

              CardInputDate(
                label: 'Data de Reposição',
                description: 'Em qual data esta reposição será feita?',
                controller: addOnDateCtrl,
                onComplete: () => saveNewProduct(context),
              ),

            ],
          ),
      ),
    );
  }

  saveNewProduct(BuildContext context) async {

    var availableQuantity = double.parse(availableQuantityCtrl.text);
    var availableOnDate = availableOnDateCtrl.selectedDate;
    var addQuantity = double.parse(addQuantityCtrl.text);
    var addOnDate = addOnDateCtrl.selectedDate;

    var replenishing = Replenishing(
        productId: widget.product.id,
        availableQuantity: availableQuantity,
        availableOnDate: availableOnDate,
        addQuantity: addQuantity,
        addOnDate: addOnDate
    );

    var message = await _stockBloc.replenishingProduct(replenishing);

    print(message);

    if(message == null) {
      message = 'Não foi possível realizar a reposição.';
    }

    Navigator.pop(context);
    Scaffold.of(widget.scaffoldContext)
        .showSnackBar(
          SnackBar(
            content: Text(message),
            duration: Duration(seconds: 15),
          ),
    );

  }
}

