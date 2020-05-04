import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tintex/model/Usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
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
      print(id);
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



                        String Massa_PVA                    = item['massa_pva'];
                        String Massa_Acrilica               = item['massa_acrilica'];
                        String Selador_Acrilico             = item['selador_acrilico'];
                        String Latex_Economico              = item['latex_economico'];
                        String Grafiato_Acrilico            = item['grafiato_acrilico'];
                        String Textura_Acrilica             = item['textura_acrilica'];
                        String apresentarRegistro           = item['apresentar_registro'];
                        String dataPedido                   = item['data_pedido'];
                        String numeroPedido                 = item['numero_pedido'];
                        String idPedido                     = item.documentID;


                        if(dataPedido == null || dataPedido.isEmpty){
                          dataPedido      = "01/01/1900";
                        }

                        Pedido pedido = new Pedido(
                            Massa_Acrilica,
                            Selador_Acrilico,
                            Massa_PVA,
                            Textura_Acrilica,
                            Latex_Economico,
                            Grafiato_Acrilico,
                            apresentarRegistro,
                            numeroPedido,
                            idPedido);


                        return  Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      DetalharPedido(pedido)));
                            },
                            title: Text("Pedido número ${numeroPedido} - " + "Data: " + dataPedido),
                            subtitle: Text(
                                '${(pedido.grafiato_Acrilico)} - ${pedido.massa_PVA}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) =>
                                            AtualizarPedido(pedido, idPedido, idUsuarioLogado)));

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
                                    _showDialog(idUsuarioLogado, idPedido);
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


  void _showDialog(idUsuarioLogado, idPedido) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Deseja realmente excluir o pedido?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Sim"),
              onPressed: (){
                _removerPedido(idUsuarioLogado, idPedido);
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

  void _removerPedido(String idUsuarioLogado, String idPedido) {

    String Massa_PVA          = '';
    String Massa_Acrilica     = '';
    String Selador_Acrilico   = '';
    String Latex_Economico    = '';
    String Grafiato_Acrilico  = '';
    String Textura_Acrilica   = '';
    String apresentarRegistro = '';

    //criando objeto Pedido
    Pedido pedido = Pedido(
        Massa_Acrilica,
        Selador_Acrilico,
        Massa_PVA,
        Textura_Acrilica,
        Latex_Economico,
        Grafiato_Acrilico,
        apresentarRegistro);


    pedido.excluirPedido(idUsuarioLogado, idPedido);


  }




}
