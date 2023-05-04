import 'package:flutter/material.dart';
import 'package:pokedex_flutter/src/pages/pokemon_detail.dart';
import 'package:pokedex_flutter/src/pages/pokemon_shop.dart';

import 'src/pages/pokemon_list.dart';
import 'src/pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokédex',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/shop',
      routes: {
        '/': (context) => Home(),
        '/shop': (context) => PokemonShop(),
        '/list': (context) => PokemonList(),
        '/details': (context) => PokemonDetail()
      },
    );
  }
}
