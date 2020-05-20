import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tintex/RealizarPedido.dart';
import 'package:tintex/model/SolicitarPedido.dart';
import 'package:tintex/model/Usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:tintex/util/StatusPedido.dart';
import 'AtualizarPedido.dart';
import 'model/Pedido.dart';
import 'DetalharPedido.dart';

class MeusPedidos extends StatefulWidget {
  @override
  _MeusPedidosState createState() => _MeusPedidosState();
}

class _MeusPedidosState extends State<MeusPedidos> {
  Usuario usuario = new Usuario();
  List<Pedido> _pedidos = List();
  final _controller = StreamController<QuerySnapshot>.broadcast();
  Firestore db = Firestore.instance;
  Future<String> idUsuario;
  String idUsuarioLogado;


  RealizarPedido realizarPedido = RealizarPedido();

  FirebaseUser firebaseUser;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<QuerySnapshot> _recuperarListenerPedidos() {
    final stream = db
        .collection("pedidosSis")
        .where('cliente.idUsuario', isEqualTo: idUsuarioLogado)
        .where("apresentar_registro", isEqualTo: '1')
        .snapshots();

    stream.listen((dados) {
      _controller.add(dados);
    });
  }



  @override
  void initState() {
    super.initState();

    idUsuario = usuario.retornarUid();
    idUsuario.then((id){
      this.idUsuarioLogado = id;

      _recuperarListenerPedidos();
    });

//  _recuperarListenerPedidos();

  }

 // @override
 // Widget build(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _controller.stream,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: Column(
                children: <Widget>[
                  Text("Carregando pedidos"),
                  CircularProgressIndicator()
                ],
              ),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Text("Erro ao carregar pedidos.");
            } else {
              QuerySnapshot querySnapshot = snapshot.data;
              if (querySnapshot.documents.length == 0) {
                return Center(
                  child: Text(
                    "Você não possui pedido(s) cadastrado(s).",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                );
              } //chave do IF

              return  ListView.builder(
                      itemCount: querySnapshot.documents.length,
                      itemBuilder: (context, index) {
                        List<DocumentSnapshot> pedidos =
                            querySnapshot.documents.toList();
                        DocumentSnapshot item = pedidos[index];

                        SolicitarPedido solicitarPedido = new SolicitarPedido();
                        solicitarPedido.Massa_PVA           = item['massa_pva'];
                        solicitarPedido.Massa_Acrilica      = item['massa_acrilica'];
                        solicitarPedido.Selador_Acrilico    = item['selador_acrilico'];
                        solicitarPedido.Latex_Economico     = item['latex_economico'];
                        solicitarPedido.Grafiato_Acrilico   = item['grafiato_acrilico'];
                        solicitarPedido.Textura_Acrilica    = item['textura_acrilica'];
                        solicitarPedido.apresentarRegistro  = item['apresentar_registro'];
                        solicitarPedido.data_pedido         = item['data_pedido'];
                        solicitarPedido.data_atualizacao    = item['data_atualizacao'];
                        solicitarPedido.numero_Pedido       = item['numero_pedido'];
                        solicitarPedido.status              = item['status'];
                        solicitarPedido.qtd_total_itens     = item['qtd_total_itens'];
                        solicitarPedido.valor_total         = item['valor_total'];
                        solicitarPedido.id                  = item.documentID;

                        String statusLegivel;
                        if(solicitarPedido.status == StatusPedido.ENVIADO)
                          statusLegivel = 'Enviado';
                        else if(solicitarPedido.status == StatusPedido.PRODUCAO)
                          statusLegivel = 'Em Produção';
                        else if(solicitarPedido.status == StatusPedido.FINALIZADO)
                          statusLegivel = 'Finalizado';

                        return  Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      DetalharPedido(solicitarPedido)));
                            },
                            title: Text("Pedido ${solicitarPedido.numero_Pedido} "),
                            subtitle: Text(
                                'Status:  ${statusLegivel} - Solicitação: ${solicitarPedido.data_pedido}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) =>
                                            AtualizarPedido(solicitarPedido, idUsuarioLogado)));

                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 0),
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),

                                GestureDetector(
                                  onTap: () {
                                    if(solicitarPedido.status == StatusPedido.ENVIADO) {
                                      _showDialog(
                                          solicitarPedido.numero_Pedido);
                                    }else{
                                      _showError(
                                          solicitarPedido.numero_Pedido);

                                    }
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 0),
                                    child: Icon(
                                      Icons.delete_forever,
                                      color: Colors.red,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });


            }
        }
      },
    );

  }

  void _showError(numero_Pedido) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Seu pedido já se encontra em Produção ou Finalizado, não é possível deletá-lo."),
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

  void _showDialog(numero_Pedido) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Deseja realmente excluir o pedido ${numero_Pedido}?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Sim"),
              onPressed: (){
                _removerPedido(numero_Pedido);
                Navigator.of(context).pop();
              },

            ),
            new FlatButton(
              child: new Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },

            ),
          ],
        );
      },
    );
  }

  void _removerPedido(String numero_Pedido) {
    SolicitarPedido solicitarPedido = SolicitarPedido();

    solicitarPedido.excluirPedido(numero_Pedido);


  }




}
