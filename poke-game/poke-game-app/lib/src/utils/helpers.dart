import 'package:flutter/material.dart';
import 'package:pokedex_flutter/src/models/pokemon.dart';

Color getColorFromPokemonType(Pokemon pokemon) {
  List<String> list = [];
  pokemon.types.forEach((e) => list.add(e.name));
  if (list.contains('poison')) return Colors.green;
  if (list.contains('fire')) return Colors.orange.shade300;
  if (list.contains('water')) return Colors.blue.shade200;
  return Colors.white;
}

String getPokemonTypes(Pokemon pokemon) {
  List<String> list = [];
  pokemon.types.forEach((e) => list.add(e.name.toUpperCase()));
  return list.join(' - ');
}
