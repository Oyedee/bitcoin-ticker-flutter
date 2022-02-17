import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../services/coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String btc = cryptoList[0];
  String eth = cryptoList[1];
  String ltc = cryptoList[2];

  CoinData coinData = CoinData();

  String currencyId;
  String cryptoId;
  int exchangeRate;
  int btcRate;
  int ethRate;
  int ltcRate;

  @override
  void initState() {
    super.initState();
    updateBtc();
    updateEth();
    updateLtc();
  }

  void updateUI(String selectedCrypto, String selectedCurrency) async {
    var cryptoData =
        await coinData.getCoinData(selectedCrypto, selectedCurrency);
    if (cryptoData == null) {
      return;
    }

    setState(() {
      double rate = cryptoData['rate'];
      exchangeRate = rate.toInt();
      cryptoId = cryptoData['asset_id_base'];
      currencyId = cryptoData['asset_id_quote'];
    });
  }

  void updateBtc() async {
    var cryptoData = await coinData.getCoinData(btc, selectedCurrency);
    if (cryptoData == null) {
      return;
    }

    setState(() {
      double rate = cryptoData['rate'];
      btcRate = rate.toInt();
      cryptoId = cryptoData['asset_id_base'];
      currencyId = cryptoData['asset_id_quote'];
    });
  }

  void updateEth() async {
    var cryptoData = await coinData.getCoinData(eth, selectedCurrency);
    if (cryptoData == null) {
      return;
    }
    setState(() {
      double rate = cryptoData['rate'];
      ethRate = rate.toInt();
      cryptoId = cryptoData['asset_id_base'];
      currencyId = cryptoData['asset_id_quote'];
    });
  }

  void updateLtc() async {
    var cryptoData = await coinData.getCoinData(ltc, selectedCurrency);
    if (cryptoData == null) {
      return;
    }
    setState(() {
      double rate = cryptoData['rate'];
      ltcRate = rate.toInt();
      cryptoId = cryptoData['asset_id_base'];
      currencyId = cryptoData['asset_id_quote'];
    });
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );

      dropdownItems.add(newItem);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          updateBtc();
          updateEth();
          updateLtc();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];

    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: pickerItems,
    );
  }

  /*Widget getPicker() {
  we used a tenary operator instead, that is why
  this is commented out.
    if (Platform.isIOS) {
      return iOSPicker();
    } else if (Platform.isAndroid) {
      return androidDropdown();
    }
  }*/

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
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 $btc = $btcRate $currencyId',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 $eth = $ethRate $currencyId',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 $ltc = $ltcRate $currencyId',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: androidDropdown(),
            //child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
