import 'package:flutter/material.dart';

import 'CountryList.dart';
import 'Util/Colors.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(16),
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
      child: Material(
          borderRadius: BorderRadius.circular(8),
          child: Ink(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8)
            ),
            child:InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CountryList()),
                  );
                },
                child:  Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(IconData(0xe9cc, fontFamily: "icomoon"),
                          color: TextLightColor, size: 20),
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                      ),
                      Text("Search your country",
                          style: TextStyle(color: TextLightColor)),
                    ],
                  ),
                ),

            ) ,
          )
          ),
    );
  }
}
