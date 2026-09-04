import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

import '../controller/calculadora_controller.dart';

class CalculadoraView extends StatefulWidget {
  const CalculadoraView({super.key});

  @override
  State<CalculadoraView> createState() => _CalculadoraViewState();
}

class _CalculadoraViewState extends State<CalculadoraView> {
  final ctrl = GetIt.I.get<CalculadoraController>();

  //iniciar o tratamento de eventos
  @override
  void initState() {
    super.initState();
    ctrl.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 12),
                Container(
                  height: 120,
                  width: 120,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorScheme.primaryContainer,
                  ),
                  child: Icon(
                    Icons.monitor_heart_outlined,
                    size: 64,
                    color: colorScheme.primary,
                  ),
                ),

                const SizedBox(height: 24),

                Text(
                  'Calculadora IMC',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                Text(
                  'Informe seu peso e altura para calcular o Índice de Massa Corporal.',
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 32),

                campoDeTexto(
                  'Peso',
                  '75,5',
                  Icons.monitor_weight_outlined,
                  'kg',
                  ctrl.setPeso,
                ),

                const SizedBox(height: 16),

                campoDeTexto(
                  'Altura',
                  '1,75',
                  Icons.height,
                  'm',
                  ctrl.setAltura,
                ),

                const SizedBox(height: 24),

                FilledButton.icon(
                  onPressed: () {
                    ctrl.calcularImc();
                  },
                  icon: const Icon(Icons.calculate_outlined),
                  label: const Text('Calcular IMC'),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                  ),
                ),

                const SizedBox(height: 32),

                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: ctrl.classificacao == ''
                      ? Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(24),
                            child: Column(
                              children: [
                                Icon(Icons.insights_outlined, size: 48),
                                SizedBox(height: 12),
                                Text('O resultado aparecerá aqui'),
                              ],
                            ),
                          ),
                        )
                      : Card(
                          elevation: 0,
                          color: colorScheme.secondaryContainer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              children: [
                                Text('Seu IMC'),

                                const SizedBox(height: 16),

                                Text(
                                  ctrl.imc,
                                  style: TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                    color: colorScheme.primary,
                                  ),
                                ),

                                const SizedBox(height: 12),

                                Chip(
                                  label: Text(ctrl.classificacao),
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //
  // CAMPO DE TEXTO
  //
  Widget campoDeTexto(
    String rotulo,
    String dica,
    IconData icone,
    String sufixo,
    funcao,
  ) {
    return TextField(
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(r'^\d*(,\d{0,2})?$'),
        ),
      ],
      decoration: InputDecoration(
        labelText: rotulo,
        hintText: dica,
        prefixIcon: Icon(icone),
        suffixText: sufixo,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: (value) => funcao(value),
    );
  }
}
