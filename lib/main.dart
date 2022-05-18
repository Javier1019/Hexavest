import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'services/dataservice.dart';
import 'models/coin.dart';

final Map<int, Color> _lightgreenblueMap = {
  50: const Color.fromARGB(255, 0, 217, 255),
  100: const Color.fromARGB(255, 0, 217, 255),
  200: const Color.fromARGB(255, 0, 217, 255),
  300: const Color.fromARGB(255, 0, 217, 255),
  400: const Color.fromARGB(255, 0, 217, 255),
  500: const Color.fromARGB(255, 0, 217, 255),
  600: const Color.fromARGB(255, 0, 217, 255),
  700: const Color.fromARGB(255, 0, 217, 255),
  800: const Color.fromARGB(255, 0, 217, 255),
  900: const Color.fromARGB(255, 0, 217, 255),
};

final MaterialColor _lightgreenblueSwatch = MaterialColor(
    const Color.fromARGB(255, 0, 217, 255).value, _lightgreenblueMap);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hexavest',
      theme: ThemeData(
        primarySwatch: _lightgreenblueSwatch,
        canvasColor: const Color.fromARGB(255, 49, 49, 49),
      ),
      home: const MyHomePage(title: 'Hexavest'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final service = DataService();
  late Future<List<Coin>> futureCoin;

  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
        const Duration(seconds: 30), (Timer t) => updateFuture());
    futureCoin = service.fetchCoinArray();
  }

  void updateFuture() {
    setState(() {
      futureCoin = service.fetchCoinArray();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: FutureBuilder<List<Coin>>(
        future: futureCoin,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: ((context, index) {
                  return ListTile(
                    leading: Text(
                      snapshot.data![index].symbol,
                      style: const TextStyle(color: Colors.white),
                    ),
                    trailing: Text(
                      snapshot.data![index].name,
                      style: const TextStyle(color: Colors.white),
                    ),
                    title: Text(
                      "\$ ${snapshot.data![index].price.toString()}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }));
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      )),
    );
  }
}
