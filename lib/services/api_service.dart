import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<dynamic>> fetchMeals(String query) async {
    final url =
        'https://www.themealdb.com/api/json/v1/1/search.php?s=${Uri.encodeComponent(query)}';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['meals'] ?? [];
    } else {
      throw Exception('Failed to load meal data');
    }
  }
}
