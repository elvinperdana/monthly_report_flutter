import 'dart:io';
import 'package:montly_report_flutter/Component/InputNumberWithThousandFormatter.dart';
import 'package:montly_report_flutter/Pages/ListReportScreen/AddEditReportScreen.dart';
import 'package:montly_report_flutter/Component/ListReportScreen/CardListReport.dart';
import 'package:intl/intl.dart';
import 'package:montly_report_flutter/Provider/database-provider.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';

class ListReportScreen extends StatefulWidget {
  ListReportScreen({super.key, this.useRouter = false});

  final bool useRouter;

  @override
  _ListReportScreenState createState() => _ListReportScreenState();
}

class _ListReportScreenState extends State<ListReportScreen> {
  Database? _database;
  int _currentMonth = DateTime.now().month;
  int _currentYear = DateTime.now().year;
  final List<String> typeOption = [
    'All',
    'Expense',
    'Income',
  ];
  String? _typeFilterSelected;

  final TextEditingController typeFilter = TextEditingController();
  String? typeSelectedFilter;

  final TextEditingController iconController = TextEditingController();

  final TextEditingController _selectTypeController =
      TextEditingController(text: 'All');
  final GlobalKey<InputNumberWithThousandFormatterState> _inputFieldKey =
      GlobalKey<InputNumberWithThousandFormatterState>();

  @override
  void initState() {
    super.initState();
    Provider.of<DatabaseProvider>(context, listen: false).initializeDatabase();
    Provider.of<DatabaseProvider>(context, listen: false).updateReport();
    _typeFilterSelected = typeOption.first;
  }

  Future<void> _getData() async {
    final expenseData =   ;

    /*List groupTemp = [];
    int getTotalIncome = 0;
    int getTotalExpense = 0;

    if (expenseData.isNotEmpty) {
      for (var expense in expenseData) {
        String day = DateFormat("d MMMM yyyy").format(
            DateTime.fromMillisecondsSinceEpoch(expense['dateTime'] as int));
        int getIndex =
            groupTemp.indexWhere((dataTemp) => dataTemp['day'] == day);

        if (expense['type'] == 'Income') {
          getTotalIncome = getTotalIncome + (expense['amount'] as int ?? 0);
        } else {
          getTotalExpense = getTotalExpense + (expense['amount'] as int ?? 0);
        }

        if (getIndex != -1) {
          groupTemp[getIndex]['dataExpenses'].add(expense);
        } else {
          groupTemp.add({
            'day': day,
            'dataExpenses': [expense],
          });
        }
      }
    }*/

    setState(() {
/*      _totalExpense = getTotalExpense;
      _totalIncome = getTotalIncome;
      _remaining = getTotalIncome != 0 ? getTotalIncome - getTotalExpense : 0;*/
      _reports = expenseData;
    });
  }

  void _navigateToAddExpense() {
    pushWithoutNavBar(
      context,
      MaterialPageRoute(
          builder: (context) => AddEditReportScreen(
                method: "Add",
                month: _currentMonth,
                year: _currentYear,
                database: _database,
              )),
    ).then((_) {
      setState(() {
        _getData();
      });
    });
  }

  void _changeMonthYear(int month, int year) {
    setState(() {
      _currentMonth = month;
      _currentYear = year;
    });
    _getData();
  }

  List _getDataList() {
    if (_typeFilterSelected == 'All') {
      return Provider.of<DatabaseProvider>(context).reports;
    } else {
      return Provider.of<DatabaseProvider>(context).reports
          .map((data) {
            final filterDataExpense = data['dataExpenses']
                .where((docDataExpense) =>
                    docDataExpense['type'] == _typeFilterSelected)
                .toList();
            if (filterDataExpense.isEmpty) {
              return null;
            } else {
              return {
                ...data,
                'dataExpenses': filterDataExpense,
              };
            }
          })
          .where((item) => item != null)
          .toList();
    }
  }

  String _getMonthYearText() {
    return DateFormat.yMMMM().format(DateTime(_currentYear, _currentMonth));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
/*      appBar: AppBar(
        title: Text(_getMonthYearText()),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: () async {
              final result = await showMonthPicker(
                context: context,
                initialDate: DateTime(_currentYear, _currentMonth),
                firstDate: DateTime(DateTime.now().year - 50),
                lastDate: DateTime(DateTime.now().year + 50),
                confirmWidget: const Text(
                  'Confirm',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                cancelWidget: const Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                monthPickerDialogSettings: const MonthPickerDialogSettings(
                  dialogSettings: PickerDialogSettings(
                    dialogRoundedCornersRadius: 20,
                    dialogBackgroundColor: Color(0xff252525),
                  ),
                  headerSettings: PickerHeaderSettings(
                    headerBackgroundColor: Colors.black,
                    headerSelectedIntervalTextStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    headerCurrentPageTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    previousIcon: Icons.arrow_back,
                    nextIcon: Icons.arrow_forward,
                  ),
                  buttonsSettings: PickerButtonsSettings(
                    buttonBorder: CircleBorder(),
                    selectedMonthBackgroundColor: Colors.grey,
                    selectedMonthTextColor: Colors.black87,
                    unselectedMonthsTextColor: Colors.white,
                    currentMonthTextColor: Colors.blueAccent,
                    yearTextStyle: TextStyle(
                      fontSize: 15,
                    ),
                    monthTextStyle: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              );
              if (result != null) {
                _changeMonthYear(result.month, result.year);
                // _getTotal();
              }
            },
          ),
        ],
      ),*/
      body: SafeArea(
          top: true,
          child: Column(
            children: [
              const SizedBox(height: 10),
              SizedBox(
                height: 46,
                child: Padding(
                    padding:
                        const EdgeInsets.only(right: 15, left: 15, bottom: 7),
                    child: Row(
                      children: [
                        Expanded(
                            child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: typeOption.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  right:
                                      index != typeOption.length - 1 ? 3 : 0),
                              child: ChoiceChip(
                                label: Text(typeOption[index]),
                                selected:
                                    _typeFilterSelected == typeOption[index],
                                onSelected: (bool selected) {
                                  setState(() {
                                    _typeFilterSelected = selected
                                        ? typeOption[index]
                                        : _typeFilterSelected;
                                  });
                                },
                                selectedColor: Colors.blueAccent,
                                backgroundColor: Colors.grey[200],
                                labelStyle: TextStyle(
                                  color:
                                      _typeFilterSelected == typeOption[index]
                                          ? Colors.white
                                          : Colors.black,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      50), // Custom border radius
                                ),
                              ),
                            );
                          },
                        )),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ElevatedButton(
                            onPressed: _navigateToAddExpense,
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              backgroundColor: const Color(0xff252525),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    )),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _getDataList().length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(
                          left: 10.0, right: 10.0, bottom: 10.0),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1.0, color: Colors.grey),
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(15.0),
                          right: Radius.circular(15.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 0.1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                vertical: 7.0, horizontal: 15.0),
                            margin: const EdgeInsets.only(
                                left: 5, right: 5, bottom: 7),
                            decoration: const BoxDecoration(
                              color: Color(0xff2c2c2c),
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(50.0),
                                right: Radius.circular(50.0),
                              ),
                            ),
                            child: Text(
                              "${_getDataList()[index]['day']}",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          // Other items in _getDataList
                          ..._getDataList()[index]['dataExpenses']
                              .asMap()
                              .entries
                              .map<Widget>((entry) {
                            int indexExpense = entry.key;
                            var dataExpense = entry.value;
                            return CardReportList(
                              indexExpense: indexExpense,
                              dataExpense: dataExpense,
                            );
                          }).toList(),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}
