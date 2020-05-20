import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tintex/helper/Formatador.dart';
import 'package:tintex/model/UsuarioSistema.dart';

class SolicitarPedido {
  String _id;
  String _status;
  String _Massa_Acrilica;
  String _Selador_Acrilico;
  String _Massa_PVA;
  String _Textura_Acrilica;
  String _Latex_Economico;
  String _Grafiato_Acrilico;
  String _apresentarRegistro;
  String _numero_Pedido;
  String _Acao;
  String _data_atualizacao;
  String _data_pedido;
  String _qtd_total_itens;
  String _valor_total;



  UsuarioSistema _usuarioSistema;

  SolicitarPedido();

  Map<String, dynamic> toMap(){

    Map<String, dynamic> dadosCliente = {
      'idUsuario'      : this.usuarioSistema.idUsuario,
      'nome'           : this.usuarioSistema.nome
    };

    Map<String, dynamic> dadosSolicitacao = {
      'status'              : this.status,
      'grafiato_acrilico'   : this.Grafiato_Acrilico,
      'apresentar_registro' : this.apresentarRegistro,
      'latex_economico'     : this.Latex_Economico,
      'massa_acrilica'      : this.Massa_Acrilica,
      'massa_pva'           : this.Massa_PVA,
      'numero_pedido'       : this.numero_Pedido,
      'selador_acrilico'    : this.Selador_Acrilico,
      'textura_acrilica'    : this.Textura_Acrilica,
      'data_atualizacao'    : this.data_atualizacao,
      'data_pedido'         : this.data_pedido,
      "qtd_total_itens"     : this.qtd_total_itens,
      "valor_total"         : this.valor_total,
      'cliente'             : dadosCliente
    };

    return dadosSolicitacao;
  }


  Map<String, dynamic> toMapAtualizar(){

    String dateTimeNow = new DateTime.now().toString();

    //   set numero_Pedido(numeroPedido);
    Formatador formatador = new Formatador();

    this.data_atualizacao = formatador.formatarData(dateTimeNow);

    Map<String, dynamic> map = {
      'data_atualizacao'    : this.data_atualizacao,
      "massa_acrilica"      : this.Massa_Acrilica,
      "selador_acrilico"    : this.Selador_Acrilico,
      "massa_pva"           : this.Massa_PVA,
      "textura_acrilica"    : this.Textura_Acrilica,
      "latex_economico"     : this.Latex_Economico,
      "grafiato_acrilico"   : this.Grafiato_Acrilico,
      "apresentar_registro" : this.apresentarRegistro,
      "status"              : this.status,
      "qtd_total_itens"     : this.qtd_total_itens,
      "valor_total"         : this.valor_total,
    };

    return map;
  }

  void alterarPedido(SolicitarPedido solicitarPedido){
    Firestore db = Firestore.instance;
        db.collection("pedidosSis")
        .document(solicitarPedido.id)
        .updateData(solicitarPedido.toMapAtualizar());

  }


  void cadastrarPedido(SolicitarPedido solicitarPedido){
    Firestore db = Firestore.instance;
    db.collection("pedidosSis")
        .add(solicitarPedido.toMap());
  }


  void excluirPedido(idPedido){
    Firestore db = Firestore.instance;

    db.collection("pedidosSis")
        .document(idPedido)
        .updateData({
      "apresentar_registro" : '0'
    });
  }








  String get data_atualizacao => _data_atualizacao;

  set data_atualizacao(String value) {
    _data_atualizacao = value;
  }

  UsuarioSistema get usuarioSistema => _usuarioSistema;

  String get Massa_Acrilica => _Massa_Acrilica;

  set Massa_Acrilica(String value) {
    _Massa_Acrilica = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get status => _status;

  set status(String value) {
    _status = value;
  }

  set usuarioSistema(UsuarioSistema value) {
    _usuarioSistema = value;
  }

  String get Selador_Acrilico => _Selador_Acrilico;

  set Selador_Acrilico(String value) {
    _Selador_Acrilico = value;
  }

  String get Massa_PVA => _Massa_PVA;

  set Massa_PVA(String value) {
    _Massa_PVA = value;
  }

  String get Textura_Acrilica => _Textura_Acrilica;

  set Textura_Acrilica(String value) {
    _Textura_Acrilica = value;
  }

  String get Latex_Economico => _Latex_Economico;

  set Latex_Economico(String value) {
    _Latex_Economico = value;
  }

  String get Grafiato_Acrilico => _Grafiato_Acrilico;

  set Grafiato_Acrilico(String value) {
    _Grafiato_Acrilico = value;
  }

  String get apresentarRegistro => _apresentarRegistro;

  set apresentarRegistro(String value) {
    _apresentarRegistro = value;
  }

  String get numero_Pedido => _numero_Pedido;

  set numero_Pedido(String value) {
    _numero_Pedido = value;
  }

  String get Acao => _Acao;

  set Acao(String value) {
    _Acao = value;
  }

  String get data_pedido => _data_pedido;

  set data_pedido(String value) {
    _data_pedido = value;
  }

  String get valor_total => _valor_total;

  set valor_total(String value) {
    _valor_total = value;
  }
  String get qtd_total_itens => _qtd_total_itens;

  set qtd_total_itens(String value) {
    _qtd_total_itens = value;
  }
}
