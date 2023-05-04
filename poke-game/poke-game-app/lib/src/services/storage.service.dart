import 'dart:convert';

import 'package:localstorage/localstorage.dart';
import 'package:pokedex_flutter/src/models/pokemon.dart';
import 'package:pokedex_flutter/src/utils/constants.dart';

class StorageService {
  late LocalStorage storage;
  StorageService() {
    this.storage = new LocalStorage(POKE_GAME_KEY);
  }

  List<Pokemon> listPokemons() {
    List<Pokemon> result = [];
    List<dynamic> jsonList = [];
    var data = storage.getItem(POKEMONS_KEY);
    if (data != null) {
      jsonList = jsonDecode(data);
      jsonList.forEach((e) => result.add(Pokemon.fromJson(e)));
    }
    return result;
  }

  void addPokemon(Pokemon pokemon) {
    var list = listPokemons();
    list.add(pokemon);
    var jsonList = [];
    list.forEach((e) => jsonList.add(e.toJson()));
    storage.setItem(POKEMONS_KEY, jsonEncode(jsonList));
  }

  void removePokemon(int id) {
    var list = listPokemons();
    var jsonList = [];
    list.forEach((e) {
      if (e.id != id) jsonList.add(e.toJson());
    });
    storage.setItem(POKEMONS_KEY, jsonEncode(jsonList));
  }
}
