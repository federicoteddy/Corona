import 'package:coronaApp/SummaryUpdateCard.dart';
import 'package:coronaApp/Util/Colors.dart';
import 'package:coronaApp/Util/DateUtils.dart';
import 'package:coronaApp/Util/NumberUtil.dart';
import 'package:coronaApp/model/CountryStatus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class BodyDetailCountry extends StatefulWidget {
  final List<CountryStatus> countryList;

  BodyDetailCountry({this.countryList});

  @override
  _BodyDetailCountryState createState() => _BodyDetailCountryState();
}

class _BodyDetailCountryState extends State<BodyDetailCountry>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);

    animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var list = widget.countryList;
    var latestWeeklyList = list.getRange(list.length - 8, list.length).toList();
    var lastUpdate = list.last;
    var confirmedWeekly = List<SalesData>();
    var deathWeekly = List<SalesData>();
    var recoveredWeekly = List<SalesData>();
    var activeWeekly = List<SalesData>();
    var yesterdayValue = list[list.length - 2];
    var newPositiveCase = lastUpdate.confirmed - yesterdayValue.confirmed;
    var deathRate = ((lastUpdate.deaths /
        lastUpdate.confirmed) *
        100);

    latestWeeklyList.forEach((element) {
      confirmedWeekly.add(SalesData(DateUtils().dateToDateTime(element.date,DateUtils().ddMm), element.confirmed));
//      deathWeekly.add(SalesData(DateUtils().dateToDateTime(element.date,DateUtils().ddMm), element.deaths));
//      recoveredWeekly.add(SalesData(DateUtils().dateToDateTime(element.date,DateUtils().ddMm), element.recovered));
//      activeWeekly.add(SalesData(DateUtils().dateToDateTime(element.date,DateUtils().ddMm), element.active));
    });

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //WeeklyChart(),
                  SfCartesianChart(
                      tooltipBehavior: TooltipBehavior(
                          enable: true,
                          header: "Total Confirmed Case"
                      ),
                      primaryXAxis: CategoryAxis(
                          isVisible: true,
                          majorGridLines: MajorGridLines(
                              color: Colors.transparent
                          ),
                          labelStyle: TextStyle(color: Colors.white),
                          axisLine: AxisLine(color: Colors.transparent)),
                      primaryYAxis: NumericAxis(
                          isVisible: false,
                          numberFormat: NumberFormat.decimalPattern(),
                          labelStyle: TextStyle(color: Colors.white),
                          axisLine: AxisLine(color: Colors.white)),
                      plotAreaBorderWidth: 0,
                      plotAreaBorderColor: Colors.white,
                      series: <ChartSeries>[
                        // Initialize line series
                        ColumnSeries<SalesData, String>(
                            color: Colors.white,
                            dataSource: confirmedWeekly,
                            xValueMapper: (SalesData sales, _) =>
                            sales.year,
                            yValueMapper: (SalesData sales, _) =>
                            sales.sales,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            enableTooltip: true
                        )
                      ]),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("New Positive Case",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600)),
                            Row(
                              children: <Widget>[
                                Icon(
                                  IconData(0xe9e2,
                                      fontFamily: "icomoon"),
                                  size: 30,
                                  color: Colors.white,
                                ),
                                AnimatedBuilder(
                                  animation: animationController,
                                  builder: (BuildContext context, Widget child) {
                                    return Text(
                                        NumberUtil()
                                            .setDecimalFormat(_valueAnimator(newPositiveCase.toDouble()).toInt()),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 42,
                                            fontWeight: FontWeight.bold));
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Align(
                              child: Text("Death Rate",
                                  style:
                                  TextStyle(color: Colors.white)),
                              alignment: Alignment.topRight,
                            ),
                            AnimatedBuilder(
                              animation: animationController,
                              builder: (BuildContext context, Widget child) {
                                return Text(
                                   _valueAnimator(deathRate).toStringAsFixed(1)+"%",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 42,
                                        fontWeight: FontWeight.bold));
                              },
                            ),

                          ],
                        )
                      ],
                    ),
                  ),
                ],
              )),
          SizedBox(
              width: size.width,
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    padding: EdgeInsets.only(top: 16,bottom: 16),
                    decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24))),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, top: 16.0),
                            child: Text("SUMMARY UPDATE",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w400)),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                  DateUtils().dateToDateTime(lastUpdate.date,DateUtils().dateFullFormat),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700))),
                          SummaryUpdateCard(
                              title: "Total Confirmed Case",
                              icon: IconData(0xe9df, fontFamily: "icomoon"),
                              value: lastUpdate.confirmed,
                              color: BlueColor,
                              newCaseValue: lastUpdate.confirmed -
                                  yesterdayValue.confirmed),
                          SummaryUpdateCard(
                              title: "Total Death Case",
                              icon: IconData(0xe9a3, fontFamily: "icomoon"),
                              value: lastUpdate.deaths,
                              color: RedColor,
                              newCaseValue:
                                  lastUpdate.deaths - yesterdayValue.deaths),
                          SummaryUpdateCard(
                              title: "Total Recovered Case",
                              icon: IconData(0xe9c5, fontFamily: "icomoon"),
                              value: lastUpdate.recovered,
                              color: GreenColor,
                              newCaseValue: lastUpdate.recovered -
                                  yesterdayValue.recovered),
                          SummaryUpdateCard(
                              title: "Total Active Case",
                              icon: IconData(0xe9d6, fontFamily: "icomoon"),
                              value: lastUpdate.active,
                              color: OrangeColor,
                              newCaseValue:
                                  lastUpdate.active - yesterdayValue.active),

                        ]),
                  ),

                ],
              ))
        ],
      ),
    );
  }
  double _valueAnimator(double value)
  {
    return Tween<double>(begin: 0, end: value).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut)).value;
  }
}


class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final int sales;
}
