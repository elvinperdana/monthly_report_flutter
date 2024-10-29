import 'package:intl/intl.dart';

String thousandFormatter(int value) {
  final formatter = NumberFormat('#,##0');
  return formatter.format(value);
}