class Coin {
  Coin(
      {required this.id,
      required this.symbol,
      required this.name,
      required this.price});
  final String id;
  final String symbol;
  final String name;
  final double price;

  factory Coin.fromJson(Map<String, dynamic> data) {
    final id = data['id'] as String;
    final symbol = data['symbol'] as String;
    final name = data['name'] as String;
    final price = data['market_data']['current_price']['usd'].toDouble();

    return Coin(id: id, symbol: symbol, name: name, price: price);
  }
}
