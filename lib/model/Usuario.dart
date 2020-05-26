import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tintex/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tintex/login_screen.dart';

class Usuario extends Model {
  String _nome;
  String _cnpj;
  String _telefone;
  String _endereco;
  String _email;



  FirebaseAuth _auth = FirebaseAuth.instance;

  Home loginScreen = new Home();

  FirebaseUser firebaseUser;
  Map<String, dynamic> userData = Map();

  bool isLoading = false;

  String _idUsuarioLogado;

  String get idUsuarioLogado => _idUsuarioLogado;

  set idUsuarioLogado(String value) {
    _idUsuarioLogado = value;
  }

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    _loadCurrentUser();
  }

  void signUp(
      {@required Map<String, dynamic> userData,
      @required String pass,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) {
    isLoading = true;
    notifyListeners();

    _auth
        .createUserWithEmailAndPassword(
            email: userData['email'], password: pass)
        .then((user) async {
      firebaseUser = user;

      await _saveUserData(userData);

      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void signInAfter(String email, String pass) {
    isLoading = true;
    notifyListeners();
    _auth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((user) async {
      firebaseUser = user;

      await _loadCurrentUser();

      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      isLoading = false;
      notifyListeners();
    });
  }

  void signIn(
      {@required String email,
      @required String pass,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();

    _auth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((user) async {
      firebaseUser = user;

      await _loadCurrentUser();

      onSuccess();
    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });

    await Future.delayed(Duration(microseconds: 100));

    isLoading = false;
    notifyListeners();
  }

  void recoverPass(String email) {
    _auth.sendPasswordResetEmail(email: email);
  }

  bool isLoggedIn() {
    if (firebaseUser == null)
      return false;
    else
      return true;
  }

  void signOut() async {
    await _auth.signOut();

    this.userData.clear();
    firebaseUser = null;

    this.isLoggedIn();
    notifyListeners();
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await Firestore.instance
        .collection("usuarios")
        .document(firebaseUser.uid)
        .setData(userData);
  }

  Future<Null> _loadCurrentUser() async {
    if (firebaseUser == null) firebaseUser = await _auth.currentUser();
    if (firebaseUser != null) {
      if (userData['nome'] == null) {
        DocumentSnapshot docUser = await Firestore.instance
            .collection("usuarios")
            .document(firebaseUser.uid)
            .get();
        userData = docUser.data;
      }
    }
    notifyListeners();
  }


  Future<String> retornarUid() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    return uid;
  }

  void atualizarDadosUsuario(Usuario usuario, idUsuario){
    Firestore db = Firestore.instance;
    db.collection("usuarios")
             .document(idUsuario)
             .updateData(updateMap(usuario));

  }

  Map<String, dynamic> updateMap(Usuario usuario){
    Map<String, dynamic> map = {
      'nome'      : usuario.nome,
      'cnpj'      : usuario.cnpj,
      'telefone'  : usuario.telefone,
      'endereco'  : usuario.endereco
  };

    return map;

  }

  String get cnpj => _cnpj;

  set cnpj(String value) {
    _cnpj = value;
  }

  String get telefone => _telefone;

  set telefone(String value) {
    _telefone = value;
  }

  String get endereco => _endereco;

  set endereco(String value) {
    _endereco = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }


}

