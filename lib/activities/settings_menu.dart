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
  var _amountDropdownValue = "6";
  var _diffDropdownValue = "medium";

  void amountDropdownCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() => _amountDropdownValue = selectedValue);
    }
  }

  void diffDropdownCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() => _diffDropdownValue = selectedValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Center(
          child: Column(children: [
            const Text("Amount of questions per card:"),
            DropdownButton<String>(
              items: amoutQ
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              value: _amountDropdownValue,
              onChanged: amountDropdownCallback,
            ),
            const Text("Question difficulty:"),
            DropdownButton<String>(
              items: difficulty
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              value: _diffDropdownValue,
              onChanged: diffDropdownCallback,
            ),
          ]),
        ),
      ),
    );
  }
}
