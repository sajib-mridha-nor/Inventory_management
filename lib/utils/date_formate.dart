import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

String dateConvert(date){

    DateTime converDate=DateTime.parse(date);

                             var formateDate=   DateFormat.yMMMMd().format(converDate);

  return formateDate;
}

String formtime(date){


  return Jiffy.parse(date).fromNow();
}
String onlyTime(time){


  return DateFormat.Hms().format(time);
}