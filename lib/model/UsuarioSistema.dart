class UsuarioSistema{

  String _idUsuario;
  String _nome;
  String _email;

  UsuarioSistema();

  Map<String, dynamic> toMap(){

    Map<String, dynamic> map = {
      'nome' : this.nome,
      'email': this.email
    };

  }

  String get idUsuario => _idUsuario;

  set idUsuario(String value) {
    _idUsuario = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

}