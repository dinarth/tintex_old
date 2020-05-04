import 'package:tintex/fabrica/CadastrarProduto.dart';
import 'package:tintex/fabrica/ListarProdutos.dart';
import 'package:tintex/fabrica/PedidosEmProducao.dart';
import 'package:tintex/fabrica/PedidosPendentes.dart';
import 'package:tintex/login_screen.dart';
import 'package:tintex/model/Usuario.dart';
import 'package:tintex/widget/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:tintex/RealizarPedido.dart';
import 'package:tintex/widget/custom_drawer_fabrica.dart';
import 'PedidosFinalizados.dart';
import 'PedidosPendentes.dart';

import 'package:scoped_model/scoped_model.dart';

import 'package:tintex/model/Pedido.dart';

class HomeFabrica extends StatefulWidget {
  @override
  _HomeFabricaState createState() => _HomeFabricaState();

}

class _HomeFabricaState extends State<HomeFabrica> with SingleTickerProviderStateMixin {
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
              title: Text('Pedidos Pendentes'),
              ),
              body: PedidosPendentes(),
              drawer: CustomDrawerFabrica(_pageController),

            ),
            Scaffold(
              appBar: AppBar(
                title: Text('Pedidos em Produção'),
                centerTitle: true,
              ),
              drawer: CustomDrawerFabrica(_pageController),
              body:PedidosEmProducao(),
            ),
            Scaffold(
              appBar: AppBar(
                title: Text('Pedidos Finalizados'),
                centerTitle: true,
              ),
              drawer: CustomDrawerFabrica(_pageController),
              body:PedidosFinalizados(),
            ),
            Scaffold(
              appBar: AppBar(
                title: Text('Listar Produtos'),
                centerTitle: true,
              ),
              drawer: CustomDrawerFabrica(_pageController),
              body:ListarProdutos(),
            ),

            Scaffold(
              appBar: AppBar(
                title: Text('Cadastrar Produto'),
                centerTitle: true,
              ),
              drawer: CustomDrawerFabrica(_pageController),
              body: CadastrarProduto(),
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
