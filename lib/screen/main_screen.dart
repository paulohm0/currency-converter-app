import 'package:currency_converter/widgets/currency_conversion_field.dart';
import 'package:flutter/material.dart';

import '../data/enum/currencies.dart';
import '../viewmodel/main_viewmodel.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final MainViewmodel mainViewmodel = MainViewmodel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        color: Colors.blue.shade50,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 24,
              bottom: 24,
            ),
            child: ListenableBuilder(
              listenable: mainViewmodel,
              builder: (context, child) => Column(
                children: [
                  const Text(
                    'Currency Converter',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF26278D),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 24,
                      ),
                      child: Card(
                        margin: EdgeInsets.zero,
                        color: Colors.white,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(children: [
                          CurrencyConversionField(
                              fieldType: 'Amount',
                              mainViewmodel: mainViewmodel),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              const Divider(),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(16),
                                      backgroundColor:
                                          Colors.green, // 0xFF26278D
                                      foregroundColor: Colors.white),
                                  onPressed: () {
                                    mainViewmodel.getCoinConversion(
                                      mainViewmodel.inputCurrency.name,
                                      mainViewmodel.outputCurrency.name,
                                    );
                                  },
                                  child: const Icon(Icons.swap_vert_outlined)),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        'Converted Amount',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: SizedBox(
                                        height: 50,
                                        child: DropdownButton<Currencies>(
                                          value: mainViewmodel.outputCurrency,
                                          items:
                                              Currencies.values.map((currency) {
                                            return DropdownMenuItem<Currencies>(
                                              value: currency,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    currency.name.toUpperCase(),
                                                    style: const TextStyle(
                                                        fontSize: 28,
                                                        color: Colors.teal),
                                                  ),
                                                  const Divider(
                                                      thickness: 1,
                                                      color: Colors.grey,
                                                      height: 4),
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (newCurrency) {
                                            mainViewmodel.updateOutputCurrency(
                                                newCurrency!);
                                          },
                                          underline: const SizedBox(),
                                          icon:
                                              const Icon(Icons.arrow_drop_down),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 50,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: Colors.transparent),
                                        ),
                                        alignment: Alignment.centerRight,
                                        child: const Text('0,00',
                                            style: TextStyle(
                                                fontSize: 32,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                            textAlign: TextAlign.right),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ]),
                      )),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Indicative Exchange Rate',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w700,
                              fontSize: 16),
                        ),
                        Text(
                          '1 BRL = 0.756 USD',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
