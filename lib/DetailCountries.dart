import 'package:coronaApp/BodyDetailCountry.dart';
import 'package:coronaApp/Util/DataController.dart';
import 'package:flutter/material.dart';

import 'Util/Colors.dart';
import 'model/Country.dart';
import 'model/CountryStatus.dart';

class DetailCountries extends StatefulWidget {
  DetailCountries({Key key, this.countryModel}) : super(key: key);
  final Country countryModel;

  @override
  _DetailCountriesState createState() => _DetailCountriesState();
}

class _DetailCountriesState extends State<DetailCountries> {
  Future<List<CountryStatus>> countryStatusList;

  @override
  void initState() {
    // TODO: implement initState
    countryStatusList =
        DataController().getLatestUpdateByCountry(widget.countryModel.slug);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PrimaryColor,
      appBar: AppBar(
        backgroundColor: PrimaryColor,
        elevation: 0,
        title: Text(widget.countryModel.country),
      ),
      body: FutureBuilder<List<CountryStatus>>(
          future: countryStatusList,
          builder: (context, snapshot) {
            print("snapshot country = "+snapshot.toString());
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return BodyDetailCountry(countryList: snapshot.data);
              } else {
                return Center(
                  child: CircularProgressIndicator(valueColor : AlwaysStoppedAnimation<Color>(Colors.white)),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(valueColor : AlwaysStoppedAnimation<Color>(Colors.white)),
              );
            }
          }),
    );
  }
}
