import 'package:tintex/login_screen.dart';
import 'package:tintex/model/Usuario.dart';
import 'package:flutter/material.dart';
import 'package:tintex/Home.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<Usuario>(
      model: Usuario(),
      child: Usuario().isLoggedIn() ?  MaterialApp(title: "Tintex", home: Home()) :
      MaterialApp(title: "Tintex", home: LoginScreen()),
    );
  }
}



/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  Firestore.instance.collection("produtos")
      .document("tipo")
      .setData({'pvc': '80', "lata tinta": "340"});

  runApp(App());
      
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
*/