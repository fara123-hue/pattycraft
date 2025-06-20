import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
    static const String _baseUrl = 
        'https://www.themealdb.com/api/json/v1/1/search.php?s=burger';

    static Future<List<dynamic>> fetchBurgers() async {
        final response = await http.get(Uri.parse(_baseUrl));
        if (response.statusCode == 200) {
            final data = json.decode(response.body);
            return data['meals']; // List of burger items
        } else {
            throw Exception('Failed to load burger data');
        }
    }
}