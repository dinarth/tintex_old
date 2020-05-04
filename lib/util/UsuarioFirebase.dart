import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tintex/model/UsuarioSistema.dart';

class UsuarioFirebase{

  static Future<FirebaseUser> getUsuarioAtual() async{

    FirebaseAuth auth = FirebaseAuth.instance;
    return await auth.currentUser();

  }

  static Future<UsuarioSistema> getDadosUsuarioLogado() async{

    FirebaseUser firebaseUser = await getUsuarioAtual();
    String idUsuario = firebaseUser.uid;
    
    Firestore db = Firestore.instance;
    
    DocumentSnapshot snapshot = await db.collection("usuarios")
        .document(idUsuario)
        .get();

    Map<String, dynamic> dados = snapshot.data;
    String email = dados['email'];
    String nome  = dados['nome'];

    UsuarioSistema usuarioSistema = UsuarioSistema();
    usuarioSistema.idUsuario  = idUsuario;
    usuarioSistema.email      = email;
    usuarioSistema.nome       = nome;

    return usuarioSistema;

  }


}