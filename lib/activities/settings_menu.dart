//Settings widget

import 'package:flutter/material.dart';

class SettingsMenu extends StatefulWidget {
  const SettingsMenu({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingsMenuState();
}

class _SettingsMenuState extends State<SettingsMenu> {
  List<String> amoutQ = ["3", "4", "5", "6", "7", "8", "9", "10"];
  List<String> difficulty = ["easy", "medium", "hard"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: const Center(child: Text("hello")),
    );
  }
}
