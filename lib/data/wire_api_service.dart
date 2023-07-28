
import 'dart:convert';
import 'package:http/http.dart' as http;

class WireApiService {
  Future<List<dynamic>> fetchData() async {
    final response = await http.get(Uri.parse(
        'http://api.duckduckgo.com/?q=the+wire+characters&format=json'));

    if (response.statusCode == 200) {
      final parsedResponse = jsonDecode(response.body);
      if (parsedResponse['RelatedTopics'] != null) {
        return parsedResponse['RelatedTopics'];
      } else {
        print('Failed to parse data');
        return [];
      }
    } else {
      print('Failed to load data');
      return [];
    }
  }
}
