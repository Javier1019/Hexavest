import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:hexavest/models/coin.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataService {
  Future<Coin> fetchCoin(String id) async {
    final response =
        await http.get(Uri.parse('https://api.coingecko.com/api/v3/coins/$id'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Coin.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Coin');
    }
  }

  Future<List<Coin>> fetchCoinArray() async {
    List<Coin> _coinInfo = <Coin>[];
    List<String> ids = ["star-atlas", "star-atlas-dao", "bitcoin"];
    for (var id in ids) {
      _coinInfo.add(await fetchCoin(id));
    }

    return _coinInfo;
  }
}
