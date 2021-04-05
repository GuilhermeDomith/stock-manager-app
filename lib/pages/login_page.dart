import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:stock_manager_app/blocs/login_bloc.dart';
import 'package:stock_manager_app/components/alerts.dart';
import 'package:stock_manager_app/components/card_input_text.dart';
import 'package:stock_manager_app/pages/home_page.dart';

class LoginPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _LoginPage();
}


/// Screen that shows input username and password in a tab cards mode.
/// This class mixin SingleTickerProviderStateMixin to possible use TabControler
/// vsync property.
class _LoginPage extends State<LoginPage> with SingleTickerProviderStateMixin {

  final int lengthTabs = 2;
  LoginBloc loginBloc;
  TabController _tabController;
  TextEditingController usernameCtrl;
  TextEditingController passwordCtrl;

  @override
  void initState() {
    super.initState();
    this.loginBloc = LoginBloc();
    this.usernameCtrl = TextEditingController(text: "guilhermedomith@gmail.com");
    this.passwordCtrl = TextEditingController(text: "123456");
    this._tabController = TabController(vsync: this, length: this.lengthTabs);
  }

  @override
  void dispose() {
    _tabController.dispose();
    usernameCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: this.lengthTabs,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          children: <Widget> [

            Container(
                padding: EdgeInsets.only(top: 100),
                height: 230,
                child: Image.asset("assets/images/logo.png"),
            ),

            Expanded(
              child: _LoginTabView(
                controller: this._tabController,
                usernameController: this.usernameCtrl,
                passwordController: this.passwordCtrl,
                onSubmit: () => this.submit(context),
              )
            ),
          ],
        ),
      ),
    );
  }


  void submit(BuildContext context) {
    var success = this.loginBloc.login(
        this.usernameCtrl.text,
        this.passwordCtrl.text);
    
    if (success) {
      AppAlerts.showToast(context, "Login realizado com sucesso!");
      this.goToSuccessScreen();
    } else {
      AppAlerts.showToast(context, "Usuário ou senha inválidos");
      this.goToFirstTab();
    }
  }

  void goToFirstTab() {
    this._tabController.animateTo(0);
  }

  void goToSuccessScreen() {
    setState(() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage()
        ),
      );
    });
  }
}

class _LoginTabView extends StatelessWidget {

  _LoginTabView({
    this.controller,
    this.usernameController,
    this.passwordController,
    this.onSubmit
  }) : super();

  TabController controller;
  TextEditingController usernameController;
  TextEditingController passwordController;
  Function onSubmit;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: this.controller,
      children: <Widget> [

        CardInputText(
          label: "Email",
          controller: this.usernameController,
          onComplete: () => this.controller.animateTo(1),
        ),

        CardInputText(
          label: "Senha",
          controller: this.passwordController,
          onComplete: this.onSubmit,
        )

      ],
    );
  }
}
