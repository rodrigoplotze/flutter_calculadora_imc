import 'package:flutter/material.dart';

class CalculadoraController extends ChangeNotifier {
  double _peso = 0.0;
  double _altura = 0.0;
  double _imc = 0.0;
  String _classificacao = '';

  String get imc => _imc.toStringAsFixed(2).replaceFirst('.', ',');
  String get classificacao => _classificacao;

  void setPeso(String peso) {
    _peso = double.tryParse(peso.replaceAll(',', '.')) ?? 0.0;
    notifyListeners();
  }

  void setAltura(String altura) {
    _altura = double.tryParse(altura.replaceAll(',', '.')) ?? 0.0;
    notifyListeners();
  }

  void calcularImc() {
    if (_peso <= 0 || _altura <= 0) return;

    _imc = _peso / (_altura * _altura);
    _classificacao = _obterClassificacao(_imc);
    notifyListeners();
  }

  String _obterClassificacao(double imc) {
    if (imc < 18.5) return 'Abaixo do peso';
    if (imc < 25) return 'Peso ideal';
    if (imc < 30) return 'Sobrepeso';
    if (imc < 35) return 'Obesidade Grau I';
    if (imc < 40) return 'Obesidade Grau II';
    return 'Obesidade Grau III';
  }
}
