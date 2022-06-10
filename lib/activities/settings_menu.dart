//Settings widget

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:brnl3r/services/implementation/fetch_settings.dart';

class SettingsMenu extends StatefulWidget {
  const SettingsMenu({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingsMenuState();
}

class _SettingsMenuState extends State<SettingsMenu> {
  static const List<String> amoutQ = ["3", "4", "5", "6", "7", "8", "9", "10"];
  static const List<String> difficulty = ["easy", "medium", "hard"];
  String _amountDropdownValue = amoutQ[3];
  String _diffDropdownValue = difficulty[1];

  //run storage code on widget launch
  @override
  void initState() {
    getData();
    super.initState();
  }

  //get settings data from storage. If null, use default
  void getData() async {
    String? storedAmoutQ = await FetchSettings().getData("amoutQ");
    String? storedDifficulty = await FetchSettings().getData("difficulty");

    setState(() {
      if (storedAmoutQ is String) {
        _amountDropdownValue = storedAmoutQ;
      }

      if (storedDifficulty is String) {
        _diffDropdownValue = storedDifficulty;
      }
    });
  }

  //store settings data
  void setData() async {
    FetchSettings().setData("amoutQ", _amountDropdownValue);
    FetchSettings().setData("difficulty", _diffDropdownValue);
  }

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
    return WillPopScope(
      onWillPop: (() async {
        setData();
        return true;
      }),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Center(
            child: Column(children: [
              const Text("Number of questions per card:"),
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
      ),
    );
  }
}
