import 'dart:convert';
import 'package:Quizzy/services/quizModel.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String _apiUrl = dotenv.env['API_KEY'] ?? '';

  Future<Quiz> fetchQuizData() async {
    final response = await http.get(Uri.parse(_apiUrl));

    if (response.statusCode == 200) {
      return Quiz.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load quiz data');
    }
  }
}
