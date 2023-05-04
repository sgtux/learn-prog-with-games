import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Home")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text("Meus Pokémons"),
                onPressed: () {
                  Navigator.pushNamed(context, '/list');
                },
              ),
              ElevatedButton(
                child: Text("Loja"),
                onPressed: () {
                  Navigator.pushNamed(context, '/shop');
                },
              )
            ],
          ),
        ));
  }
}
