import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tintex/MeusPedidos.dart.';
import 'package:tintex/helper/Formatador.dart';
import 'package:tintex/model/Pedido.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

import 'model/SolicitarPedido.dart';

class DetalharPedido extends StatefulWidget {
  final SolicitarPedido solicitarPedido;



  DetalharPedido(this.solicitarPedido);

  @override
  _DetalharPedidoState createState() => _DetalharPedidoState(solicitarPedido);
}

class _DetalharPedidoState extends State<DetalharPedido> {
  Formatador formatador = Formatador();
  final SolicitarPedido solicitarPedido;
  Firestore db = Firestore.instance;


  String pathMassaPVA     = 'assets/saco_massa_pva.PNG';
  String pathMassaAcri    = 'assets/saco_massa_acrilica.PNG';
  String pathSela         = 'assets/selador.PNG';
  String pathGrafi        = 'assets/saco_grafiatto_rustico.PNG';
  String pathLatex        = 'assets/latex_eco.PNG';
  String pathTextura      = 'assets/saco_textura_acrilica.PNG';

  double _heigth = 60.0;
  double _width = 40.0;

  _DetalharPedidoState(this.solicitarPedido);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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
              padding: EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 12.0,
                  ),
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


                ],
              ),

            )
        )
        );
  }


}
