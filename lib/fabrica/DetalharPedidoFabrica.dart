import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tintex/MeusPedidos.dart.';
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
  final SolicitarPedido solicitarPedido;
  String statusAlterado;
  Firestore db = Firestore.instance;

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
          title: Text("Tintex"),
        ),
        body: Container(
            child: SingleChildScrollView(
                padding: EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      "Detalhamento do Pedido XX",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
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
      return "Iniciar Produção.";
    }else{
      this.statusAlterado = 'FINALIZADO';
      return "Finalizar Produção.";
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
