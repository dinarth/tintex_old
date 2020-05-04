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

import 'HomeFabrica.dart';

class ConfirmarAtualizarPedidoFabrica extends StatefulWidget {
  final SolicitarPedido solicitarPedido;
  final String idUsuario;


  ConfirmarAtualizarPedidoFabrica(this.solicitarPedido, this.idUsuario);

  @override
  _ConfirmarAtualizarPedidoFabricaState createState() => _ConfirmarAtualizarPedidoFabricaState(solicitarPedido, idUsuario);
}

class _ConfirmarAtualizarPedidoFabricaState extends State<ConfirmarAtualizarPedidoFabrica> {
  final SolicitarPedido solicitarPedido;
  final String idUsuario;
  Firestore db                = Firestore.instance;
  Produto produto             = new Produto();
  String _valorTotalDoPedido;



  String get valorTotalDoPedido => _valorTotalDoPedido;

  set valorTotalDoPedido(String value) {
    _valorTotalDoPedido = value;
  }

  _ConfirmarAtualizarPedidoFabricaState(this.solicitarPedido, this.idUsuario);

  valorTotalPedido(){
    double valorTotal;
    valorTotal = double.parse(solicitarPedido.Textura_Acrilica)     * produto.Preco_Textura_Acrilica;
    valorTotal += double.parse(solicitarPedido.Grafiato_Acrilico)   * produto.Preco_Grafiato_Acrilico;
    valorTotal += double.parse(solicitarPedido.Latex_Economico)     * produto.Preco_Latex_Economico;
    valorTotal += double.parse(solicitarPedido.Massa_Acrilica)      * produto.Preco_Massa_Acrilica;
    valorTotal += double.parse(solicitarPedido.Massa_PVA)           * produto.Preco_Massa_PVA;

    NumberFormat formatar = NumberFormat("00.00");
    this.valorTotalDoPedido = formatar.format(valorTotal);


  }


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

  //===============================NOTIFICAÇÃO==========================//
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid;
  var initializationSettingsIOS;
  var initializationSettings;

  void _showNotification() async{
    await _demoNotification();
  }
  Future<void> _demoNotification() async{
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel_ID', 'channel name', 'channel description',
      importance:  Importance.Max,
      priority: Priority.High,
      ticker: 'test ticker');

    var IOSChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, IOSChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(0, 'Vai dar o caLOTE?',
    'O dia do pagamento do seu lote está proximo', platformChannelSpecifics,
    payload: 'test oayload');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializationSettingsAndroid = new AndroidInitializationSettings('icone_app');
    initializationSettingsIOS = new IOSInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = new InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
    onSelectNotification: onSelectNotification);


    valorTotalPedido();
  }
  Future onSelectNotification(String payload) async{
    if(payload != null){
      debugPrint('Notification payload: $payload');
    }
    await Navigator.push(context,
    new MaterialPageRoute(builder: (context) => new MeusPedidos()));
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
          title: Text("Confirmar Pedido"),
        ),
        body: Container(
            child: SingleChildScrollView(
                padding: EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      "Confirmação do Pedido",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Valor total do pedido:"),
                        Text("${valorTotalDoPedido.toString()}")
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Massa Acrílica:"),
                        Text("${solicitarPedido.Massa_Acrilica}")
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Selador Acrílico: "),
                        Text("${solicitarPedido.Selador_Acrilico}")
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Grafiato Acrílico: "),
                        Text("${solicitarPedido.Grafiato_Acrilico}")
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Textura Acrílica: "),
                        Text("${solicitarPedido.Textura_Acrilica}")
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Latex Econômico: "),
                        Text("${solicitarPedido.Latex_Economico}")
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
                          "Confirmar Pedido",
                          style: TextStyle(
                              fontSize: 20
                          ),
                        ),
                        onPressed: (){
                          _validarCampos(idUsuario);
                        },
                      ),
                    ),

                      ],
                    ),

                )
            )
        );
  }


  _validarCampos(String idUsuarioLogado) {

    solicitarPedido.alterarPedido(solicitarPedido);

    _showDialog(idUsuarioLogado, solicitarPedido.numero_Pedido);


  }

  void _showDialog(idUsuarioLogado, idPedido) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Pedido " + idPedido + " alterado com sucesso."),
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
          ],
        );
      },
    );
  }



}
