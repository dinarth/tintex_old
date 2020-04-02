import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tintex/model/Usuario.dart';

class Pedido{

  String _id;
  String _Massa_Acrilica;
  String _Selador_Acrilico;
  String _Massa_PVA;
  String _Textura_Acrilica;
  String _Latex_Economico;
  String _Grafiato_Acrilico;
  String _apresentarRegistro;


  Firestore db                  = Firestore.instance;
//  String idUsuarioLogado        = 'LniQVMDb1bRvDVetHaHt5c5VhiB2';
  Usuario usuario = new Usuario();

  final _controller             = StreamController<QuerySnapshot>.broadcast();



  Pedido(Massa_Acrilica, Selador_Acrilico,Massa_PVA, Textura_Acrilica, Latex_Economico, Grafiato_Acrilico, apresentarRegistro){
    this.selador_Acrilico                     = Selador_Acrilico;
    this.massa_PVA                            = Massa_PVA;
    this.massa_Acrilica                       = Massa_Acrilica;
    this.grafiato_Acrilico                    = Grafiato_Acrilico;
    this.textura_Acrilica                     = Textura_Acrilica;
    this.latex_Economico                      = Latex_Economico;
    this.apresentarRegistro                   = apresentarRegistro;
  }

  Map<String, dynamic> toMap(){

    Map<String, dynamic> map = {
      "massa_Acrilica"      : this.massa_Acrilica,
      "selador_Acrilico"    : this.selador_Acrilico,
      "massa_PVA"           : this.massa_PVA,
      "textura_Acrilica"    : this.textura_Acrilica,
      "latex_Economico"     : this.latex_Economico,
      "grafiato_Acrilico"   : this.grafiato_Acrilico,
      "apresentarRegistro"  : this.apresentarRegistro
    };

    return map;
  }


  void cadastrarPedido( Pedido pedido, idUsuarioLogado){
    //Salvar terreno
    Firestore db = Firestore.instance;

    db.collection("pedidos")
        .document(idUsuarioLogado)
        .collection("pedido")
        .document()
        .setData(pedido.toMap());
  }

  void excluirPedido(idUsuarioLogado, idPedido){
    Firestore db = Firestore.instance;

    db.collection("pedidos")
        .document(idUsuarioLogado)
        .collection("pedido")
        .document(idPedido)
        .updateData({
      "apresentarRegistro" : '0'
    });
  }

  void alterarPedido(Pedido pedido, idUsuarioLogado, idPedido){
    Firestore db = Firestore.instance;

    db.collection("pedidos")
        .document(idUsuarioLogado)
        .collection("pedido")
        .document(idPedido)
        .updateData(pedido.toMap());

  }


  String get id => _id;

  set id(String value) {
    _id = value;
  }


  String get massa_Acrilica => _Massa_Acrilica;

  set massa_Acrilica(String value) {
    _Massa_Acrilica = value;
  }

  String get selador_Acrilico => _Selador_Acrilico;

  set selador_Acrilico(String value) {
    _Selador_Acrilico = value;
  }

  String get massa_PVA => _Massa_PVA;

  set massa_PVA(String value) {
    _Massa_PVA = value;
  }

  String get textura_Acrilica => _Textura_Acrilica;

  set textura_Acrilica(String value) {
    _Textura_Acrilica = value;
  }

  String get latex_Economico => _Latex_Economico;

  set latex_Economico(String value) {
    _Latex_Economico = value;
  }

  String get grafiato_Acrilico => _Grafiato_Acrilico;

  set grafiato_Acrilico(String value) {
    _Grafiato_Acrilico = value;
  }



  String get apresentarRegistro => _apresentarRegistro;

  set apresentarRegistro(String value) {
    _apresentarRegistro = value;
  }
}