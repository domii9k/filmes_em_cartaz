import 'package:http/http.dart' as http;

abstract class GetHttpClient {
  Future get({required String url, String? token});
}

class HttpClient {
  final client = http.Client();

  Future get({required String url, String? token}) async {
    // Cria os headers básicos
    Map<String, String> headers = {'Content-Type': 'application/json'};

    // Se o token foi fornecido, adiciona ao header Authorization
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    return await client.get(Uri.parse(url), headers: headers);
  }
}
