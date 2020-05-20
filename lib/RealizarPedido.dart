import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:tintex/ConfirmarPedido.dart';
import 'package:tintex/model/Pedido.dart';
import 'package:tintex/model/Produto.dart';
import 'package:tintex/model/SolicitarPedido.dart';
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
  final double _widthTextField = 55;
  final double _heightTextField = 30;
  Usuario usuario = new Usuario();
  String _Acao = 'I'; // I significa Incluir novo registro
  bool result = false;
  var results;
  var qualquer;
  var results_massa_pva;
  var results_latex_eco;
  var results_grafiato_acri;
  var results_selador_acri;
  var results_textura_acri;
  var results_massa_acri;

  bool resultado = false;
  var resultado_pva;


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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SolicitarPedido solicitarPedido = SolicitarPedido();
    Produto produto = Produto();
    return Scaffold(body: ScopedModelDescendant<Usuario>(
      builder: (context, child, model) {
        return Column(

          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

          Expanded(
            child: FutureBuilder<QuerySnapshot>(
              future: Firestore.instance.collection('produtos').getDocuments(),
              builder: (context, snapshot){
                if(snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index){
                        String path;
                        String pathMassaPVA   = 'assets/saco_massa_pva.PNG';
                        String pathMassaAcri  = 'assets/saco_massa_acrilica.PNG';
                        String pathSela       = 'assets/selador.PNG';
                        String pathGrafi      = 'assets/saco_grafiatto_rustico.PNG';
                        String pathLatex      = 'assets/latex_eco.PNG';
                        String pathTextura    = 'assets/saco_textura_acrilica.PNG';
                        TextEditingController controller;

                        switch (snapshot.data.documents[index]['label']){
                          case 'massa_pva':{
                            TextEditingController _Massa_PVA = TextEditingController();
                            controller = _Massa_PVA;
                            produto.Preco_Massa_PVA = double.parse(snapshot.data.documents[index]['preco_produto']);
                            path  = pathMassaPVA;
                          }break;
                          case 'massa_acri':{
                            TextEditingController _Massa_Acrilica = TextEditingController();
                            controller = _Massa_Acrilica;
                            produto.Preco_Massa_Acrilica = double.parse(snapshot.data.documents[index]['preco_produto']);
                            path  = pathMassaAcri;
                          }break;
                          case 'selador_acri':{
                            TextEditingController _Selador_Acrilico = TextEditingController();
                            controller = _Selador_Acrilico;
                            produto.Preco_Selador_Acrilico = double.parse(snapshot.data.documents[index]['preco_produto']);
                            path  = pathSela;
                          }break;
                          case 'latex_eco':{
                            TextEditingController _Latex_Economico = TextEditingController();
                            controller = _Latex_Economico;
                            produto.Preco_Latex_Economico = double.parse(snapshot.data.documents[index]['preco_produto']);
                            path  = pathLatex;
                          }break;
                          case 'grafiato_acri':{
                            TextEditingController _Grafiato_Acrilico = TextEditingController();
                            controller = _Grafiato_Acrilico;
                            produto.Preco_Grafiato_Acrilico = double.parse(snapshot.data.documents[index]['preco_produto']);
                            path  = pathGrafi;
                          }break;
                          case 'textura_acri':{
                            TextEditingController _Textura_Acrilica = TextEditingController();
                            controller = _Textura_Acrilica;
                            produto.Preco_Textura_Acrilica = double.parse(snapshot.data.documents[index]['preco_produto']);
                            path  = pathTextura;
                          }break;
                        }

                        return InkWell(
                            child: Card(
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              snapshot.data.documents[index]['nome_produto'],
                                              style: TextStyle(fontWeight: FontWeight.w500),
                                            ),
                                            Image(
                                              image: AssetImage(path),
                                              fit: BoxFit.cover,
                                              height: 100.0,
                                            ),
                                          ],
                                        )

                                      ),

                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "Quantidade",
                                              style: TextStyle(
                                                  color: Theme.of(context).primaryColor,
                                                  fontSize: 17.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextFormField(
                                              onChanged: (Text){
                                                switch (snapshot.data.documents[index]['label']){
                                                  case 'massa_pva':{
                                                    solicitarPedido.Massa_PVA = controller.text;
                                                  }break;
                                                  case 'massa_acri':{
                                                    solicitarPedido.Massa_Acrilica = controller.text;
                                                  }break;
                                                  case 'selador_acri':{
                                                    solicitarPedido.Selador_Acrilico = controller.text;
                                                  }break;
                                                  case 'latex_eco':{
                                                    solicitarPedido.Latex_Economico = controller.text;
                                                  }break;
                                                  case 'grafiato_acri':{
                                                    solicitarPedido.Grafiato_Acrilico = controller.text;
                                                  }break;
                                                  case 'textura_acri':{
                                                    solicitarPedido.Textura_Acrilica = controller.text;
                                                  }break;
                                                }

                                              },
                                              inputFormatters: <TextInputFormatter>[
                                                WhitelistingTextInputFormatter.digitsOnly
                                              ],
                                              keyboardType: TextInputType.number,
                                              textAlign: TextAlign.center,
                                              maxLength: 3,
                                              decoration: new InputDecoration(
                                                hintText: '0',
                                                border: InputBorder.none,
                                                counterText: '',
                                              ),
                                              controller: controller,
                                            ),


                                            Text(
                                              "R\$ ${snapshot.data.documents[index]['preco_produto']}",
                                              style: TextStyle(
                                                  color: Theme.of(context).primaryColor,
                                                  fontSize: 17.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )

                                  ],
                                )
                            )
                        );
                      }
                  );
                }else{
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),


            Padding(
              padding: EdgeInsets.only(top: 10),
              child: RaisedButton(
                color: Colors.blue,
                textColor: Colors.white,
                padding: EdgeInsets.all(15),
                child: Text(
                  "Fazer Pedido",
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  _confirmarPedido(solicitarPedido, model.firebaseUser.uid.toString(), produto);
                  // _validarCampos(model.firebaseUser.uid.toString());
                },
              ),
            ),
          ],
        );
      },
    ));
  }

  void _confirmarPedido(SolicitarPedido solicitarPedido, idUsuario, Produto produto) {
//    SolicitarPedido solicitarPedido = SolicitarPedido();

    if (solicitarPedido.Massa_PVA == null || solicitarPedido.Massa_PVA.isEmpty)
      solicitarPedido.Massa_PVA = '0';
    if (solicitarPedido.Massa_Acrilica == null || solicitarPedido.Massa_Acrilica.isEmpty)
      solicitarPedido.Massa_Acrilica = '0';
    if (solicitarPedido.Selador_Acrilico == null || solicitarPedido.Selador_Acrilico.isEmpty)
      solicitarPedido.Selador_Acrilico = '0';
    if (solicitarPedido.Latex_Economico == null || solicitarPedido.Latex_Economico.isEmpty)
      solicitarPedido.Latex_Economico = '0';
    if (solicitarPedido.Grafiato_Acrilico == null || solicitarPedido.Grafiato_Acrilico.isEmpty)
      solicitarPedido.Grafiato_Acrilico = '0';
    if (solicitarPedido.Textura_Acrilica == null || solicitarPedido.Textura_Acrilica.isEmpty)
      solicitarPedido.Textura_Acrilica = '0';

    solicitarPedido.apresentarRegistro = '1';


    if(solicitarPedido.Textura_Acrilica == '0'    && solicitarPedido.Grafiato_Acrilico == '0'
        && solicitarPedido.Latex_Economico == '0' && solicitarPedido.Selador_Acrilico == '0'
        && solicitarPedido.Massa_Acrilica == '0'  && solicitarPedido.Massa_PVA == '0'){

        _showEmptyFields();
    }else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              ConfirmarPedido(solicitarPedido, produto, idUsuario)));
    }
    }


  void _showEmptyFields() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Favor informar a quantidade de pelo menos um produto."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("OK"),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),

          ],
        );
      },
    );
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
