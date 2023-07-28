import 'dart:convert';
import 'package:api_test/data/simpsons_api_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Screens/web_view.dart';
import '../resources/color_manager.dart';

class SimpsonsCharacter extends StatefulWidget {
  final List<dynamic> characters;
  const SimpsonsCharacter({super.key, required this.characters});

  @override
  _SimpsonsCharacterState createState() => _SimpsonsCharacterState();
}

class _SimpsonsCharacterState extends State<SimpsonsCharacter> {
  List<dynamic> _characters = [];
  bool _isLoading = false;
  String? characterName;

  // Function to fetch data from the API
  Future<void> fetchData() async {
    setState(() {
      _isLoading = true;
    });

    final simpsonsApiService = SimpsonApiService();
    _characters = await simpsonsApiService.fetchData();

    setState(() {
      _isLoading = false;
    });
    print('Failed to parse data');
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(
            color: ColorManager.orange,
          ))
        : Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: ListView.builder(
                itemCount: _characters.length,
                itemBuilder: (context, index) {
                  final character = _characters[index]['FirstURL'];
                  final characterName = _characters[index]['Text'];
                  final characterDescription = _characters[index]['Result'];
                  final iconUrl = _characters[index]['Icon']['URL'];

                  // Extracting the character's name from the HTML string
                  final nameStart = characterDescription.indexOf('">') + 2;
                  final nameEnd = characterDescription.indexOf('</a>');
                  final name =
                      characterDescription.substring(nameStart, nameEnd);

                  // Extracting the character's description from the HTML string
                  final descriptionStart =
                      characterDescription.indexOf('</a><br>') + 9;
                  final descriptionEnd = characterDescription.length;
                  final description = characterDescription.substring(
                      descriptionStart, descriptionEnd);

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 5,
                      shadowColor: ColorManager.yellow,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 0.4,
                          color: ColorManager.whiteGreen,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                      ),
                      color: ColorManager.fiveDarkBlue,
                      child: ListTile(
                        leading: iconUrl.isNotEmpty
                            ? Image.network('https://duckduckgo.com$iconUrl')
                            : Icon(
                                Icons.person,
                                size: 32,
                                color: ColorManager.orange,
                              ), // Show a default icon if icon URL is empty
                        title: Text(
                          name,
                          style: TextStyle(
                              color: ColorManager.darkOrange,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(description,
                            style: GoogleFonts.amethysta(
                              textStyle:
                                  TextStyle(color: ColorManager.whiteGreen),
                            )),
                        onTap: () {
                          // Navigate to the character's URL when the tile is tapped
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WebViewApp(
                                        character: character,
                                        characterName: name,
                                        // Pass the character URL to WebViewApp
                                      )));
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          );
  }
}
