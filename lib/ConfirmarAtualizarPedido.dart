import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tintex/MeusPedidos.dart.';
import 'package:tintex/RealizarPedido.dart';
import 'package:tintex/model/Pedido.dart';
import 'package:tintex/model/Produto.dart';
import 'package:tintex/model/SolicitarPedido.dart';
import 'package:tintex/model/Usuario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

import 'Home.dart';

class ConfirmarAtualizarPedido extends StatefulWidget {
  final SolicitarPedido solicitarPedido;
  final String idUsuario;
  final Produto produto;

  ConfirmarAtualizarPedido(this.solicitarPedido, this.idUsuario, this.produto);

  @override
  _ConfirmarAtualizarPedidoState createState() => _ConfirmarAtualizarPedidoState(solicitarPedido, idUsuario, produto);
}

class _ConfirmarAtualizarPedidoState extends State<ConfirmarAtualizarPedido> {
  final SolicitarPedido solicitarPedido;
  final String idUsuario;
  final Produto produto;
  Firestore db                = Firestore.instance;
  String _valorTotalDoPedido;
  String _qtdTotalPrd;

  String pathMassaPVA     = 'assets/saco_massa_pva.PNG';
  String pathMassaAcri    = 'assets/saco_massa_acrilica.PNG';
  String pathSela         = 'assets/selador.PNG';
  String pathGrafi        = 'assets/saco_grafiatto_rustico.PNG';
  String pathLatex        = 'assets/latex_eco.PNG';
  String pathTextura      = 'assets/saco_textura_acrilica.PNG';

  double _heigth = 60.0;
  double _width = 40.0;

  _ConfirmarAtualizarPedidoState(this.solicitarPedido, this.idUsuario, this.produto);

  valorTotalPedido(){
    double valorTotal;
    int qtdTotalPrd;
    valorTotal = double.parse(solicitarPedido.Textura_Acrilica)     * produto.Preco_Textura_Acrilica;
    valorTotal += double.parse(solicitarPedido.Grafiato_Acrilico)   * produto.Preco_Grafiato_Acrilico;
    valorTotal += double.parse(solicitarPedido.Latex_Economico)     * produto.Preco_Latex_Economico;
    valorTotal += double.parse(solicitarPedido.Massa_Acrilica)      * produto.Preco_Massa_Acrilica;
    valorTotal += double.parse(solicitarPedido.Massa_PVA)           * produto.Preco_Massa_PVA;
    valorTotal += double.parse(solicitarPedido.Selador_Acrilico)    * produto.Preco_Selador_Acrilico;

    qtdTotalPrd = int.parse(solicitarPedido.Textura_Acrilica) + int.parse(solicitarPedido.Grafiato_Acrilico) + int.parse(solicitarPedido.Latex_Economico) + int.parse(solicitarPedido.Massa_Acrilica) +
        int.parse(solicitarPedido.Massa_PVA) + int.parse(solicitarPedido.Selador_Acrilico);

    NumberFormat formatar = NumberFormat("00.00");
    this.valorTotalDoPedido = formatar.format(valorTotal);

    this.qtdTotalPrd = qtdTotalPrd.toString();
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    valorTotalPedido();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Atualização do Pedido"),
        ),
        body: Container(
            child: SingleChildScrollView(
                padding: EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      "Confirmação da atualização do Pedido",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        Text("Valor total do pedido: R\$ ${valorTotalDoPedido.toString()}"),
                        Text(""),
                        Text("QTD"),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image(
                          image: AssetImage(pathMassaAcri),
                          fit: BoxFit.cover,
                          height: _heigth,
                          width: _width,
                        ),
                        Text("Massa Acrílica:", textAlign: TextAlign.right,),
                        Text("${solicitarPedido.Massa_Acrilica}")
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image(
                          image: AssetImage(pathSela),
                          fit: BoxFit.cover,
                          height: _heigth,
                          width: _width,
                        ),
                        Text("Selador Acrílico: ", textAlign: TextAlign.right,),
                        Text("${solicitarPedido.Selador_Acrilico}")
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image(
                          image: AssetImage(pathGrafi),
                          fit: BoxFit.cover,
                          height: _heigth,
                          width: _width,
                        ),
                        Text("Grafiato Acrílico: ", textAlign: TextAlign.right,),
                        Text("${solicitarPedido.Grafiato_Acrilico}")
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image(
                          image: AssetImage(pathTextura),
                          fit: BoxFit.cover,
                          height: _heigth,
                          width: _width,
                        ),
                        Text("Textura Acrílica: ", textAlign: TextAlign.right,),
                        Text("${solicitarPedido.Textura_Acrilica}")
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image(
                          image: AssetImage(pathLatex),
                          fit: BoxFit.cover,
                          height: _heigth,
                          width: _width,
                        ),
                        Text("Latex Econômico: ", textAlign: TextAlign.right,),
                        Text("${solicitarPedido.Latex_Economico}")
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image(
                          image: AssetImage(pathMassaPVA),
                          fit: BoxFit.cover,
                          height: _heigth,
                          width: _width,
                        ),
                        Text("Latex Econômico: ", textAlign: TextAlign.right,),
                        Text("${solicitarPedido.Massa_PVA}")
                      ],
                    ),

                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        Text(""),
                        Text("Total itens:", textAlign: TextAlign.right, style: TextStyle(fontSize: 18),),
                        Text("${qtdTotalPrd}",style: TextStyle(fontSize: 18),),
                      ],
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: RaisedButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        padding: EdgeInsets.all(15),
                        child: Text(
                          "Atualizar Pedido",
                          style: TextStyle(
                              fontSize: 20
                          ),
                        ),
                        onPressed: (){
                          _validarCampos(solicitarPedido);
                        },
                      ),
                    ),

                      ],
                    ),

                )
            )
        );
  }


  _validarCampos(SolicitarPedido solicitarPedido) {
    solicitarPedido.qtd_total_itens = qtdTotalPrd;
    solicitarPedido.valor_total     = valorTotalDoPedido;

    solicitarPedido.alterarPedido(solicitarPedido);

    String numeroPedido = solicitarPedido.numero_Pedido;

    _showDialog(numeroPedido);


  }

  void _showDialog(numeroPedido) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Pedido " + numeroPedido + " alterado com sucesso."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
          new FlatButton(
              child: new Text("Listar Pedidos"),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      Home()));
              },

            ),
          ],
        );
      },
    );
  }






  String get valorTotalDoPedido => _valorTotalDoPedido;

  set valorTotalDoPedido(String value) {
    _valorTotalDoPedido = value;
  }

  String get qtdTotalPrd => _qtdTotalPrd;

  set qtdTotalPrd(String value) {
    _qtdTotalPrd = value;
  }
}
