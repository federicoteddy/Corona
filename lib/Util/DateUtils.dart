import 'package:intl/intl.dart';

class DateUtils {
  var dateFullFormat = "EEE, dd MMM yyyy hh:mm:ss";
  var ddMm = "dd/MM";

  String dateToDateTime(String value,String toFormat) {
    print("date = "+value);
    DateFormat dateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
    DateFormat dateFormat2 = DateFormat(toFormat);
    DateTime dateTime = dateFormat.parse(value,true);
    print("dateTime "+dateTime.toLocal().toString());
    return dateFormat2.format(dateTime.toLocal());
  }
}
