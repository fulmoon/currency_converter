import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CurrencyConvert extends StatefulWidget {
  const CurrencyConvert({Key? key}) : super(key: key);

  @override
  State<CurrencyConvert> createState() => _CurrencyConvertState();
}

class _CurrencyConvertState extends State<CurrencyConvert> {
  final TextEditingController _controller = TextEditingController(text: "1");

  List<Map<String, dynamic>> currencyList = [
    {"USD": 1},
    {"AED": 3.6725},
    {"AFN": 89.7035},
    {"ALL": 113.5506},
    {"AMD": 405.3498},
    {"KRW": 1300.8174}
  ];

  List<String> countries = ["USD", "AED", "AFN", "ALL", "AMD", "KRW"];
  List<double> currencies = [1, 3.6725, 89.7035, 113.5506, 405.3498, 300.8174];

  String chooseFirst = 'USD';
  String chooseSecond = 'KRW';

  final double convertResult = 0.0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '환율계산기',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  Container(
                    width: 200,
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: Colors.grey,
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          topLeft: Radius.circular(8),
                        ),
                    ),
                    child: DropdownButton(
                      hint: const Text('Select currency'),
                      isExpanded: true,
                      underline: const SizedBox(),
                      dropdownColor: Colors.white,
                      value: chooseFirst,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 36,
                      elevation: 16,
                      style: const TextStyle(
                      color: Colors.black,
                      fontSize: 22),
                      onChanged: (String? newValue) {
                        setState(() {
                          chooseFirst = newValue!;
                        });
                      },
                      items: countries.map((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value, textAlign: TextAlign.center,),
                        );
                      }).toList(),
                    ),
                  ),
                  Flexible(
                    child: TextField(
                      style: const TextStyle( fontSize: 17,
                          fontWeight: FontWeight.bold,),
                      textAlign: TextAlign.center,
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  Container(
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Colors.grey,
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        topLeft: Radius.circular(8),
                      ),
                    ),
                    child: DropdownButton(
                      hint: const Text('Select currency'),
                      isExpanded: true,
                      underline: const SizedBox(),
                      dropdownColor: Colors.white,
                      value: chooseSecond,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 36,
                      elevation: 16,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 22),
                      onChanged: (String? newValue) {
                        setState(() {
                          chooseSecond = newValue!;
                        });
                      },
                      items: countries.map((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value, textAlign: TextAlign.center,),
                        );
                      }).toList(),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      width: 400,
                      height: 51,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: Colors.grey,
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                      // 통화 값 계산 convertResult! = ;
                      child: Text("$convertResult",
                        style: const TextStyle( fontSize: 17,
                            fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
