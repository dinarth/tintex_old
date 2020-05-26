import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:tintex/Home.dart';
import 'package:tintex/model/Usuario.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'login_screen.dart';

class MinhaConta extends StatefulWidget {

  @override
  _MinhaContaState createState() => _MinhaContaState();
}

class _MinhaContaState extends State<MinhaConta> {
  final _nameController     = TextEditingController();
  final _emailController    = TextEditingController();
  final _passController     = TextEditingController();
  final _adressController   = TextEditingController();
  final _cnpjController     = TextEditingController();
  final _telefoneController = TextEditingController();

  Future<String> idUsuarioLogado;
  String _idUsuario;
  Firestore db = Firestore.instance;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Usuario usuario = Usuario();


  void inicializarCampos() {
    idUsuarioLogado = usuario.retornarUid();
    idUsuarioLogado.then((id) {
      this._idUsuario = id;
//      _recuperarListenerDados(id);
    });

    usuario.nome        = usuario.userData['nome'];
    usuario.cnpj        = usuario.userData['cnpj'];
    usuario.endereco    = usuario.userData['endereco'];
    usuario.telefone    = usuario.userData['telefone'];


    _nameController.text        = usuario.nome;
    _cnpjController.text        = usuario.cnpj;
    _adressController.text      = usuario.endereco;
    _telefoneController.text    = usuario.telefone;
  }

  @override
  void initState(){
    super.initState();

    idUsuarioLogado = usuario.retornarUid();
    idUsuarioLogado.then((id) {
      this._idUsuario = id;
    });


//
//    inicializarCampos();

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        key: _scaffoldKey,

        body: ScopedModelDescendant<Usuario>(
          builder: (context, child, model){
            usuario.nome        = model.userData['nome'];
            usuario.cnpj        = model.userData['cnpj'];
            usuario.endereco    = model.userData['endereco'];
            usuario.telefone    = model.userData['telefone'];

            _nameController.text    = usuario.nome;
            _cnpjController.text    = usuario.cnpj;
            _adressController.text  = usuario.endereco;
            _telefoneController.text= usuario.telefone;



            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: <Widget>[
                  TextFormField(
                      onChanged: (Text){
                        usuario.nome =  _nameController.text;
                      },
                      controller: _nameController,
                      decoration: InputDecoration(
                          hintText: "Nome Fantasia"
                      ),
                      validator: (text){
                        if(text.isEmpty)
                          return "Nome Fantasia inválido.";
                      }
                  ),
                  SizedBox(height: 16.0,),
                  TextFormField(
                    onChanged: (Text){
                      usuario.cnpj = _cnpjController.text;
                    },
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      CnpjInputFormatter(),
                    ],
                    controller: _cnpjController,
                    decoration: InputDecoration(
                        hintText: "CNPJ"
                    ),
                    validator: (text){
                      if(text.isEmpty)
                        return "CNPJ inválido.";
                    },
                  ),
                  SizedBox(height: 16.0,),
                  TextFormField(
                    onChanged: (Text){
                      usuario.endereco =  _adressController.text;
                    },
                    controller: _adressController,
                    decoration: InputDecoration(
                        hintText: "Endereço"
                    ),
                    validator: (text){
                      if(text.isEmpty)
                        return "Endereço inválido.";
                    },
                  ),
                  SizedBox(height: 16.0,),
                  TextFormField(
                    onChanged: (Text){
                      usuario.telefone = _telefoneController.text;
                    },
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter(),
                    ],
                    controller: _telefoneController,
                    decoration: InputDecoration(
                        hintText: "Telefone"
                    ),
                    validator: (text){
                      if(text.isEmpty)
                        return "Telefone inválido.";
                    },
                  ),



                  SizedBox(height: 16.0,),
                  SizedBox(
                    height: 44.0,
                    child: RaisedButton(
                      child: Text(
                        "Atualizar Dados",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        _atualizarDadosUsuario(usuario, this._idUsuario);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        )
    );
  }

  void _onSuccess(){
    Usuario usuario = new Usuario();

    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Usuário criado com sucesso."),
          backgroundColor: Theme.of(context).primaryColor,
          duration: Duration(seconds: 2),
        )
    );
    usuario.signInAfter(_emailController.text, _passController.text);
    Future.delayed(Duration(seconds: 2)).then((_){
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Home()));
    });
  }

  void _onFail(){
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Falha ao cadastrar usuário."),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        )
    );
  }

  void _atualizarDadosUsuario(Usuario usuario, idUsuario) {

    usuario.atualizarDadosUsuario(usuario, idUsuario);

    _showAtualizadoSucesso();

  }

  void _showAtualizadoSucesso() {

    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Dados atualizados com sucesso."),
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
              child: new Text("Ok"),
              onPressed: () {
                usuario.signOut();
                Navigator.of(context).pop();
//                Navigator.of(context).pushReplacement(
//                    MaterialPageRoute(
//                        builder: (context) =>
//                            LoginScreen()));
              },

            ),
          ],
        );
      },
    );
  }

}

