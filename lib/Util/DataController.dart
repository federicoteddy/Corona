import 'package:coronaApp/model/Country.dart';
import 'package:coronaApp/model/Summary.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class DataController {
  String baseUrl = "https://api.covid19api.com/";

  Future<Summary> getSummary() async {
    final response = await http.get(baseUrl + "summary");
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print("response = " + response.body);
      return Summary.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load summary');
    }
  }

  Future<List<Country>> getLatestUpdateByCountry() async {
    final response = await http.get(baseUrl + "total/country/malaysia");
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print("response = " + response.body);
      return (response.body as List).map((e) => Country.fromJson(e)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load summary');
    }
  }
}
