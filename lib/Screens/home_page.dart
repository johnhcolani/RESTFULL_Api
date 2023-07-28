

import 'package:api_test/resources/color_manager.dart';
import 'package:flutter/material.dart';
import '../widgets/sympsons_character.dart';
import '../widgets/the_wire_character.dart';

class HomePage extends StatefulWidget {
  final List<dynamic> characters;

  const HomePage({super.key, required this.characters});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedCharacterType = 'Simpsons';
  List<dynamic> characters=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.darkBlue,
      appBar: AppBar(

        automaticallyImplyLeading:false,
        backgroundColor: ColorManager.darkBlue,
        title: const Center(
          child: Text(
            'Character Selection',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            DropdownButton<String>(
             isDense: false,
              isExpanded: false,
              dropdownColor: ColorManager.fiveDarkBlue,
              iconEnabledColor:ColorManager.orange,
              value: _selectedCharacterType,
              items:  <DropdownMenuItem<String>>[
                DropdownMenuItem(

                  value: 'Simpsons',
                  child: Text('Simpsons Characters',style: TextStyle(color: ColorManager.darkOrange),),
                ),
                DropdownMenuItem(
                  value: 'TheWire',
                  child: Text('The Wire Characters',style: TextStyle(color: ColorManager.darkOrange)),
                ),
              ],
              onChanged: (newValue) {
                setState(() {
                  _selectedCharacterType = newValue!;
                });
              },
            ),
            _selectedCharacterType == 'Simpsons'
                ? SimpsonsCharacter(characters:widget.characters)
                : TheWireCharacter(characters: widget.characters),
          ],
        ),
      ),
    );
  }

}