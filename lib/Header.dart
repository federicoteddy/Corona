import 'package:flutter/material.dart';

import 'Util/Colors.dart';

class Header extends StatefulWidget {
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        padding: EdgeInsets.only(top: 50, right: 20),
        height: 320,
        width: double.infinity,
        color: PrimaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
                alignment: Alignment.topRight,
                child:  Icon(IconData(0xe9c3, fontFamily: "icomoon"),
                    color: Colors.white)),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Image.asset("assets/images/people.png",
                      alignment: Alignment.centerLeft),
                  SizedBox(height: 20),
                  Positioned(
                    top: 80,
                    left: 180,
                    child: Text(
                      "All you need \nis stay at home",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  Container()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}



