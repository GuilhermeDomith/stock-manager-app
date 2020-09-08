import 'package:flutter/material.dart';
import 'package:stock_manager_app/pages/dashboard_page.dart';
import 'package:stock_manager_app/pages/stock_page.dart';

import 'alerts_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: choices.length,
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: _tabBar(context),
        ),
        body: _body(),
      ),
    );
  }

  _tabBar(BuildContext context) {
    return TabBar(
      isScrollable: true,
      labelColor: Theme.of(context).primaryColorDark,
      unselectedLabelColor: Colors.black26,
      tabs: choices.map((Choice choice) =>
          Tab(
            text: choice.title,
            icon: Icon(choice.icon),
          )
      ).toList(),
    );
  }

  _body() {
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
  const Choice(page: DashboardPage.newInstance , title: 'INFOS', icon: Icons.dashboard),
  const Choice(page: StockPage.newInstance, title: 'PRODUTOS', icon: Icons.inbox),
  const Choice(page: StockAlertsPage.newInstance, title: 'ALERTAS', icon: Icons.new_releases),
];