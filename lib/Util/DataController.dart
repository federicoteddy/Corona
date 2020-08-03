import 'package:coronaApp/model/Country.dart';
import 'package:coronaApp/model/CountryStatus.dart';
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

  Future<List<Country>> getCountryList() async {
    final response = await http.get(baseUrl + "countries");
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print("response = " + response.body);
      return (json.decode(response.body) as List).map((e) => Country.fromJson(e)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load summary');
    }
  }

  Future<List<CountryStatus>> getLatestUpdateByCountry(String countryName) async {
    print("url = "+baseUrl + "country/" + countryName);
    final response = await http.get(baseUrl + "country/" + countryName);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print("response = " + response.body);
      return (json.decode(response.body) as List).map((e) => CountryStatus.fromJson(e)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load summary');
    }
  }
}
