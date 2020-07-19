import 'package:coronaApp/model/Countries.dart';

import 'Global.dart';

class Summary {
  Global global;
  List<Countries> countries;

  Summary({this.global, this.countries});

  Summary.fromJson(Map<dynamic, dynamic> json) {
    global = Global.fromJson(json['Global']);
    countries = (json['Countries'] as List).map((e) => Countries.fromJson(e)).toList();
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['Global'] = this.global;
    data['Countries'] = this.countries;
    return data;
  }
}
