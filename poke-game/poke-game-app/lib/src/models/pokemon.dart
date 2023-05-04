import 'dart:convert';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';

Future<Pokemon> fetchPokemon(id) async {
  try {
    final response = await http.get(Uri.parse("$URL_API/pokemon?id=$id"));

    if (response.statusCode == 200) {
      return Pokemon.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load Pokémon.");
    }
  } catch (ex) {
    print('Falha ao carregar pokémon');
    print(ex);
    return {} as Pokemon;
  }
}

class PokemonType {
  final String name;
  final int slot;
  final String url;

  PokemonType({required this.name, required this.slot, required this.url});

  Map<String, dynamic> toJson() =>
      {'name': this.name, 'slot': this.slot, 'url': this.url};

  static List<dynamic> toJsonList(List<PokemonType> list) {
    var result = [];
    list.forEach((e) => result.add(e.toJson()));
    return result;
  }
}

class PokemonStat {
  final String name;
  final int value;
  final int effort;

  PokemonStat({required this.name, required this.value, required this.effort});

  Map<String, dynamic> toJson() =>
      {'name': this.name, 'value': this.value, 'effort': this.effort};

  static List<dynamic> toJsonList(List<PokemonStat> list) {
    var result = [];
    list.forEach((e) => result.add(e.toJson()));
    return result;
  }
}

class Pokemon {
  final int id;
  final String name;
  final String image;
  final int experience;
  final int height;
  final int weight;
  final List<PokemonStat> stats;
  final List<PokemonType> types;

  Pokemon(
      {required this.id,
      required this.name,
      required this.image,
      required this.experience,
      required this.height,
      required this.weight,
      required this.stats,
      required this.types});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    String name = json['name'];
    List<PokemonStat> stats = [];
    List<PokemonType> types = [];
    (json['stats'] as List<dynamic>).forEach((s) {
      stats.add(
          PokemonStat(effort: s['effort'], name: s['name'], value: s['value']));
    });
    (json['types'] as List<dynamic>).forEach((t) {
      types.add(PokemonType(name: t['name'], slot: t['slot'], url: t['url']));
    });
    return Pokemon(
        id: json['id'],
        name: name.toUpperCase(),
        image: "$URL_API/pokemon/image?id=${json['id']}",
        experience: json['experience'],
        weight: json['weight'],
        height: json['height'],
        stats: stats,
        types: types);
  }

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'name': this.name,
        'image': this.image,
        'experience': this.experience,
        'weight': this.weight,
        'height': this.height,
        'stats': PokemonStat.toJsonList(this.stats),
        'types': PokemonType.toJsonList(this.types),
      };
}
