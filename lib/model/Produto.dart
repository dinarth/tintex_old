import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

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





  Produto(){}

  Map<String, dynamic> toMap(){

    Map<String, dynamic> map = {
      'nome_produto' : this.nome_produto,
      'preco_produto': this.preco_produto,
      'apresentar_registro': this.apresentar_registro,
    };

    return map;

  }

  void cadastrarProduto(Produto produto){
    Firestore db = Firestore.instance;
    db.collection("produtos")
        .add(produto.toMap());

  }




  String get id => _id;

  set id(String value) {
    _id = value;
  }
  double get Preco_Massa_Acrilica => _Preco_Massa_Acrilica;

  set Preco_Massa_Acrilica(double value) {
    _Preco_Massa_Acrilica = 15.99;
  }

  double get Preco_Selador_Acrilico => _Preco_Selador_Acrilico;

  set Preco_Selador_Acrilico(double value) {
    _Preco_Selador_Acrilico = 12;
  }

  double get Preco_Massa_PVA => _Preco_Massa_PVA;

  set Preco_Massa_PVA(double value) {
    _Preco_Massa_PVA = 11.99;
  }

  double get Preco_Textura_Acrilica => _Preco_Textura_Acrilica;

  set Preco_Textura_Acrilica(double value) {
    _Preco_Textura_Acrilica = 10;
  }

  double get Preco_Latex_Economico => _Preco_Latex_Economico;

  set Preco_Latex_Economico(double value) {
    _Preco_Latex_Economico = 20.99;
  }

  double get Preco_Grafiato_Acrilico => _Preco_Grafiato_Acrilico;

  set Preco_Grafiato_Acrilico(double value) {
    _Preco_Grafiato_Acrilico = 10.99;
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