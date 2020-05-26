import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tintex/MeusPedidos.dart.';
import 'package:tintex/helper/Formatador.dart';
import 'package:tintex/model/Pedido.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:tintex/model/SolicitarPedido.dart';
import 'package:tintex/util/StatusPedido.dart';

import 'HomeFabrica.dart';

class DetalharPedidoFabrica extends StatefulWidget {
  final SolicitarPedido solicitarPedido;

  DetalharPedidoFabrica(this.solicitarPedido);

  @override
  _DetalharPedidoFabricaState createState() => _DetalharPedidoFabricaState(solicitarPedido);
}

class _DetalharPedidoFabricaState extends State<DetalharPedidoFabrica> {
  Formatador formatador = Formatador();
  final SolicitarPedido solicitarPedido;
  String statusAlterado;
  Firestore db = Firestore.instance;

  String pathMassaPVA     = 'assets/saco_massa_pva.PNG';
  String pathMassaAcri    = 'assets/saco_massa_acrilica.PNG';
  String pathSela         = 'assets/selador.PNG';
  String pathGrafi        = 'assets/saco_grafiatto_rustico.PNG';
  String pathLatex        = 'assets/latex_eco.PNG';
  String pathTextura      = 'assets/saco_textura_acrilica.PNG';

  double _heigth = 60.0;
  double _width = 40.0;


  _DetalharPedidoFabricaState(this.solicitarPedido);


  int mandar_push(data_do_pagamento){
    var now = new DateTime.now();
    List<String> dia_pagamento = data_do_pagamento.split("/");
    //String dia_atual = now.day.toString();
    if(int.parse(dia_pagamento[0]) - now.day == 1){
      return 1;
    }
    else{
      return 99;
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }


  Future onDidReceiveLocalNotification(int id, String title, String body, String payload) async{
    await showDialog(
      context: context,
      builder: (BuildContext context)=>CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async{
          Navigator.of(context, rootNavigator:true).pop();
          await Navigator.push(context,
           MaterialPageRoute(builder: (context)=>MeusPedidos()));
            },
          )
        ],
      )
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Detalhar Pedido"),
        ),
        body: Container(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[


                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      Text("Valor total do pedido: R\$ ${formatador.currencyConverse(solicitarPedido.valor_total)}"),
                      Text(""),
                      Text("QTD"),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image(
                        image: AssetImage(this.pathMassaAcri),
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
                      Text("${solicitarPedido.qtd_total_itens}",style: TextStyle(fontSize: 18),),
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
                        textoBotao(),
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

  textoBotao(){
    if(solicitarPedido.status == StatusPedido.ENVIADO){
      this.statusAlterado = 'Em Produção';
      return "Iniciar Produção";
    }else{
      this.statusAlterado = 'FINALIZADO';
      return "Finalizar Produção";
    }
  }


  _validarCampos(SolicitarPedido solicitarPedido) {

    if(solicitarPedido.status == StatusPedido.ENVIADO){
      solicitarPedido.status  = StatusPedido.PRODUCAO;
    }else{
      solicitarPedido.status  = StatusPedido.FINALIZADO;
    }

    solicitarPedido.alterarPedido(solicitarPedido);

    _showDialog(solicitarPedido);
  }

  void _showDialog(SolicitarPedido solicitarPedido) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Status alterado para: " + this.statusAlterado + "."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Listar Pedidos Pendentes"),
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
