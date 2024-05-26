import 'dart:convert';
import 'package:http/http.dart' as http;

class Request {
  Map<String, String> headers = {
    "Content-type": "application/json",
    "apikey":
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1waGpocHNiY3FwZ3FpbHNoeHdlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTU4NjU4MzMsImV4cCI6MjAzMTQ0MTgzM30.71aen4dlTR0RJCLa1oRa1UHgTpInQoCaeOXFGP2SHdY"
  };
  final String baseUrl = "https://mphjhpsbcqpgqilshxwe.supabase.co/rest/v1";
  Future<dynamic> get(String url) async {
    final uri = Uri.parse(baseUrl + url);
    var response = await http.get(uri, headers: headers);
    return response;
  }

  Future<dynamic> post(String url, dynamic body) async {
    final uri = Uri.parse(baseUrl + url);
    var response =
        await http.post(uri, headers: headers, body: json.encode(body));
    return response;
  }

  Future<dynamic> put(String url, dynamic body) async {
    final uri = Uri.parse(baseUrl + url);
    var response =
        await http.put(uri, headers: headers, body: json.encode(body));
    return response;
  }

  Future<dynamic> delete(String url) async {
    final uri = Uri.parse(baseUrl + url);
    var response = await http.delete(uri, headers: headers);
    return response;
  }
}
