import 'package:bitcoin_ticker/services/networking.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const apiKey = '2513962F-9379-4592-9E0B-65BA11BF435E';
const baseUrl = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {
  String btc = cryptoList[0];
  String eth = cryptoList[1];
  String ltc = cryptoList[2];

  Future<dynamic> getCoinData(
      String cryptoAssetId, String currencyAssetId) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$baseUrl/$cryptoAssetId/$currencyAssetId?apikey=$apiKey');
    var coinData = await networkHelper.getData();
    return coinData;
  }
}
