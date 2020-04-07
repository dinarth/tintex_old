class Produto{
  double _Preco_Massa_Acrilica;
  double _Preco_Selador_Acrilico;
  double _Preco_Massa_PVA;
  double _Preco_Textura_Acrilica;
  double _Preco_Latex_Economico;
  double _Preco_Grafiato_Acrilico;
  double get Preco_Massa_Acrilica => _Preco_Massa_Acrilica;


  Produto(){
    this._Preco_Grafiato_Acrilico = 10.99;
    this._Preco_Latex_Economico   = 20.99;
    this._Preco_Massa_Acrilica    = 15.99;
    this._Preco_Massa_PVA         = 11.99;
    this._Preco_Selador_Acrilico  = 12;
    this._Preco_Textura_Acrilica  = 10;
  }




  set Preco_Massa_Acrilica(double value) {
    _Preco_Massa_Acrilica = value;
  }

  double get Preco_Selador_Acrilico => _Preco_Selador_Acrilico;

  set Preco_Selador_Acrilico(double value) {
    _Preco_Selador_Acrilico = value;
  }

  double get Preco_Massa_PVA => _Preco_Massa_PVA;

  set Preco_Massa_PVA(double value) {
    _Preco_Massa_PVA = value;
  }

  double get Preco_Textura_Acrilica => _Preco_Textura_Acrilica;

  set Preco_Textura_Acrilica(double value) {
    _Preco_Textura_Acrilica = value;
  }

  double get Preco_Latex_Economico => _Preco_Latex_Economico;

  set Preco_Latex_Economico(double value) {
    _Preco_Latex_Economico = value;
  }

  double get Preco_Grafiato_Acrilico => _Preco_Grafiato_Acrilico;

  set Preco_Grafiato_Acrilico(double value) {
    _Preco_Grafiato_Acrilico = value;
  }


}