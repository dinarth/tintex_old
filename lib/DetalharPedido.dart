import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tintex/MeusPedidos.dart';
import 'package:tintex/model/Pedido.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

class DetalharPedido extends StatefulWidget {
  final Pedido terreno;

  DetalharPedido(this.terreno);

  @override
  _DetalharPedidoState createState() => _DetalharPedidoState(terreno);
}

class _DetalharPedidoState extends State<DetalharPedido> {
  final Pedido terreno;
  Firestore db = Firestore.instance;

  _DetalharPedidoState(this.terreno);


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
                        Text("${terreno.massa_Acrilica}")
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Selador Acrílico: "),
                        Text("${terreno.selador_Acrilico}")
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Grafiato Acrílico: "),
                        Text("${terreno.grafiato_Acrilico}")
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Textura Acrílica: "),
                        Text("${terreno.textura_Acrilica}")
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Latex Econômico: "),
                        Text("${terreno.latex_Economico}")
                      ],
                    ),

                    Divider(),
                    RaisedButton(
                      child: Text('notificação'),
                      //onPressed: _showNotification,
                    ),

                      ],
                    ),

                )
            )
        );
  }




  String _buildTerrenoText(DocumentSnapshot snapshot) {
    String text = "Título: \n";
    for (DocumentSnapshot t in snapshot.data['titulo']) {
      text += "${t['titulo']}";
    }
    text += "Parcela: R\$ ${snapshot.data['vlParcela'].toStringAsFixed(2)}";
    return text;
  }

  String _buildTerrenoText2(DocumentSnapshot snapshot) {
    String text = "Título: \n";
    for (LinkedHashMap t in snapshot.data['terreno']) {
      text += "${t['titulo']}";
    }
    text += "Parcela: R\$ ${snapshot.data['vlParcela'].toStringAsFixed(2)}";
    return text;
  }
}
