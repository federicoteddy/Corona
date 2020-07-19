import 'package:intl/intl.dart';

class DateUtils {
  String dateToDateTime(String value) {
    print("date = "+value);
    DateFormat dateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
    DateFormat dateFormat2 = DateFormat("dd MMM yyyy hh:mm:ss");
    DateTime dateTime = dateFormat.parse(value,true);
    print("dateTime "+dateTime.toLocal().toString());
    return dateFormat2.format(dateTime.toLocal());
  }
}
