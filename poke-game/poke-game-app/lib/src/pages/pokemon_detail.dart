import 'package:flutter/material.dart';
import 'package:pokedex_flutter/src/components/progressbar.dart';
import 'package:pokedex_flutter/src/models/pokemon.dart';
import 'package:pokedex_flutter/src/utils/helpers.dart';
import 'package:transparent_image/transparent_image.dart';

String normalizeName(String name) {
  return name.replaceAll('-', ' ').toUpperCase();
}

Column statsList(Pokemon pokemon) {
  List<Row> list = [];
  pokemon.stats.forEach((e) {
    list.add(Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      Text(
        normalizeName(e.name),
        style: TextStyle(),
      ),
      SizedBox(width: 10),
      ProgressBar(height: 10, width: 150, value: (150 * e.value) / 150),
      SizedBox(width: 10),
      Text(e.value.toString(), style: TextStyle()),
      SizedBox(width: 20),
    ]));
  });

  return Column(
    children: list,
  );
}

class PokemonDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pokemon = ModalRoute.of(context)!.settings.arguments as Pokemon;
    return Scaffold(
        appBar: AppBar(
          title: Text(pokemon.name),
        ),
        body: Container(
            color: Colors.red.shade200,
            child: Center(
                child: Card(
              color: getColorFromPokemonType(pokemon),
              child: Container(
                  height: 400,
                  width: 340,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${pokemon.id} - ${pokemon.name}",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                      FadeInImage.memoryNetwork(
                          height: 200,
                          width: 200,
                          placeholder: kTransparentImage,
                          image: pokemon.image),
                      Text(getPokemonTypes(pokemon)),
                      SizedBox(height: 10),
                      statsList(pokemon)
                    ],
                  )),
            ))));
  }
}
