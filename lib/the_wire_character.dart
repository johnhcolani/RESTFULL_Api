
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
class TheWireCharacter extends StatefulWidget {
  @override
  _TheWireCharacterState createState() => _TheWireCharacterState();
}

class _TheWireCharacterState extends State<TheWireCharacter> {
  List<dynamic> _characters = [];
  bool _isLoading = false;

  // Function to fetch data from the API
  Future<void> fetchData() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.get(Uri.parse(
        'http://api.duckduckgo.com/?q=the+wire+characters&format=json'));

    if (response.statusCode == 200) {
      final parsedResponse = jsonDecode(response.body);
      if (parsedResponse['RelatedTopics'] != null) {
        setState(() {
          _characters = parsedResponse['RelatedTopics'];
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        print('Failed to parse data');
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      print('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Expanded(
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
          final name = characterDescription.substring(nameStart, nameEnd);

          // Extracting the character's description from the HTML string
          final descriptionStart = characterDescription.indexOf('</a><br>') + 9;
          final descriptionEnd = characterDescription.length;
          final description =
          characterDescription.substring(descriptionStart, descriptionEnd);

          return ListTile(
            leading: iconUrl.isNotEmpty
                ? Image.network('https://duckduckgo.com$iconUrl')
                : Icon(Icons.person),
            // Show a default icon if icon URL is empty
            title: Text(name),
            subtitle: Text(description),
            onTap: () {
              // Navigate to the character's URL when the tile is tapped
              launchURL(character);
            },
          );
        },
      ),
    );
  }

// Function to launch the character's URL
  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

}