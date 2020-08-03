import 'package:coronaApp/DetailCountries.dart';
import 'package:flutter/material.dart';

import 'Util/Colors.dart';
import 'Util/DataController.dart';
import 'model/Country.dart';

class CountryList extends StatefulWidget {
  CountryList({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CountryListState createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  List<Country> countryList = List<Country>();
  List<Country> countryListFilter = List<Country>();

  @override
  void initState() {
    super.initState();
    DataController().getCountryList().then((value) => setState(() {
      print("value = "+value.toString());
          countryList.addAll(value);
        }));
    countryListFilter = countryList;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: PrimaryColor,
          elevation: 0,
          title: Text("Search"),
        ),
        body: ListView.builder(
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailCountries(countryModel:countryListFilter[index - 1])),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: index == 0
                        ? searchBar()
                        : Text(countryListFilter[index - 1].country),
                  ));
            },
            itemCount: countryListFilter.length + 1));
  }

  searchBar() {
    return TextField(
      decoration: InputDecoration(hintText: "Country"),
      onChanged: (text) {
        text = text.toLowerCase();
        setState(() {
          countryListFilter = countryList.where((it) {
            var countryName = it.country.toLowerCase();
            return countryName.contains(text);
          }).toList();
        });
      },
    );
  }
}
