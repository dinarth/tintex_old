import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:tintex/ConfirmarPedido.dart';
import 'package:tintex/model/Pedido.dart';
import 'package:tintex/model/Produto.dart';
import 'package:tintex/model/Usuario.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:scoped_model/scoped_model.dart';

import 'HomeFabrica.dart';


class CadastrarProduto extends StatefulWidget {
  @override
  _CadastrarProdutoState createState() => _CadastrarProdutoState();
}

class _CadastrarProdutoState extends State<CadastrarProduto> {
  TextEditingController nome_produto      = TextEditingController();
  TextEditingController preco_produto     = TextEditingController();
  final double _widthTextField            = 55;
  final double _heightTextField           = 30;

  Produto produto = Produto();
  Usuario  usuario              = new Usuario();



  int anoAtual = DateTime.now().year;

  String currencyConverse(String valorMoeda) {
    if (valorMoeda.length > 4) {
      valorMoeda = valorMoeda.replaceAll('.', '');
    }
    valorMoeda = valorMoeda.replaceAll(',', '.');
    return valorMoeda;
  }

  final format = DateFormat("dd/MM/yyyy");

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ScopedModelDescendant<Usuario>(
      builder: (context, child, model) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              //ROW 1
              children: [
                Container(
                  child: Text("Preço"),
                ),
                Container(
                  child: Text("Produto"),
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
                    child: new TextFormField(
                      inputFormatters:  <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 5,
                      decoration: new InputDecoration(
                        hintText: '0',
                        border: InputBorder.none,
                        counterText: '',
                      ),
                      controller: preco_produto,
                    ),
                  ),

                  new Container(
                    width: 300.0,
                    height: _heightTextField,
                    child: new TextFormField(
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.left,
                      decoration: new InputDecoration(
                        hintText: 'Nome do Produto',
                        border: InputBorder.none,

                      ),
                      controller: nome_produto,
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
                  "Cadastrar",
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
                onPressed: (){
                  _confirmarPedido();
                 // _validarCampos(model.firebaseUser.uid.toString());
                },
              ),
            ),
          ],


        );
      },
    ));
  }



  void _confirmarPedido() {
    produto.nome_produto          = nome_produto.text;
    produto.preco_produto         = preco_produto.text;
    produto.apresentar_registro   = '1';

    produto.cadastrarProduto(produto);

    _showDialog();


  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Produto cadastrado com sucesso."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Listar Pedidos"),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        HomeFabrica()));
              },

            ),
            new FlatButton(
              child: new Text("Cadastrar Produto"),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        CadastrarProduto()));
              },

            ),
          ],
        );
      },
    );
  }



}
