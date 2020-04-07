import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tintex/model/Pedido.dart';
import 'package:tintex/model/Usuario.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';
import 'package:intl/number_symbols_data.dart';

import 'ConfirmarAtualizarPedido.dart';

class AtualizarPedido extends StatefulWidget {
  final Pedido pedido;
  final String idPedido;
  final String idUsuarioLogado;

  AtualizarPedido(this.pedido, this.idPedido, this.idUsuarioLogado);

  @override
  State <AtualizarPedido> createState() {
    return _AtualizarPedidoState(this.pedido, this.idPedido, this.idUsuarioLogado);
  }
}

class _AtualizarPedidoState extends State<AtualizarPedido> {
  final Pedido pedido;
  String idPedido;
  String idUsuarioLogado;
  Firestore db = Firestore.instance;
  int anoAtual = DateTime.now().year;
  TextEditingController _Massa_Acrilica    = TextEditingController();
  TextEditingController _Selador_Acrilico  = TextEditingController();
  TextEditingController _Massa_PVA         = TextEditingController();
  TextEditingController _Latex_Economico   = TextEditingController();
  TextEditingController _Grafiato_Acrilico = TextEditingController();
  TextEditingController _Textura_Acrilica  = TextEditingController();

  String _Acao        = 'A'; // A significa alterar registro
  final double _widthTextField                   = 55;
  final double _heightTextField                  = 30;

  _AtualizarPedidoState(this.pedido, this.idPedido, this.idUsuarioLogado): super();

  void _carregarCampos(){

    _Massa_Acrilica.text                = pedido.massa_Acrilica;
    _Selador_Acrilico.text              = pedido.selador_Acrilico;
    _Massa_PVA.text                     = pedido.massa_PVA;
    _Textura_Acrilica.text              = pedido.textura_Acrilica;
    _Latex_Economico.text               = pedido.latex_Economico;
    _Grafiato_Acrilico.text             = pedido.grafiato_Acrilico;


  }

  String currencyConverse(String valorMoeda){
    if (valorMoeda.length >4){
      valorMoeda = valorMoeda.replaceAll('.', '');
    }
    valorMoeda = valorMoeda.replaceAll(',', '.');
    return valorMoeda;
  }




  @override
  void initState() {
    super.initState();

      _carregarCampos();
  }

  final format = DateFormat("dd/MM/yyyy");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Atualizar Pedido"),
          centerTitle: true,
        ),
        body: ScopedModelDescendant<Usuario>(

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
                  "Atualizar Pedido",
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
                onPressed: (){
                  _confirmarAtualizarPedido(model.firebaseUser.uid.toString(), idPedido, pedido.numero_Pedido);
                  // _validarCampos(model.firebaseUser.uid.toString());
                },
              ),
            ),
          ],


        );
      },
    ));
  }
  void _confirmarAtualizarPedido(idUsuario, idPedido, numeroPedido) {
    String Massa_PVA          = _Massa_PVA.text;
    String Massa_Acrilica     = _Massa_Acrilica.text;
    String Selador_Acrilico   = _Selador_Acrilico.text;
    String Latex_Economico    = _Latex_Economico.text;
    String Grafiato_Acrilico  = _Grafiato_Acrilico.text;
    String Textura_Acrilica   = _Textura_Acrilica.text;
    String apresentarRegistro = '1';
    String idPed              = idPedido;
    String numeroPed          = numeroPedido;

    Pedido pedido = new Pedido(
        Massa_Acrilica,
        Selador_Acrilico,
        Massa_PVA,
        Textura_Acrilica,
        Latex_Economico,
        Grafiato_Acrilico,
        apresentarRegistro,
        numeroPed,
        idPed);


    Navigator.of(context).push(MaterialPageRoute(

        builder: (context) =>
            ConfirmarAtualizarPedido(pedido, idUsuario)));
  }
}
