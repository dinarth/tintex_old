import 'package:firebase_auth/firebase_auth.dart';
import 'package:tintex/Home.dart';
import 'package:tintex/fabrica/HomeFabrica.dart';
import 'package:tintex/model/Usuario.dart';
import 'package:tintex/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final String admin      = "dinarths@gmail.com";

  bool _obscureText = true;


  Future verificaUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    FirebaseUser usuarioLogado = await auth.currentUser();
    if (usuarioLogado != null) {
      if (_emailController.text != admin) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      } else {
        Future.delayed(Duration(milliseconds: 0)).then((_) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeFabrica()));
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verificaUsuarioLogado();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        body: ScopedModelDescendant<Usuario>(
          builder: (context, child, model) {
            if (model.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {

                return Form(
                  key: _formKey,
                  child: ListView(
                    padding: EdgeInsets.all(16.0),
                    children: <Widget>[
                      SizedBox(
                        height: 150,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Image(
                              image: AssetImage("assets/logo.PNG"),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(hintText: "E-mail"),
                          keyboardType: TextInputType.emailAddress,
                          validator: (text) {
                            if (text.isEmpty || !text.contains("@"))
                              return "E-mail inválido.";
                          }),
                      TextFormField(
                        controller: _passController,
                        obscureText: _obscureText,
                        validator: (text) {
                          if (text.isEmpty || text.length < 6)
                            return "Senha inválida.";
                        },
                        decoration: InputDecoration(
                            hintText: "Senha",
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme
                                    .of(context)
                                    .primaryColorDark,
                              ),
                              onPressed: () {
                                _toggle();
                              },
                            )),
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: FlatButton(
                            onPressed: () {
                              if (_emailController.text.isEmpty) {
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content:
                                  Text('Insira seu e-mail para recuperação.'),
                                  backgroundColor: Colors.redAccent,
                                  duration: Duration(seconds: 3),
                                ));
                              } else {
                                model.recoverPass(_emailController.text);
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text('Confira seu e-mail.'),
                                  backgroundColor: Theme
                                      .of(context)
                                      .primaryColor,
                                  duration: Duration(seconds: 3),
                                ));
                              }
                            },
                            child: Text(
                              "Esqueci minha senha",
                              textAlign: TextAlign.right,
                            ),
                            padding: EdgeInsets.zero,
                          )),
                      SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        height: 44.0,
                        child: RaisedButton(
                          child: Text(
                            "Entrar",
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                          textColor: Colors.white,
                          color: Theme
                              .of(context)
                              .primaryColor,
                          onPressed: () {
                            if (_formKey.currentState.validate()) {}
                            model.signIn(
                                email: _emailController.text,
                                pass: _passController.text,
                                onSuccess: _onSuccess,
                                onFail: _onFail);
                                null;
                            },

                        ),
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: FlatButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SignupScreen()));
                            },
                            child: Text(
                              "Crie sua conta",
                              textAlign: TextAlign.center,
                            ),
                            padding: EdgeInsets.zero,
                          )),
                    ],
                  ),
                );

            }
          },
        ));
  }

  void _onSuccess() {
    if (_emailController.text != admin) {
      Future.delayed(Duration(milliseconds: 0)).then((_) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
      });
    } else {
      Future.delayed(Duration(milliseconds: 0)).then((_) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeFabrica()));
      });
    }
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('Falha ao entrar. Verifique login e senha.'),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }



}
