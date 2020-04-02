import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tintex/model/Pedido.dart';
import 'package:tintex/model/Usuario.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:scoped_model/scoped_model.dart';


import 'model/Pedido.dart';

class RealizarPedido extends StatefulWidget {
  @override
  _RealizarPedidoState createState() => _RealizarPedidoState();
}

class _RealizarPedidoState extends State<RealizarPedido> {
  TextEditingController _Massa_PVA                     = TextEditingController();
  TextEditingController _Massa_Acrilica                = TextEditingController();
  TextEditingController _Selador_Acrilico              = TextEditingController();
  TextEditingController _Latex_Economico               = TextEditingController();
  TextEditingController _Grafiato_Acrilico             = TextEditingController();
  TextEditingController _Textura_Acrilica              = TextEditingController();

  Usuario usuario = new Usuario();

  int anoAtual = DateTime.now().year;
  String _textoResultado = "";




  String currencyConverse(String valorMoeda){
    if (valorMoeda.length >4){
      valorMoeda = valorMoeda.replaceAll('.', '');
    }
    valorMoeda = valorMoeda.replaceAll(',', '.');
    return valorMoeda;
  }

  final format = DateFormat("dd/MM/yyyy");

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:ScopedModelDescendant<Usuario>(
        builder: (context, child, model){
      return Container(

        child: SingleChildScrollView(
          padding: EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: <Widget>[


              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text("Cadastrar Terreno",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  ),

                ),
              ),

              TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: "Título"
                ),
                style: TextStyle(
                    fontSize: 22
                ),
                controller: _Massa_PVA,
              ),
              TextField(
                keyboardType: TextInputType.text,

                decoration: InputDecoration(
                    labelText: "Cidade"
                ),
                style: TextStyle(
                    fontSize: 22
                ),
                controller: _Massa_Acrilica,
              ),

              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Valor total do terreno, ex: 80.000,00"
                ),
                style: TextStyle(
                    fontSize: 22
                ),
                controller: _Latex_Economico,
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Valor da entrada, ex: 5.000,00"
                ),
                style: TextStyle(
                    fontSize: 22
                ),
                controller: _Grafiato_Acrilico,
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Valor da parcela, ex: 500,00"
                ),
                style: TextStyle(
                    fontSize: 22
                ),
                controller: _Textura_Acrilica,
              ),


              Padding(
                padding: EdgeInsets.only(top: 10),
                child: RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Cadastrar",
                    style: TextStyle(
                        fontSize: 20
                    ),
                  ),
                  onPressed: (){
                    _validarCampos(model.firebaseUser.uid.toString());
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top:20),
                child: Text(
                  _textoResultado,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                  ),
                ),
              )
            ],

          ),
        ),
      );
          },
      )
    );
  }

// DateFormat(String s) {}


  _validarCampos(String idUsuarioLogado) {
    String Massa_PVA                 = _Massa_PVA.text;
    String Massa_Acrilica            = _Massa_Acrilica.text;
    String Selador_Acrilico          = _Selador_Acrilico.text;
    String Latex_Economico           = _Latex_Economico.text;
    String Grafiato_Acrilico         = _Grafiato_Acrilico.text;
    String Textura_Acrilica          = _Textura_Acrilica.text;
    String apresentarRegistro        = '1';
//    String idUsuarioLogado        = uid;

    //criando objeto Terreno
    Pedido pedido               =  Pedido(Massa_Acrilica, Selador_Acrilico,Massa_PVA, Textura_Acrilica, Latex_Economico, Grafiato_Acrilico, apresentarRegistro);

    pedido.cadastrarPedido(pedido, idUsuarioLogado);

    _Massa_PVA.text           = "0";
    _Massa_Acrilica.text      = "0";
    _Selador_Acrilico.text    = "0";
    _Latex_Economico.text     = "0";
    _Grafiato_Acrilico.text   = "0";
    _Textura_Acrilica.text    = "0";

  }

  _cadastrarTerreno( Pedido pedido){
    //Salvar terreno
    Firestore db = Firestore.instance;

    db.collection("pedidos")
        .document("LniQVMDb1bRvDVetHaHt5c5VhiB2")
        .collection("pedidos")
        .document()
        .setData(pedido.toMap());


  }

}