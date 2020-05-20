import 'dart:async';
import 'dart:collection';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tintex/MeusPedidos.dart.';
import 'package:tintex/fabrica/AlterarProduto.dart';
import 'package:tintex/model/Pedido.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:tintex/model/Produto.dart';
import 'package:tintex/model/SolicitarPedido.dart';
import 'package:tintex/util/StatusPedido.dart';

import 'HomeFabrica.dart';

class ListarProdutos extends StatefulWidget {

  ListarProdutos();

  @override
  _ListarProdutosState createState() => _ListarProdutosState();
}

class _ListarProdutosState extends State<ListarProdutos> {
  final _controller = StreamController<QuerySnapshot>.broadcast();
  Firestore db = Firestore.instance;

  Produto produto = Produto();


  _ListarProdutosState();

  Stream<QuerySnapshot> _recuperarListenerProdutos() {
    final stream = db
        .collection("produtos")
        .where("apresentar_registro", isEqualTo: '1')
        .snapshots();

    stream.listen((dados) {
      _controller.add(dados);
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _recuperarListenerProdutos();

  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _controller.stream,
      builder: (context, snapshot){
        switch(snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: Column(
                children: <Widget>[
                  Text("Carregando Produtos..."),
                  CircularProgressIndicator()
                ],
              ),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Text("Erro ao carregar produtos.");
            } else {
              QuerySnapshot querySnapshot = snapshot.data;
              if (querySnapshot.documents.length == 0) {
                return Center(
                  child: Text(
                    "Você não possui produto(s) cadastrado(s).",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                );
              } //chave do IF
              return ListView.builder(
                  itemCount: querySnapshot.documents.length,
                  itemBuilder: (context, index) {
                    List<DocumentSnapshot> produtos =
                    querySnapshot.documents.toList();
                    DocumentSnapshot item = produtos[index];

                    Produto produto = Produto();
                    produto.nome_produto       = item['nome_produto'];
                    produto.preco_produto      = item['preco_produto'];
                    produto.label              = item['label'];
                    produto.id                 = item.documentID;

                    return Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  AlterarProduto(produto)));
                        },
                        title: Text("Produto: ${produto.nome_produto} "),
                        subtitle: Text("Preço ${produto.preco_produto}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                _showDialog(produto);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: 0),

                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
              );
            }
        }});

      }


  void _showDialog(Produto produto) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Excluir?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Sim"),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        HomeFabrica()));
              },

            ),
          ],
        );
      },
    );
  }


}
