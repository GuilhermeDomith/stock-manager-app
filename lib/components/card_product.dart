import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:stock_manager_app/models/product.dart';

class CardProductAlert extends StatelessWidget{

  const CardProductAlert({
    Key key,
    this.product,
    this.height,
    this.width,
    this.onCardTap }) : super(key: key);

  final Product product;
  final double width;
  final double height;

  final Function onCardTap;

  @override
  Widget build(BuildContext context) {
    return CardCustom(
      height: this.height,
      width: this.width,
      onTap: this.onCardTap,
      children: <Widget>[

              Text(
                product.description,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87
                ),
              ),

              Divider(),

            Container(
              padding: EdgeInsets.all(8),
              child: Row(
                children: <Widget>[

                  LabelFeatured(
                      Icons.move_to_inbox,
                      NumberFormat('0').format(product.quantity) + ' Un.',
                      Theme.of(context).primaryColorDark
                  ),

                  LabelFeatured(
                      Icons.new_releases,
                      NumberFormat('0').format(
                          (product.daysToFinish < 0)? 0 : product.daysToFinish
                      ) + ' dias',
                      Theme.of(context).primaryColorDark,
                  ),

                ],
              ),
            ),

            LabelAndValue(label:'Código:', value: product.id.toString()),
            LabelAndValue(label:'Gasto Semanal:', value: NumberFormat('0').format(product.weeklySpentMean) + ' Un.'),
            LabelAndValue(label:'Última atualização:', value: DateFormat('dd/MM/yyyy').format(product.lastUpdate)),

          ],
    );
  }
}


class CardProduct extends StatelessWidget{

  const CardProduct({
    Key key,
    this.product,
    this.height,
    this.width,
    this.onDeleteClick,
    this.onEditClick,
    this.onRestoreClick,
    this.onCardTap}) : super(key: key);

  final Product product;
  final double width;
  final double height;

  final Function onDeleteClick;
  final Function onEditClick;
  final Function onRestoreClick;
  final Function onCardTap;


  @override
  Widget build(BuildContext context) {
    return CardCustom(
      height: this.height,
      width: this.width,
      onTap: this.onCardTap,
      children: <Widget>[
        Row(
            children: <Widget>[

              Expanded(
                child: Text(
                  product.description,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: this.onEditClick,
                  ),

                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: this.onDeleteClick,
                  ),
                ]
            )
            ]
        ),

        Divider(),

        Padding(
          padding: EdgeInsets.only(top: 16, bottom: 16),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                LabelAndValue(
                    label: 'Quantidade:',
                    value: NumberFormat('0').format(product.quantity) + ' Un.',
                    light: false ),
                LabelAndValue(
                    label: 'Término Previsto:',
                    value: DateFormat('dd/MM/yyyy').format(product.endDateForecast),
                    light: false ),
              ]),
        ),

        LabelAndValue(
            label:'Código:',
            value: product.id.toString(),
            light: false ),
        LabelAndValue(
            label:'Gasto Semanal:',
            value: NumberFormat('0').format(product.weeklySpentMean) + ' Un.',
            light: false ),

        Row(
            children: <Widget>[
              Expanded(
                  child: LabelAndValue(
                    label:'Última atualização:',
                    value: DateFormat('dd/MM/yyyy').format(product.lastUpdate),
                    light: false ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.restore),
                    onPressed: this.onRestoreClick,
                  ),
                ],
              ),
          ]),

      ],
    );
  }
}


class CardCustom extends StatelessWidget{

  CardCustom({
    this.width: 200,
    this.height: 100,
    this.children,
    this.onTap
  });

  final double width;
  final double height;
  final List<Widget> children;

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
          padding: EdgeInsets.all(16),
            height: this.height,
            width: this.width,
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: this.onTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: this.children
              ),
            ),
        ),
    );
  }

}

class LabelAndValue extends StatelessWidget{
  LabelAndValue({this.label: '', this.value: '', this.light: true});

  final String label;
  final String value;
  final bool light;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 8),
          child: Text(
            this.label,
            style: TextStyle(
                fontSize: 16,
                color: Colors.black45,
                fontWeight: FontWeight.bold,
            ),
          ),
        ),

        Text(
          this.value,
          style: TextStyle( fontSize: 16, color: this.light ? Colors.black45 : Colors.black ),
        ),
      ],
    );
  }


}

class LabelFeatured extends StatelessWidget{

  LabelFeatured(this.icon, this.text, this.color);

  final IconData icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 16),
      child: Row(
        children: <Widget>[

          Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon( this.icon, color: this.color ),
          ),

          Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

}