import 'package:flutter/material.dart';

import 'pokemon_shop_detail.dart';
import '../models/pokemon.dart';

class PokemonShop extends StatefulWidget {
  PokemonShop({Key? key}) : super(key: key);

  @override
  _PokemonShopState createState() => _PokemonShopState();
}

Container buildContainer(startId) {
  return Container(
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Center(child: PokemonShopDetail(id: startId)),
            Center(child: PokemonShopDetail(id: startId + 1)),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Center(child: PokemonShopDetail(id: startId + 2)),
            Center(child: PokemonShopDetail(id: startId + 3)),
          ]),
        ],
      ),
    ),
  );
}

class _PokemonShopState extends State<PokemonShop> {
  late Future<Pokemon> futurePokemon;

  List<Widget> list = [];
  int lastId = 12;

  @override
  void initState() {
    super.initState();
    list.add(buildContainer(1));
    list.add(buildContainer(5));
    list.add(buildContainer(9));
  }

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 0);

    return Scaffold(
      appBar: AppBar(
        title: Text('Loja Pokémon'),
      ),
      body: PageView(
          scrollDirection: Axis.horizontal,
          controller: controller,
          onPageChanged: (index) {
            if (((index + 2) * 4) > lastId) {
              lastId = lastId + 4;
              list.add(buildContainer(lastId - 3));
            }
          },
          children: list),
      backgroundColor: Colors.red.shade200,
    );
  }
}
