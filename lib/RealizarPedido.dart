import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tintex/ConfirmarPedido.dart';
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
  TextEditingController _Massa_PVA = TextEditingController();
  TextEditingController _Massa_Acrilica = TextEditingController();
  TextEditingController _Selador_Acrilico = TextEditingController();
  TextEditingController _Latex_Economico = TextEditingController();
  TextEditingController _Grafiato_Acrilico = TextEditingController();
  TextEditingController _Textura_Acrilica = TextEditingController();
  final double _widthTextField                   = 55;
  final double _heightTextField                  = 30;
  RealizarPedido realizarPedido = new RealizarPedido();
  Usuario  usuario              = new Usuario();
  String _Acao        = 'I'; // I significa Incluir novo registro



  int anoAtual = DateTime.now().year;
  String _textoResultado = "";

  String currencyConverse(String valorMoeda) {
    if (valorMoeda.length > 4) {
      valorMoeda = valorMoeda.replaceAll('.', '');
    }
    valorMoeda = valorMoeda.replaceAll(',', '.');
    return valorMoeda;
  }

  final format = DateFormat("dd/MM/yyyy");

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ScopedModelDescendant<Usuario>(
      builder: (context, child, model) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              //ROW 1
              children: [
                Container(
                  child: Text("QTD"),
                ),
                Container(
                  child: Text("Descriminação"),
                ),
                Container(
                  child: Text("Vl Unitário"),
                ),
                Container(
                  child: Text("Total"),
                ),
              ],
            ),
            Row(//ROW 2
                children: [
                  new Container(
                    width: _widthTextField,
                    height: _heightTextField,
                    decoration: new BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: new Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    child: new TextField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: new InputDecoration(
                        labelText: '0',
                        border: InputBorder.none,
                      ),
                      controller: _Massa_PVA,
                    ),
                  ),

                  Container(
                    child: Text("Massa PVA saco 15kg"),
                  ),
                  Container(
                    child: Text("R\$15,90"),
                  ),
                  Container(
                    child: Text("R\$15,90"),
                  ),
                ]),
            Row(//ROW 2
                children: [
                  new Container(
                    width: _widthTextField,
                    height: _heightTextField,
                    decoration: new BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: new Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    child: new TextField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: new InputDecoration(
                        labelText: '0',
                        border: InputBorder.none,
                      ),
                      controller: _Massa_Acrilica,
                    ),
                  ),

                  Container(
                    child: Text("Massa Acrilica"),
                  ),
                  Container(
                    child: Text("R\$15,90"),
                  ),
                  Container(
                    child: Text("R\$15,90"),
                  ),
                ]),
            Row(//ROW 2
                children: [
                  new Container(
                    width: _widthTextField,
                    height: _heightTextField,
                    decoration: new BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: new Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    child: new TextField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: new InputDecoration(
                        labelText: '0',
                        border: InputBorder.none,
                      ),
                      controller: _Selador_Acrilico,
                    ),
                  ),

                  Container(
                    child: Text("Latex Economico"),
                  ),
                  Container(
                    child: Text("R\$15,90"),
                  ),
                  Container(
                    child: Text("R\$15,90"),
                  ),
                ]),
            Row(//ROW 2
                children: [
                  new Container(
                    width: _widthTextField,
                    height: _heightTextField,
                    decoration: new BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: new Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    child: new TextField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: new InputDecoration(
                        labelText: '0',
                        border: InputBorder.none,
                      ),
                      controller: _Latex_Economico,
                    ),
                  ),

                  Container(
                    child: Text("Grafiato Acrilico"),
                  ),
                  Container(
                    child: Text("R\$15,90"),
                  ),
                  Container(
                    child: Text("R\$15,90"),
                  ),
                ]),
            Row(//ROW 2
                children: [
                  new Container(
                    width: _widthTextField,
                    height: _heightTextField,
                    decoration: new BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: new Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    child: new TextField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: new InputDecoration(
                        labelText: '0',
                        border: InputBorder.none,
                      ),
                      controller: _Grafiato_Acrilico,
                    ),
                  ),

                  Container(
                    child: Text(" Grafiato Acrilico"),
                  ),
                  Container(
                    child: Text("R\$15,90"),
                  ),
                  Container(
                    child: Text("R\$15,90"),
                  ),
                ]),
            Row(//ROW 2
                children: [
                  new Container(
                    width: _widthTextField,
                    height: _heightTextField,
                    decoration: new BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: new Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    child: new TextField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: new InputDecoration(
                        labelText: '0',
                        border: InputBorder.none,
                      ),
                      controller: _Textura_Acrilica,
                    ),
                  ),

                  Container(
                    child: Text("Textura Acrilica"),
                  ),
                  Container(
                    child: Text("R\$15,90"),
                  ),
                  Container(
                    child: Text("R\$15,90"),
                  ),
                ]),

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
                  _confirmarPedido(model.firebaseUser.uid.toString());
                 // _validarCampos(model.firebaseUser.uid.toString());
                },
              ),
            ),
          ],


        );
      },
    ));
  }

// DateFormat(String s) {}

  _validarCampos(String idUsuarioLogado) {
    String Massa_PVA          = _Massa_PVA.text;
    String Massa_Acrilica     = _Massa_Acrilica.text;
    String Selador_Acrilico   = _Selador_Acrilico.text;
    String Latex_Economico    = _Latex_Economico.text;
    String Grafiato_Acrilico  = _Grafiato_Acrilico.text;
    String Textura_Acrilica   = _Textura_Acrilica.text;
    String Acao               = _Acao;
    String apresentarRegistro = '1';
//    String idUsuarioLogado        = uid;

    //criando objeto Terreno
    Pedido pedido = Pedido(
        Massa_Acrilica,
        Selador_Acrilico,
        Massa_PVA,
        Textura_Acrilica,
        Latex_Economico,
        Grafiato_Acrilico,
        apresentarRegistro);

    pedido.cadastrarPedido(pedido, idUsuarioLogado);

    _Massa_PVA.text = "0";
    _Massa_Acrilica.text = "0";
    _Selador_Acrilico.text = "0";
    _Latex_Economico.text = "0";
    _Grafiato_Acrilico.text = "0";
    _Textura_Acrilica.text = "0";
  }


  void _confirmarPedido(idUsuario) {
    String Massa_PVA          = _Massa_PVA.text;
    String Massa_Acrilica     = _Massa_Acrilica.text;
    String Selador_Acrilico   = _Selador_Acrilico.text;
    String Latex_Economico    = _Latex_Economico.text;
    String Grafiato_Acrilico  = _Grafiato_Acrilico.text;
    String Textura_Acrilica   = _Textura_Acrilica.text;
    String apresentarRegistro = '1';

    Pedido pedido = new Pedido(
        Massa_Acrilica,
        Selador_Acrilico,
        Massa_PVA,
        Textura_Acrilica,
        Latex_Economico,
        Grafiato_Acrilico,
        apresentarRegistro );


    Navigator.of(context).push(MaterialPageRoute(

        builder: (context) =>
            ConfirmarPedido(pedido, idUsuario)));
  }

  TextEditingController get Massa_Acrilica => _Massa_Acrilica;

  set Massa_Acrilica(TextEditingController value) {
    _Massa_Acrilica = value;
  }

  TextEditingController get Selador_Acrilico => _Selador_Acrilico;

  set Selador_Acrilico(TextEditingController value) {
    _Selador_Acrilico = value;
  }

  TextEditingController get Latex_Economico => _Latex_Economico;

  set Latex_Economico(TextEditingController value) {
    _Latex_Economico = value;
  }

  TextEditingController get Grafiato_Acrilico => _Grafiato_Acrilico;

  set Grafiato_Acrilico(TextEditingController value) {
    _Grafiato_Acrilico = value;
  }

  TextEditingController get Textura_Acrilica => _Textura_Acrilica;

  set Textura_Acrilica(TextEditingController value) {
    _Textura_Acrilica = value;
  }

  TextEditingController get Massa_PVA => _Massa_PVA;

  set Massa_PVA(TextEditingController value) {
    _Massa_PVA = value;
  }

}
