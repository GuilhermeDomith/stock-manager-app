import 'package:flutter/material.dart';
import 'package:stock_manager_app/stock_page.dart';

import 'alerts_page.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: choices.length,
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: ChoicesTabBar(),
        ),
        body: ChoicesTabBarView(),
      ),
    );
  }
}

class ChoicesTabBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: true,
      labelColor: Theme.of(context).primaryColorDark,
      tabs: choices.map((Choice choice) =>
          Tab(
            text: choice.title,
            icon: Icon(choice.icon,
              color: Theme.of(context).primaryColorDark,
            ),
          )
      ).toList(),
    );
  }
}

class ChoicesTabBarView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: choices.map((Choice choice) =>
        choice.page(choice)
      ).toList(),
    );
  }

}

class Choice{
  const Choice ({this.page, this.title, this.icon});

  final Widget Function(Choice) page;
  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(page: StockPage.newInstance , title: 'ADD', icon: Icons.add_box),
  const Choice(page: StockPage.newInstance, title: 'STOCK', icon: Icons.inbox),
  const Choice(page: StockAlertsPage.newInstance, title: 'ALERTS', icon: Icons.new_releases),
  const Choice(page: StockPage.newInstance, title: 'STOCK', icon: Icons.inbox),
  const Choice(page: StockPage.newInstance, title: 'STOCK', icon: Icons.inbox),
  const Choice(page: StockPage.newInstance, title: 'STOCK', icon: Icons.inbox),
];