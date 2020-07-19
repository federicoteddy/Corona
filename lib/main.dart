import 'dart:async';

import 'package:coronaApp/Header.dart';
import 'package:coronaApp/Util/NumberUtil.dart';
import 'package:coronaApp/model/Country.dart';
import 'package:coronaApp/model/Summary.dart';
import 'package:flutter/material.dart';

import 'Util/Colors.dart';
import 'GlobalCaseCard.dart';

void main() {
  runApp(MyHomePage());
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<Summary> summary;
  Future<List<Country>> malaysia;
  final controller = ScrollController();
  double offset = 0;

  @override
  void initState() {
    super.initState();
    //fetchData();
    controller.addListener(onScroll);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: SingleChildScrollView(
        controller: controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Header(),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Container(
                child: Text("Latest Update : 19 July 2020 07:00 PM"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Wrap(
                runSpacing: 20,
                spacing: 20,
                children: <Widget>[
                  GlobalCaseCard(
                      title: "New Confirmed",
                      value: 20000,
                      icon: IconData(0xe9d6, fontFamily: "icomoon"),
                      color: GreenColor),
                  GlobalCaseCard(
                      title: "Total Confirmed",
                      value: 14002328,
                      icon: IconData(0xe9de, fontFamily: "icomoon"),
                      color: PrimaryColor),
                  GlobalCaseCard(
                      title: "New Death",
                      value: 5203,
                      icon: IconData(0xe980, fontFamily: "icomoon"),
                      color: RedColor),
                  GlobalCaseCard(
                      title: "Total Death",
                      value: 123423,
                      icon: IconData(0xe99b, fontFamily: "icomoon"),
                      color: OrangeColor),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

//  Future<void> fetchData() async {
//    summary = DataController().getSummary();
//    malaysia = DataController().getLatestUpdateByCountry();
//  }
//
//  List<DashboardGlobalItem> setDashboardInfo(Global global) {
//    return [
//      DashboardGlobalItem(
//          title: "New Confirmed Case",
//          value: global.newConfirmed,
//          icon: Icons.radio_button_checked,
//          color: Colors.red),
//      DashboardGlobalItem(
//          title: "Total Confirmed Case",
//          value: global.totalConfirmed,
//          icon: Icons.group,
//          color: Colors.black),
//      DashboardGlobalItem(
//          title: "New Death Case",
//          value: global.newDeaths,
//          icon: Icons.airline_seat_individual_suite,
//          color: Colors.blueGrey),
//      DashboardGlobalItem(
//          title: "Total Death Case",
//          value: global.totalDeaths,
//          icon: Icons.close,
//          color: Colors.black),
//      DashboardGlobalItem(
//          title: "New Recovered Case",
//          value: global.newRecovered,
//          icon: IconData(0xe97a, fontFamily: "icomoon"),
//          color: Colors.green),
//      DashboardGlobalItem(
//          title: "Total Recovered Case",
//          value: global.totalRecovered,
//          icon: Icons.sentiment_satisfied,
//          color: Colors.black)
//    ];
//  }
//
//  List<DashboardGlobalItem> setDashboardCountry(Countries countries) {
//    return [
//      DashboardGlobalItem(
//          title: countries.country + " Confirmed Case",
//          value: countries.newConfirmed,
//          date: "Latest Update : " + DateUtils().dateToDateTime(countries.date),
//          icon: Icons.radio_button_checked,
//          color: Colors.red)
//    ];
//  }
//
//  List<Widget> cardList = List<Widget>();
//
//  Container dashboard(List<Widget> widgetList) => Container(
//        child: Column(children: widgetList),
//      );
//
//  Card card(DashboardGlobalItem dashboardGlobalItem) => Card(
//      elevation: 2,
//      child: Container(
//        padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
//        decoration: BoxDecoration(borderRadius: new BorderRadius.circular(6)),
//        child: Container(
//          child: Column(
//            children: <Widget>[
//              Row(
//                children: <Widget>[
//                  Column(
//                    children: <Widget>[
//                      IconButton(
//                          icon: Icon(dashboardGlobalItem.icon,
//                              color: dashboardGlobalItem.color, size: 40))
//                    ],
//                  ),
//                  Padding(padding: EdgeInsets.only(right: 8.0)),
//                  Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>[
//                      Text(
//                        dashboardGlobalItem.title,
//                        style: TextStyle(color: Colors.black),
//                      ),
//                      Padding(padding: EdgeInsets.only(top: 5.0)),
//                      Text(
//                          NumberUtil()
//                              .setDecimalFormat(dashboardGlobalItem.value),
//                          style: TextStyle(
//                              fontSize: 30,
//                              fontWeight: FontWeight.bold,
//                              color: dashboardGlobalItem.color)),
//                      Padding(padding: EdgeInsets.only(top: 5.0)),
//                      Visibility(
//                        visible: dashboardGlobalItem.date != null,
//                        child: Text(
//                          dashboardGlobalItem.date ?? "",
//                          style: TextStyle(color: Colors.black),
//                        ),
//                      ),
//                    ],
//                  )
//                ],
//              ),
//            ],
//          ),
//        ),
//      ));
//
//  RefreshIndicator mainComponent() {
//    return RefreshIndicator(
//      onRefresh: fetchData,
//      child: CustomScrollView(
//        slivers: <Widget>[
//          SliverList(
//            delegate: SliverChildListDelegate([
//              Container(
//                margin:
//                    EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
//                child: Column(
//                  children: <Widget>[
//                    FutureBuilder<Summary>(
//                      future: summary,
//                      builder: (context, snapshot) {
//                        if (snapshot.hasData) {
//                          List<Widget> cardList = List<Widget>();
//                          cardList.add(card(setDashboardCountry(
//                                  snapshot.data.countries.firstWhere(
//                                      (element) => element.countryCode == "MY"))
//                              .first));
//                          cardList.add(card(setDashboardCountry(
//                                  snapshot.data.countries.firstWhere(
//                                      (element) => element.countryCode == "ID"))
//                              .first));
////                              setDashboardInfo(snapshot.data.global)
////                                  .forEach((element) {
////                                cardList.add(card(element));
////                              });
//                          return dashboard(cardList);
//                        } else {
//                          return CircularProgressIndicator();
//                        }
//                      },
//                    ),
//                  ],
//                ),
//              )
//            ]),
//          )
//        ],
//      ),
//    );
//  }
}
