import 'package:brasil_fields/formatter/cnpj_input_formatter.dart';
import 'package:brasil_fields/formatter/telefone_input_formatter.dart';
import 'package:flutter/services.dart';
import 'package:tintex/Home.dart';
import 'package:tintex/model/Usuario.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final _nameController     = TextEditingController();
  final _emailController    = TextEditingController();
  final _passController     = TextEditingController();
  final _adressController   = TextEditingController();
  final _cnpjController     = TextEditingController();
  final _telefoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Criar Conta"),
          centerTitle: true,

        ),
        body: ScopedModelDescendant<Usuario>(
          builder: (context, child, model){
            if(model.isLoading)
              return Center(child: CircularProgressIndicator(),);
            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: <Widget>[
                  TextFormField(
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
                  TextFormField(
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
                      controller: _emailController,
                      decoration: InputDecoration(
                          hintText: "E-mail"
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (text){
                        if(text.isEmpty || !text.contains("@"))
                          return "E-mail inválido.";
                      }
                  ),
                  SizedBox(height: 16.0,),
                  TextFormField(
                    controller: _passController,
                    decoration: InputDecoration(
                        hintText: "Senha"
                    ),
                    obscureText: true,
                    validator: (text){
                      if(text.isEmpty|| text.length < 6)
                        return "Senha deve ter pelo menos 6 dígitos.";
                    },
                  ),

                  SizedBox(height: 16.0,),
                  SizedBox(
                    height: 44.0,
                    child: RaisedButton(
                      child: Text(
                        "Criar Conta",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        if(_formKey.currentState.validate()){
                          Map<String, dynamic> userData = {
                            "nome"            : _nameController.text,
                            "cnpj"            : _cnpjController.text,
                            "telefone"        : _telefoneController.text,
                            "endereco"        : _adressController.text,
                            "email"           : _emailController.text
                          };

                          model.signUp(
                              userData: userData,
                              pass: _passController.text,
                              onSuccess: _onSuccess,
                              onFail: _onFail
                          );
                        }
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
    Future.delayed(Duration(seconds: 0)).then((_){
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

}

