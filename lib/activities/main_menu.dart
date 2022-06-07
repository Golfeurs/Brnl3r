import 'package:brnl3r/activities/game_setup.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  final title = "BRNL3R";

  @override
  Widget build(BuildContext context) {
    final header = Expanded(
        flex: 1,
        //padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 30),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        )
      );

    final body = Expanded(
      flex: 2,
      child: Center(
        child: Column(
          children: [
            OutlinedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: 
                (_) => GameSetup(key: key,)
              )), child: const Text("START GAME")
            )
          ],
        ),
      ));

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.settings),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
        child: Column(children: [header, body]),
      )),
    );
  }
}
