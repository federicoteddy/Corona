
import 'package:coronaApp/Util/NumberUtil.dart';
import 'package:flutter/material.dart';

class GlobalCaseCard extends StatelessWidget {
  String title;
  int value;
  IconData icon;
  Color color;

  GlobalCaseCard({
    Key key,
    this.title,
    this.value,
    this.icon,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: constraints.maxWidth / 2 -10,
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      size: 16,
                      color: color,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(title,
                      style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold)),
                  Text(
                    NumberUtil().setDecimalFormat(value),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle( fontSize: 24,fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text("+10%",
                      style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),

          );
        }
    );
  }
}