import 'package:flutter/material.dart';

class CardView extends StatelessWidget {
  Widget child;

  CardView({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Container(
            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.all(24.0),
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
            child: child,
          ),
        ),
      ],
    );
  }
}