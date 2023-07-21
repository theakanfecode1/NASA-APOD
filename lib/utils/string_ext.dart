import 'package:intl/intl.dart';

extension StringExt on String{
  String get capitalizeFirst {
    return  this[0].toUpperCase() + substring(1);
  }

  String get getFormatDate{
    return DateFormat.yMMMd().format(DateTime.parse(this));
}
}