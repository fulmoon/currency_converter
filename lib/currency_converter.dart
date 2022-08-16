import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'currency_api.dart';

class CurrencyConvert extends StatefulWidget {
  const CurrencyConvert({Key? key}) : super(key: key);

  @override
  State<CurrencyConvert> createState() => _CurrencyConvertState();
}

class _CurrencyConvertState extends State<CurrencyConvert> {
  final _api = CurrencyApi();
  final TextEditingController _controller = TextEditingController(text: "1");

  Map<String, dynamic> currencyList = {};
  List<String> countries = ["USD", "AED", "AFN", "ALL", "AMD", "KRW"];
  List<double> currencies = [1, 3.6725, 89.7035, 113.5506, 405.3498, 300.8174];

  String chooseFirst = 'USD';
  String chooseSecond = 'KRW';

  double selectedCurrency  = 1.0;
  double convertResult = 0.0;

  @override
  void initState() {
    super.initState();
    fetchCurrencies();
  }

  Future fetchCurrencies() async {
    currencyList = await _api.getCurrencies();
    countries = currencyList.keys.toList();
    currencies = currencyList.values.toList().cast<double>();
  }

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
                    child: FutureBuilder<Map<String, dynamic>>(
                        future: _api.getCurrencies(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text('에러가 났습니다.'),
                            );
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (!snapshot.hasData) {
                            return const Center(
                              child: Text('데이터가 없습니다.'),
                            );
                          }
                          final currencyList = snapshot.data!;
                          // print(currencyList);

                          return DropdownButton(
                            hint: const Text('Select currency'),
                            isExpanded: true,
                            underline: const SizedBox(),
                            dropdownColor: Colors.white,
                            value: chooseFirst,
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 36,
                            elevation: 16,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 22),
                            onChanged: (String? newValue) {
                              setState(() {
                                chooseFirst = newValue!;
                                selectedCurrency = currencyList['chooseFirst'];
                              });
                            },

                            items: countries.map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(
                                  value,
                                  textAlign: TextAlign.center,
                                ),
                              );
                            }).toList(),
                          );
                        }),
                  ),
                  Flexible(
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                        //FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          selectedCurrency = selectedCurrency * double.parse(value);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text('=',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
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
                    child: FutureBuilder<Map<String, dynamic>>(
                        future: _api.getCurrencies(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text('에러가 났습니다.'),
                            );
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (!snapshot.hasData) {
                            return const Center(
                              child: Text('데이터가 없습니다.'),
                            );
                          }
                          final currencyList = snapshot.data!;
                          // print(currencyList);

                          return DropdownButton(
                            hint: const Text('Select currency'),
                            isExpanded: true,
                            underline: const SizedBox(),
                            dropdownColor: Colors.white,
                            value: chooseFirst,
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 36,
                            elevation: 16,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 22),
                            onChanged: (String? newValue) {
                              setState(() {
                                chooseSecond = newValue!;
                                selectedCurrency = currencyList['chooseFirst'];
                              });
                            },

                            items: countries.map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(
                                  value,
                                  textAlign: TextAlign.center,
                                ),
                              );
                            }).toList(),
                          );
                        }),
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
                      child: Text(
                        "$convertResult",
                        style: const TextStyle(
                          fontSize: 17,
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
