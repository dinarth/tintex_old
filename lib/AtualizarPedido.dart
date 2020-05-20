import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tintex/model/Pedido.dart';
import 'package:tintex/model/SolicitarPedido.dart';
import 'package:tintex/model/Usuario.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';
import 'package:intl/number_symbols_data.dart';

import 'ConfirmarAtualizarPedido.dart';
import 'model/Produto.dart';

class AtualizarPedido extends StatefulWidget {
  final SolicitarPedido solicitarPedido;
  final String idUsuarioLogado;

  AtualizarPedido(this.solicitarPedido,  this.idUsuarioLogado);

  @override
  State <AtualizarPedido> createState() {
    return _AtualizarPedidoState(
        this.solicitarPedido, this.idUsuarioLogado);
  }
}

class _AtualizarPedidoState extends State<AtualizarPedido> {
  final SolicitarPedido solicitarPedido;
  String idUsuarioLogado;
  Firestore db = Firestore.instance;
  int anoAtual = DateTime
      .now()
      .year;
  String antigoMassaAcrilica;
  String antigoSeladorAcrilico;
  String antigoMassaPVA;
  String antigoLatexEconomico;
  String antigoGrafiattoAcrilico;
  String antigoTexturaAcrilica;

  _AtualizarPedidoState(this.solicitarPedido, this.idUsuarioLogado)
      : super();

  void _carregarCampos() {//Carregar campos para controle se houve ou não alteração na quantidade
    antigoMassaAcrilica       = solicitarPedido.Massa_Acrilica;
    antigoSeladorAcrilico     = solicitarPedido.Selador_Acrilico;
    antigoMassaPVA            = solicitarPedido.Massa_PVA;
    antigoTexturaAcrilica     = solicitarPedido.Textura_Acrilica;
    antigoLatexEconomico      = solicitarPedido.Latex_Economico;
    antigoGrafiattoAcrilico   = solicitarPedido.Grafiato_Acrilico;
  }

  String currencyConverse(String valorMoeda) {
    if (valorMoeda.length > 4) {
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
    Produto produto = Produto();
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

                Expanded(
                  child: FutureBuilder<QuerySnapshot>(
                    future: Firestore.instance.collection('produtos')
                        .getDocuments(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              String path;
                              String pathMassaPVA     = 'assets/saco_massa_pva.PNG';
                              String pathMassaAcri    = 'assets/saco_massa_acrilica.PNG';
                              String pathSela         = 'assets/selador.PNG';
                              String pathGrafi        = 'assets/saco_grafiatto_rustico.PNG';
                              String pathLatex        = 'assets/latex_eco.PNG';
                              String pathTextura      = 'assets/saco_textura_acrilica.PNG';
                              TextEditingController controller;

                              switch (snapshot.data.documents[index]['label']) {
                                case 'massa_pva':
                                  {
                                    TextEditingController _Massa_PVA = TextEditingController();
                                    _Massa_PVA.text  = solicitarPedido.Massa_PVA;
                                    controller = _Massa_PVA;
                                    produto.Preco_Massa_PVA = double.parse(
                                        snapshot.data
                                            .documents[index]['preco_produto']);
                                    path = pathMassaPVA;
                                  }
                                  break;
                                case 'massa_acri':
                                  {
                                    TextEditingController _Massa_Acrilica = TextEditingController();
                                    _Massa_Acrilica.text  = solicitarPedido.Massa_Acrilica;
                                    controller = _Massa_Acrilica;
                                    produto.Preco_Massa_Acrilica = double.parse(
                                        snapshot.data
                                            .documents[index]['preco_produto']);
                                    path = pathMassaAcri;
                                  }
                                  break;
                                case 'selador_acri':
                                  {
                                    TextEditingController _Selador_Acrilico = TextEditingController();
                                    _Selador_Acrilico.text   = solicitarPedido.Selador_Acrilico;
                                    controller = _Selador_Acrilico;
                                    produto.Preco_Selador_Acrilico =
                                        double.parse(snapshot.data
                                            .documents[index]['preco_produto']);
                                    path = pathSela;
                                  }
                                  break;
                                case 'latex_eco':
                                  {
                                    TextEditingController _Latex_Economico = TextEditingController();
                                    _Latex_Economico.text   = solicitarPedido.Latex_Economico;
                                    controller = _Latex_Economico;
                                    produto.Preco_Latex_Economico =
                                        double.parse(snapshot.data
                                            .documents[index]['preco_produto']);
                                    path = pathLatex;
                                  }
                                  break;
                                case 'grafiato_acri':
                                  {
                                    TextEditingController _Grafiato_Acrilico = TextEditingController();
                                    _Grafiato_Acrilico.text   = solicitarPedido.Grafiato_Acrilico;
                                    controller = _Grafiato_Acrilico;
                                    produto.Preco_Grafiato_Acrilico =
                                        double.parse(snapshot.data
                                            .documents[index]['preco_produto']);
                                    path = pathGrafi;
                                  }
                                  break;
                                case 'textura_acri':
                                  {
                                    TextEditingController _Textura_Acrilica = TextEditingController();
                                    _Textura_Acrilica.text  = solicitarPedido.Textura_Acrilica;
                                    controller = _Textura_Acrilica;
                                    produto.Preco_Textura_Acrilica =
                                        double.parse(snapshot.data
                                            .documents[index]['preco_produto']);
                                    path = pathTextura;
                                  }
                                  break;
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
                                          ),
                                        )
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
                      "Atualizar Pedido",
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                    onPressed: () {
                      _confirmarAtualizarPedido(
                          model.firebaseUser.uid.toString(), solicitarPedido.numero_Pedido, produto, solicitarPedido);
                      // _validarCampos(model.firebaseUser.uid.toString());
                    },
                  ),
                ),
              ],


            );
          },
        ));
  }

  bool isEqual(SolicitarPedido solicitarPedido){
    if(antigoGrafiattoAcrilico  == solicitarPedido.Grafiato_Acrilico && antigoLatexEconomico == solicitarPedido.Latex_Economico
       && antigoTexturaAcrilica == solicitarPedido.Textura_Acrilica  && antigoMassaPVA       == solicitarPedido.Massa_PVA
       && antigoSeladorAcrilico == solicitarPedido.Selador_Acrilico  && antigoMassaAcrilica  == solicitarPedido.Massa_Acrilica)
        return true;
    else
        return false;

  }

  void _confirmarAtualizarPedido(idUsuario, numeroPedido, produto, SolicitarPedido solicitarPedido) {
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
    if(!isEqual(solicitarPedido)){
      if(solicitarPedido.Textura_Acrilica  == '0'    && solicitarPedido.Grafiato_Acrilico == '0'
        && solicitarPedido.Latex_Economico == '0'    && solicitarPedido.Selador_Acrilico  == '0'
        && solicitarPedido.Massa_Acrilica  == '0'    && solicitarPedido.Massa_PVA         == '0'){
        _showEmptyFields();
      }else {
        Navigator.of(context).push(MaterialPageRoute(

          builder: (context) =>
              ConfirmarAtualizarPedido(solicitarPedido, idUsuario, produto)));
      }
    }else{
        _showIsEqual();
      }
  }

  void _showIsEqual() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Não houve alteração na quantidade de nenhum produto."),
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
}
