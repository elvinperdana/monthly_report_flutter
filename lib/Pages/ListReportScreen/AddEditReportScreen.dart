import 'package:montly_report_flutter/Component/InputNumberWithThousandFormatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class AddEditReportScreen extends StatefulWidget {
  final int month;
  final int year;
  final Database? database;
  final String method;
  final Map<String, dynamic>? data;

  AddEditReportScreen({
    required this.month,
    required this.year,
    required this.database,
    required this.method,
    this.data,
  });

  @override
  _AddEditReportScreenState createState() => _AddEditReportScreenState();
}

class _AddEditReportScreenState extends State<AddEditReportScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  late DateTime _selectedDate = DateTime.now().millisecondsSinceEpoch >=
              DateTime(widget.year, widget.month, 1, 00, 00)
                  .millisecondsSinceEpoch &&
          DateTime.now().millisecondsSinceEpoch <=
              DateTime(widget.year, widget.month,
                      DateTime(widget.year, widget.month + 1, 0).day, 23, 59)
                  .millisecondsSinceEpoch
      ? DateTime.now()
      : DateTime(widget.year, widget.month, 1, 12, 00);
  final TextEditingController _dateTimeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<InputNumberWithThousandFormatterState> _inputFieldKey =
      GlobalKey<InputNumberWithThousandFormatterState>();

  int _amount = 0;
  String _type = 'Expense';

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    await openDatabase(
      p.join(await getDatabasesPath(), 'monthly_report.db'),
    );
  }

  Future<void> _saveReport() async {
    bool checkValidAmount = _inputFieldKey.currentState!.submit();
    if (!_formKey.currentState!.validate() || !checkValidAmount) {
      return;
    }

    final amount = _amount;
    final description = _descriptionController.text;
    final dateTime = _selectedDate.millisecondsSinceEpoch;
    final type = _type;

    if (widget.database != null) {
      await widget.database!.insert(
        'reports',
        {
          'amount': amount,
          'description': description,
          'dateTime': dateTime,
          'type': type,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Report saved successfully')),
      );

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Database is not initialized')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Report'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Container(
                  padding: const EdgeInsets.all(0),
                  margin: const EdgeInsets.all(0),
                  decoration: const BoxDecoration(
                    color: Color(0xffdddddd),
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(15), right: Radius.circular(15)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          color: _type == "Income"
                              ? Colors.greenAccent
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _type = "Income";
                            });
                          },
                          child: const Text(
                            "Income",
                            style: TextStyle(color: Colors.black87),
                          ),
                        ),
                      )),
                      Expanded(
                          child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          color: _type == "Expense"
                              ? Colors.redAccent
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _type = "Expense";
                            });
                          },
                          child: Text(
                            "Expense",
                            style: TextStyle(
                                color: _type == "Expense"
                                    ? Colors.white
                                    : Colors.black87),
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                InputNumberWithThousandFormatter(
                  key: _inputFieldKey,
                  labelText: 'Amount',
                  hintText: 'Enter amount',
                  isRequired: true,
                  onSubmitted: (value) {
                    setState(() {
                      _amount = value;
                    });
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  focusNode: AlwaysDisabledFocusNode(),
                  controller: _dateTimeController,
                  decoration: const InputDecoration(labelText: 'Date & Time'),
                  onTap: () {
                    _selectDate(context);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                Container(
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Category',
                        ),
                      ),
                      Wrap(
                        children: [],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black87,
                  ),
                  onPressed: _saveReport,
                  child: const Text(
                    'Save Report',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  _selectDate(BuildContext context) async {
    await picker.DatePicker.showDateTimePicker(context,
        showTitleActions: true,
        minTime: DateTime(widget.year, widget.month, 1, 00, 00),
        maxTime: DateTime(
            widget.year,
            widget.month,
            DateTime(widget.year, widget.month + 1, 0).day,
            23,
            59), onConfirm: (date) {
      _dateTimeController.text =
          DateFormat("EEE, d MMM yy, HH:mm").format(date);
      _selectedDate = date;
      _formKey.currentState!.validate();
    }, currentTime: _selectedDate);
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
