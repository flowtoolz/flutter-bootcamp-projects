import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;
import 'dart:convert';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  @override
  void initState() {
    super.initState();
    select(newCurrency: selectedCurrency);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: cryptoList.map((e) => PriceDisplay(
                displayText: '1 $e = ${priceTagOf(crypto: e)} $selectedCurrency'
            )).toList()
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidPicker(),
          ),
        ],
      ),
    );
  }

  String priceTagOf({required String crypto}) {
    final price = cryptoPrice[crypto];
    if (price != null) { return price.toStringAsFixed(2); }
    return '<No price info>'; 
  }

  CupertinoPicker iosPicker() {
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32,
      onSelectedItemChanged: (newCurrencyIndex) async {
        select(newCurrency: currenciesList[newCurrencyIndex]);
      },
      children: currenciesList.map((currency) => Text(currency)).toList(),
    );
  }

  DropdownButton androidPicker() {
    return DropdownButton<String>(
      value: selectedCurrency,
      items: currenciesList.map((currency) => DropdownMenuItem(
        value: currency, 
        child: Text(currency)
      )).toList(),
      onChanged: ((newCurrency) {
        select(newCurrency: newCurrency ?? 'USD');
      }),
    );
  }

  void select({required String newCurrency}) async {

    Map<String, double> newCryptoPrice = {};

    for (String crypto in cryptoList) {
      newCryptoPrice[crypto] = await requestPrice(coin: crypto, currency: newCurrency);
    }

    setState(() {
      selectedCurrency = newCurrency;
      cryptoPrice = newCryptoPrice;
    });
  }


  Map<String, double> cryptoPrice = {};
  String selectedCurrency = currenciesList.first;
}

class PriceDisplay extends StatelessWidget {
  const PriceDisplay({required this.displayText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            displayText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  final String displayText;
}

Future<double> requestPrice({required String coin, required String currency}) async {
  final response = await http.get(
    Uri.parse('https://rest.coinapi.io/v1/exchangerate/$coin/$currency'), 
    headers: { 'X-CoinAPI-Key': apiKey }
  );

  if (response.statusCode != 200) {
    throw 'http error ${response.statusCode}';
  }

  final double price = jsonDecode(response.body)['rate'];

  print(price);
  
  return price;
}

const String apiKey = 'C734D995-7F3C-40E4-B93A-27AA256E7D81';