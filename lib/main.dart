import 'dart:convert';
import 'package:api_test/sympsons_character.dart';
import 'package:api_test/the_wire_character.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


void main() {
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _selectedCharacterType = 'Simpsons';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Character Selection'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton<String>(
                value: _selectedCharacterType,
                items: const <DropdownMenuItem<String>>[
                  DropdownMenuItem(
                    value: 'Simpsons',
                    child: Text('Simpsons Characters'),
                  ),
                  DropdownMenuItem(
                    value: 'TheWire',
                    child: Text('The Wire Characters'),
                  ),
                ],
                onChanged: (newValue) {
                  setState(() {
                    _selectedCharacterType = newValue!;
                  });
                },
              ),
              _selectedCharacterType == 'Simpsons'
                  ? SimpsonsCharacter()
                  : TheWireCharacter(),
            ],
          ),
        ),
      ),
    );
  }
}

