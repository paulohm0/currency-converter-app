import 'package:currency_converter/data/enum/currencies.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final CurrencyTextInputFormatter currencyFormatter =
      CurrencyTextInputFormatter.currency(
    locale: 'pt_BR',
    decimalDigits: 2,
    symbol: '',
  );

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
                  controller: controller,
                  onChanged: (value) {
                    currencyFormatter.getFormattedValue();
                    value = currencyFormatter.getUnformattedValue().toString();
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    currencyFormatter
                  ],
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
