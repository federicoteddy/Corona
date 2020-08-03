import 'package:coronaApp/Util/NumberUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'Util/Colors.dart';

class SummaryUpdateCard extends StatefulWidget {
  final String title;
  final int value;
  final IconData icon;
  final Color color;
  final int newCaseValue;

  SummaryUpdateCard({
    Key key,
    this.title,
    this.value,
    this.icon,
    this.color,
    this.newCaseValue,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SummaryUpdateCardState();
  }
}

class _SummaryUpdateCardState extends State<SummaryUpdateCard>
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
    return LayoutBuilder(builder: (context, constraints) {
      return Material(
          color: backgroundColor,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          color: widget.color,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8))),
                      child: Icon(
                        widget.icon,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(widget.title),
                                AnimatedBuilder(
                                  animation: animationController,
                                  builder: (BuildContext context, Widget child) {
                                    return Text(
                                        NumberUtil()
                                            .setDecimalFormat(_valueAnimator(widget.value)),
                                        style: TextStyle(
                                            fontSize: 26,
                                            fontWeight: FontWeight.bold));
                                  },
                                )
                              ],
                            ),
                            Visibility(
                              visible: widget.newCaseValue != 0,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Icon(
                                    IconData(
                                        widget.newCaseValue > 0 ? 0xe9e2 : 0xe98c,
                                        fontFamily: "icomoon"),
                                    size: 12,
                                    color: widget.newCaseValue < 0
                                        ? RedColor
                                        : GreenColor,
                                  ),
                                  Text(NumberUtil().setDecimalFormat(_valueAnimator(widget.newCaseValue.abs())),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: widget.newCaseValue < 0
                                              ? RedColor
                                              : GreenColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )

                  ],
                )),
          ));
    });
  }
  
  int _valueAnimator(int value)
  {
    return IntTween(begin: 0, end: value).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut)).value;
  }
}
