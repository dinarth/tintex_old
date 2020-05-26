import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tintex/fabrica/ListarProdutos.dart';
import 'package:tintex/model/Pedido.dart';
import 'package:tintex/model/Produto.dart';
import 'package:tintex/model/SolicitarPedido.dart';
import 'package:tintex/model/Usuario.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';

import 'ConfirmarAtualizarPedidoFabrica.dart';
//import 'confir';

class AlterarProduto extends StatefulWidget {
  final Produto produto;

  AlterarProduto(this.produto);

  @override
  State <AlterarProduto> createState() {
    return _AlterarProdutoState(produto);
  }
}

class _AlterarProdutoState extends State<AlterarProduto> {

  final Produto produto;
  Firestore db = Firestore.instance;
  int anoAtual = DateTime.now().year;
  TextEditingController _nome_produto    = TextEditingController();
  TextEditingController _preco_produto   = TextEditingController();
  String label;



  final double _widthTextField                   = 55;
  final double _heightTextField                  = 30;

  _AlterarProdutoState(this.produto): super();

  void _carregarCampos(){

    _nome_produto.text                = produto.nome_produto;
    _preco_produto.text               = produto.preco_produto;
  }

  @override
  void initState() {
    super.initState();

      _carregarCampos();
  }

  final format = DateFormat("dd/MM/yyyy");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Atualizar Produto"),
          centerTitle: true,
        ),
        body: ScopedModelDescendant<Usuario>(

      builder: (context, child, model) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              //ROW 1
              children: [
                Container(
                  child: Text("QTD"),
                ),
                Container(
                  child: Text("Descriminação"),
                ),
              ],
            ),
            Row(//ROW 2
                children: [
                  new Container(
                    width: _widthTextField,
                    height: _heightTextField,
                    decoration: new BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: new Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    child: new TextField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: new InputDecoration(
                        border: InputBorder.none,
                      ),
                      controller: _preco_produto,
                    ),
                  ),

                  Container(
                    width: 300.0,
                    height: _heightTextField,
                    child: new TextField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: new InputDecoration(
                        border: InputBorder.none,
                      ),
                      controller: _nome_produto,
                    ),
                  ),
                ]),

            Padding(
              padding: EdgeInsets.only(top: 10),
              child: RaisedButton(
                color: Colors.blue,
                textColor: Colors.white,
                padding: EdgeInsets.all(15),
                child: Text(
                  "Atualizar Produto",
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
                onPressed: (){
                  print(produto.id);
                  print(produto.nome_produto);
                  print(produto.preco_produto);
                  print(_preco_produto.text);
                  confirmarAtualizarProduto();

                  // _validarCampos(model.firebaseUser.uid.toString());
                },
              ),
            ),
          ],


        );
      },
    ));
  }


  void confirmarAtualizarProduto() {
    if(produto.preco_produto != _preco_produto.text) {
      produto.apresentar_registro = '1';
      produto.preco_produto = _preco_produto.text;
      produto.atualizarProduto(produto);
      _showDialog();
    }else{
      _showDialogErro();
    }

  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Preço alterado com sucesso."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },

            ),
          ],
        );
      },
    );
  }


  void _showDialogErro() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Não houve alteração do preço. Favor confirmar."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },

            ),
          ],
        );
      },
    );
  }


}
