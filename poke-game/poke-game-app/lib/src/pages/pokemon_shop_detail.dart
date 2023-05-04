import 'package:flutter/material.dart';
import 'package:pokedex_flutter/src/services/storage.service.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/pokemon.dart';

class PokemonShopDetail extends StatefulWidget {
  final int id;
  PokemonShopDetail({Key? key, required this.id}) : super(key: key);

  @override
  _PokemonShopDetailState createState() => _PokemonShopDetailState(id: id);
}

class _PokemonShopDetailState extends State<PokemonShopDetail> {
  late Future<Pokemon> futurePokemon;
  final int id;
  final StorageService service = new StorageService();

  _PokemonShopDetailState({required this.id});

  @override
  void initState() {
    super.initState();
    futurePokemon = fetchPokemon(id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: service.storage.ready,
      builder: (BuildContext context, snapshot) {
        return Container(
          child: FutureBuilder<Pokemon>(
            future: futurePokemon,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Pokemon pokemon = snapshot.data!;
                return Card(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                  SizedBox(height: 10, width: 160),
                  Text(
                    "${pokemon.id} - ${pokemon.name}",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Row(mainAxisSize: MainAxisSize.min, children: [
                    SizedBox(width: 20),
                    FadeInImage.memoryNetwork(
                        height: 100,
                        placeholder: kTransparentImage,
                        image: '${pokemon.image}'),
                    SizedBox(width: 20),
                  ]),
                  Row(mainAxisSize: MainAxisSize.min, children: [
                    SizedBox(width: 10),
                    Text(
                      "\$${pokemon.experience}",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        List<Pokemon> pokemons = service.listPokemons();

                        bool contains = false;
                        pokemons.forEach((e) {
                          if (e.id == pokemon.id) contains = true;
                        });

                        if (contains) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Você já comprou este pokémon!')));
                        } else {
                          service.addPokemon(pokemon);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('${pokemon.name} adquirido!')));
                        }
                      },
                      child: Text("Comprar"),
                    ),
                  ]),
                ]));
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              } else {
                return Card(
                  child: Column(children: [
                    SizedBox(width: 160, height: 75),
                    CircularProgressIndicator(),
                    SizedBox(width: 160, height: 75),
                  ]),
                );
              }
            },
          ),
        );
      },
    );
  }
}
