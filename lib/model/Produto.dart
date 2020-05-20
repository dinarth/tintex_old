import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Produto{
  double _Preco_Massa_Acrilica;
  double _Preco_Selador_Acrilico;
  double _Preco_Massa_PVA;
  double _Preco_Textura_Acrilica;
  double _Preco_Latex_Economico;
  double _Preco_Grafiato_Acrilico;

  String _id;
  String _nome_produto;
  String _preco_produto;
  String _apresentar_registro;
  String _label;

  Produto(){}

  Map<String, dynamic> toMap(){

    Map<String, dynamic> map = {
      'nome_produto' : this.nome_produto,
      'preco_produto': this.preco_produto,
      'apresentar_registro': this.apresentar_registro,
    };

    return map;

  }

  Map<String, dynamic> toMapAtualizarPrd(){
    Map<String, dynamic> map = {
      'preco_produto'      : this.preco_produto,
      'nome_produto'       : this.nome_produto,
      'label'              : this.label,
      'apresentar_registro': this.apresentar_registro,
    };
    return map;
  }

  void atualizarProduto(Produto produto){
    Firestore db = Firestore.instance;
    db.collection('produtos')
      .document(produto.id)
      .updateData(
      toMapAtualizarPrd()
      );
  }


  void cadastrarProduto(Produto produto){
    Firestore db = Firestore.instance;
    db.collection("produtos")
        .add(produto.toMap());

  }

  getOneResult() async{
    return await Firestore.instance
        .collection('produtos')
        .getDocuments();
  }


  getMassaPVA(label){
    return Firestore.instance
        .collection('produtos')
    .where('label', isEqualTo: label)
        .getDocuments();
  }




//  String recuperarProduto (label){
//    Firestore db = Firestore.instance;
//        db.collection('produtos')
//        .where('label', isEqualTo: label)
//        .snapshots();
//
//        recuperarProduto(label).then((val) async {
//          print(val);
//          return val.toString();
//        });
//    return db.toString();
//
//  }



//  Future<String> recuperarProdutoT(label) async{
//    String result = (await FirebaseDatabase.instance.reference()
//        .child('produtos/nome_produto').once()).value;
//    print(result);
//    return result;
//  }




  String get id => _id;

  set id(String value) {
    _id = value;
  }
  double get Preco_Massa_Acrilica => _Preco_Massa_Acrilica;

  set Preco_Massa_Acrilica(double value) {
    _Preco_Massa_Acrilica = value;
  }

  double get Preco_Selador_Acrilico => _Preco_Selador_Acrilico;

  set Preco_Selador_Acrilico(double value) {
    _Preco_Selador_Acrilico = value;
  }

  double get Preco_Massa_PVA => _Preco_Massa_PVA;

  set Preco_Massa_PVA(double value) {
    _Preco_Massa_PVA = value;
  }

  double get Preco_Textura_Acrilica => _Preco_Textura_Acrilica;

  set Preco_Textura_Acrilica(double value) {
    _Preco_Textura_Acrilica = value;
  }

  double get Preco_Latex_Economico => _Preco_Latex_Economico;

  set Preco_Latex_Economico(double value) {
    _Preco_Latex_Economico = value;
  }

  double get Preco_Grafiato_Acrilico => _Preco_Grafiato_Acrilico;

  set Preco_Grafiato_Acrilico(double value) {
    _Preco_Grafiato_Acrilico = value;
  }

  String get label => _label;

  set label(String value) {
    _label = value;
  }
  String get apresentar_registro => _apresentar_registro;

  set apresentar_registro(String value) {
    _apresentar_registro = value;
  }

  String get preco_produto => _preco_produto;

  set preco_produto(String value) {
    _preco_produto = value;
  }

  String get nome_produto => _nome_produto;

  set nome_produto(String value) {
    _nome_produto = value;
  }
}