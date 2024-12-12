import 'package:currency_converter/data/enum/currencies.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrencyConversionField extends StatefulWidget {
  final String fieldType;
  const CurrencyConversionField({super.key, required this.fieldType});

  @override
  State<CurrencyConversionField> createState() =>
      _CurrencyConversionFieldState();
}

class _CurrencyConversionFieldState extends State<CurrencyConversionField> {
  late Currencies selectedCurrency = Currencies.brl;
  final TextEditingController controller = TextEditingController();
  final NumberFormat currencyFormatter = NumberFormat.decimalPattern('pt_BR');

  void onChangedAmountValue(String value) {
    String valueConfig = value.replaceAll(RegExp(r'[^\d]'), '');
    if (valueConfig.isEmpty) valueConfig = '0.00';

    final double parsedValue = double.parse(valueConfig) / 100;
    final formatted = currencyFormatter.format(parsedValue);

    setState(() {
      controller.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  widget.fieldType,
                  style: const TextStyle(
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
                    value: selectedCurrency,
                    items: Currencies.values.map((currency) {
                      return DropdownMenuItem<Currencies>(
                        value: currency,
                        child: Column(
                          children: [
                            Text(
                              currency.name.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 28,
                                color: Colors.teal,
                              ),
                            ),
                            const Divider(
                              thickness: 1,
                              color: Colors.grey,
                              height: 4,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (newCurrency) {
                      setState(() {
                        selectedCurrency = newCurrency!;
                      });
                    },
                    underline: const SizedBox(),
                    icon: const Icon(Icons.arrow_drop_down),
                  ),
                ),
              ),
              Expanded(
                child: TextFormField(
                  onChanged: onChangedAmountValue,
                  controller: controller,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
