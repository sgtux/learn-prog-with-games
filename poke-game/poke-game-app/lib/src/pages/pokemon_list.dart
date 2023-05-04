import 'package:flutter/material.dart';
import 'package:pokedex_flutter/src/components/progressbar.dart';
import 'package:pokedex_flutter/src/models/pokemon.dart';
import 'package:pokedex_flutter/src/services/storage.service.dart';
import 'package:pokedex_flutter/src/utils/helpers.dart';
import 'package:transparent_image/transparent_image.dart';

typedef RemoveCallback = void Function(int id);

Container pokemonList(
    List<Pokemon> list, RemoveCallback callback, BuildContext context) {
  if (list.length == 0) {
    return Container(child: Text("Você não possui pokémons."));
  }
  List<Card> items = [];

  list.forEach((e) {
    items.add(Card(
        color: getColorFromPokemonType(e),
        child: ListTile(
          onTap: () {
            Navigator.pushNamed(context, '/details', arguments: e);
          },
          leading: FadeInImage.memoryNetwork(
              height: 60, placeholder: kTransparentImage, image: e.image),
          title: Text(e.name),
          subtitle: ProgressBar(
            height: 8,
            width: 200,
            value: (200 * e.experience) / 400,
          ),
        )));
  });

  return Container(
      color: Colors.red.shade200,
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: items,
      ));
}

class PokemonList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  final StorageService service = new StorageService();
  late List<Pokemon> list;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: service.storage.ready,
        builder: (BuildContext context, snapshot) {
          if (snapshot.data == true) {
            list = service.listPokemons();

            return Scaffold(
              appBar: AppBar(
                title: Text("Meus Pokémons"),
              ),
              body: pokemonList(list, (id) {
                service.removePokemon(id);
                setState(() => list = service.listPokemons());
              }, context),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
