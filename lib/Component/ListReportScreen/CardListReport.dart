import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:montly_report_flutter/Utils/utils.dart';

class CardReportList extends StatelessWidget {
  final int indexExpense;
  final Map<String, dynamic> dataExpense;

  CardReportList({required this.indexExpense, required this.dataExpense});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          if (indexExpense != 0) const Divider(),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Text(
                  DateFormat("HH:mm").format(
                    DateTime.fromMillisecondsSinceEpoch(
                        dataExpense['dateTime']),
                  ),
                  style: const TextStyle(
                      color: Colors.blueAccent),
                ),
              ),
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        dataExpense['description'] == '' ? '-' : dataExpense['description'],
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  )),
              Text(
                '${dataExpense['type'] == 'Income' ? '+' : '-'} Rp ${thousandFormatter(dataExpense['amount'])}',
                style: TextStyle(
                    color: dataExpense['type'] == 'Income'
                        ? Colors.green
                        : Colors.red),
              )
            ],
          )
        ],
      ),
    );
  }
}