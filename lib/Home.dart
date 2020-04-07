import 'package:tintex/login_screen.dart';
import 'package:tintex/model/Usuario.dart';
import 'package:tintex/widget/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:tintex/RealizarPedido.dart';
import 'package:tintex/MeusPedidos.dart';

import 'package:scoped_model/scoped_model.dart';

import 'model/Pedido.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final _pageController = PageController();
  Usuario usuario = new Usuario();
  TabController _tabController;
  String titulo = "Tintex";



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<Usuario>(
      builder: (context, child, model) {
        if (model.isLoading)
          return Center(
            child: CircularProgressIndicator(),
          );
        return PageView(
          controller: _pageController,
          children: <Widget>[
            Scaffold(

              appBar: AppBar(
              centerTitle: true,
              title: Text(titulo),
              ),
              body: MeusPedidos(),
              drawer: CustomDrawer(_pageController),
              floatingActionButton: FloatingActionButton(
              onPressed: _sair,
              ),
            ),
            Scaffold(
              appBar: AppBar(
                title: Text(titulo),
                centerTitle: true,
              ),
              drawer: CustomDrawer(_pageController),
              body:RealizarPedido(),
            ),
        ],
        );
      },

    );
  }

  void _sair() {
    Usuario usuario = new Usuario();
    usuario.signOut();

    Future.delayed(Duration(milliseconds: 0)).then((_) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }
}
