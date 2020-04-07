

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class Formatador {

  formatarData(String data) {
    initializeDateFormatting('pt_BR');

    var formatador = DateFormat('d/MM/y');

    DateTime dataConvertida = DateTime.parse(data);
    String dataFormatada = formatador.format(dataConvertida);

    return dataFormatada;
  }


  String currencyConverse(String valorMoeda) {
    if (valorMoeda.length > 4) {
      valorMoeda = valorMoeda.replaceAll('.', '');
    }
    valorMoeda = valorMoeda.replaceAll(',', '.');
    return valorMoeda;
  }
}