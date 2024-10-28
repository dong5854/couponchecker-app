import 'package:intl/intl.dart';

String formatDate(String expireAt) {
  DateTime date = DateTime.parse(expireAt);
  DateFormat formatter = DateFormat('yyyy년 MMMM d일, EEEE', 'ko-KR');
  return formatter.format(date);
}