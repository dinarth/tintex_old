import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tintex/model/Produto.dart';
import 'package:tintex/model/SolicitarPedido.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tintex/model/UsuarioSistema.dart';
import 'package:tintex/util/StatusPedido.dart';
import 'package:tintex/util/UsuarioFirebase.dart';

import 'Home.dart';
import 'helper/Formatador.dart';

class ConfirmarPedido extends StatefulWidget {
  final SolicitarPedido solicitarPedido;
  Produto produto;
  final String idUsuario;


  ConfirmarPedido(this.solicitarPedido,this.produto, this.idUsuario);

  @override
  _ConfirmarPedidoState createState() => _ConfirmarPedidoState(solicitarPedido, produto);
}

class _ConfirmarPedidoState extends State<ConfirmarPedido> {
  Formatador formatador = Formatador();
  final SolicitarPedido solicitarPedido;
  final Produto produto;
  Firestore db                = Firestore.instance;
  String _valorTotalDoPedido;
  String _qtdTotalPrd;

  String pathMassaPVA     = 'assets/saco_massa_pva.PNG';
  String pathMassaAcri    = 'assets/saco_massa_acrilica.PNG';
  String pathSela         = 'assets/selador.PNG';
  String pathGrafi        = 'assets/saco_grafiatto_rustico.PNG';
  String pathLatex        = 'assets/latex_eco.PNG';
  String pathTextura      = 'assets/saco_textura_acrilica.PNG';

  double _heigth = 60.0;
  double _width = 40.0;




  _ConfirmarPedidoState(this.solicitarPedido,this.produto);

  valorTotalPedido(){
    double valorTotal;
    int qtdTotalPrd;
    valorTotal = double.parse(solicitarPedido.Textura_Acrilica)     * produto.Preco_Textura_Acrilica;
    valorTotal += double.parse(solicitarPedido.Grafiato_Acrilico)   * produto.Preco_Grafiato_Acrilico;
    valorTotal += double.parse(solicitarPedido.Latex_Economico)     * produto.Preco_Latex_Economico;
    valorTotal += double.parse(solicitarPedido.Massa_Acrilica)      * produto.Preco_Massa_Acrilica;
    valorTotal += double.parse(solicitarPedido.Massa_PVA)           * produto.Preco_Massa_PVA;
    valorTotal += double.parse(solicitarPedido.Selador_Acrilico)    * produto.Preco_Selador_Acrilico;

    qtdTotalPrd = int.parse(solicitarPedido.Textura_Acrilica) + int.parse(solicitarPedido.Grafiato_Acrilico) + int.parse(solicitarPedido.Latex_Economico) + int.parse(solicitarPedido.Massa_Acrilica) +
        int.parse(solicitarPedido.Massa_PVA) + int.parse(solicitarPedido.Selador_Acrilico);

    NumberFormat formatar = NumberFormat("00.00");
    this.valorTotalDoPedido = formatar.format(valorTotal);

    this.qtdTotalPrd = qtdTotalPrd.toString();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    valorTotalPedido();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Confirmar Pedido"),
        ),
        body: Container(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "Confirmação do Pedido",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      Text("Valor total do pedido: R\$ ${formatador.currencyConverse(valorTotalDoPedido.toString())}"),
                      Text(""),
                      Text("QTD"),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image(
                        image: AssetImage(pathMassaAcri),
                        fit: BoxFit.cover,
                        height: _heigth,
                        width: _width,
                      ),
                      Text("Massa Acrílica:", textAlign: TextAlign.right,),
                      Text("${solicitarPedido.Massa_Acrilica}")
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image(
                        image: AssetImage(pathSela),
                        fit: BoxFit.cover,
                        height: _heigth,
                        width: _width,
                      ),
                      Text("Selador Acrílico: ", textAlign: TextAlign.right,),
                      Text("${solicitarPedido.Selador_Acrilico}")
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image(
                        image: AssetImage(pathGrafi),
                        fit: BoxFit.cover,
                        height: _heigth,
                        width: _width,
                      ),
                      Text("Grafiato Acrílico: ", textAlign: TextAlign.right,),
                      Text("${solicitarPedido.Grafiato_Acrilico}")
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image(
                        image: AssetImage(pathTextura),
                        fit: BoxFit.cover,
                        height: _heigth,
                        width: _width,
                      ),
                      Text("Textura Acrílica: ", textAlign: TextAlign.right,),
                      Text("${solicitarPedido.Textura_Acrilica}")
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image(
                        image: AssetImage(pathLatex),
                        fit: BoxFit.cover,
                        height: _heigth,
                        width: _width,
                      ),
                      Text("Latex Econômico: ", textAlign: TextAlign.right,),
                      Text("${solicitarPedido.Latex_Economico}")
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image(
                        image: AssetImage(pathMassaPVA),
                        fit: BoxFit.cover,
                        height: _heigth,
                        width: _width,
                      ),
                      Text("Massa PVA: ", textAlign: TextAlign.right,),
                      Text("${solicitarPedido.Massa_PVA}")
                    ],
                  ),

                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      Text(""),
                      Text("Total itens:", textAlign: TextAlign.right, style: TextStyle(fontSize: 18),),
                      Text("${qtdTotalPrd}",style: TextStyle(fontSize: 18),),
                    ],
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: RaisedButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      padding: EdgeInsets.all(15),
                      child: Text(
                        "Confirmar Pedido",
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),
                      onPressed: (){
                        _validarCampos();
                      },
                    ),
                  ),

                ],
              ),

            )
        )

    );
  }


  _validarCampos()async {
    //////////////////FORMATAR NUMERO DO PEDIDO////////////////////////
    String dateTimeNow = new DateTime.now().toString();

    String numeroPedido     = dateTimeNow.replaceAll("-", "");
    numeroPedido     = numeroPedido.replaceAll(":", "");
    numeroPedido     = numeroPedido.replaceAll(".", "");
    numeroPedido     = numeroPedido.replaceAll(" ", "");
    numeroPedido     = numeroPedido.substring(2,16);

    /////////////////////FORMATAR DATAS/////////////////////////////////
    Formatador formatador = new Formatador();

    String dataPedido   = formatador.formatarData(dateTimeNow);

    ////////////////////Novo cadastro de pedido//////////////////

    UsuarioSistema usuarioSistema = await  UsuarioFirebase.getDadosUsuarioLogado();

    solicitarPedido.status                  = StatusPedido.ENVIADO;
    solicitarPedido.usuarioSistema          = usuarioSistema;
    solicitarPedido.apresentarRegistro      = '1';
    solicitarPedido.numero_Pedido           = numeroPedido;
    solicitarPedido.data_pedido             = dataPedido;
    solicitarPedido.data_atualizacao        = dataPedido;
    solicitarPedido.qtd_total_itens         = qtdTotalPrd;
    solicitarPedido.valor_total             = valorTotalDoPedido;


    if(valorTotalDoPedido == '00.00'){
      _showPedidoNaoConfirmado();
    }else {
      solicitarPedido.cadastrarPedido(solicitarPedido);
      _showDialog(numeroPedido);
    }
  }

  void _showPedidoNaoConfirmado() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Pedido não confirmado. Pedido zerado. Favor conferir a solicitação."),
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

  void _showDialog(numeroPedido) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Pedido " + numeroPedido + " realizado com sucesso."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
//            new FlatButton(
//              child: new Text("Novo Pedido"),
//              onPressed: (){
//                Navigator.of(context).push(MaterialPageRoute(
//                    builder: (context) =>
//                       RealizarPedido()));
//              },
//
//            ),
            new FlatButton(
              child: new Text("Listar Pedidos"),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      Home()));
              },

            ),
          ],
        );
      },
    );
  }

  String get qtdTotalPrd => _qtdTotalPrd;

  set qtdTotalPrd(String value) {
    _qtdTotalPrd = value;
  }
  String get valorTotalDoPedido => _valorTotalDoPedido;

  set valorTotalDoPedido(String value) {
    _valorTotalDoPedido = value;
  }


}
