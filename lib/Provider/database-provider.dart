import 'package:flutter/material.dart';
import 'package:montly_report_flutter/Provider/date-provider.dart';
import "package:sqflite/sqflite.dart";
import 'package:path/path.dart' as p;
import 'dart:io';

/*
class DatabaseProvider with ChangeNotifier {
  List _reports = [];
  Database? _database;
  final DateProvider dateProvider;

  DatabaseProvider(this.dateProvider) {
    // Listen to changes in DateProvider
    dateProvider.addListener(_updateReportBasedOnDate);
  }

  List get reports => _reports;

  Future<void> updateReport() async {
    final int dataMonth = dateProvider.month;
    final int dataYear = dateProvider.year;
    final firstDayOfMonth = DateTime(dataMonth, dataYear, 1).millisecondsSinceEpoch;
    final lastDayOfMonth =
        DateTime(dataMonth, dataYear + 1, 0, 23, 59).millisecondsSinceEpoch;

    _reports = await _database!.query(
      'reports',
      where: "dateTime BETWEEN ? AND ?",
      whereArgs: [firstDayOfMonth, lastDayOfMonth],
      orderBy: "dateTime DESC",
    ) as List;

    notifyListeners();
  }

  Future<void> initializeDatabase() async {
    final databasePath = p.join(await getDatabasesPath(), 'monthly_report.db');
    final file = File(databasePath);
    if (await file.exists()) {
      await file.delete(); // Delete the old database
    }

    _database = await openDatabase(
      databasePath,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE reports(id INTEGER PRIMARY KEY, amount INTEGER, description TEXT, dateTime INTEGER, type TEXT)',
        );
        db.execute(
          'CREATE TABLE categories(id INTEGER PRIMARY KEY, name TEXT UNIQUE)',
        );
      },
      version: 1,
    );
  }

  void _updateReportBasedOnDate() {
    // Call updateReport with the current date from DateProvider
    updateReport(month: dateProvider.month, year: dateProvider.year);
  }
}*/
class DatabaseProvider with ChangeNotifier {
  List _reports = [];
  Database? _database;
  final DateProvider dateProvider;

  DatabaseProvider(this.dateProvider) {
    dateProvider.addListener(_updateReportBasedOnDate);
  }

  List get reports => _reports;

  Future<void> updateReport({int? month, int? year}) async {
    final int dataMonth = month ?? dateProvider.month;
    final int dataYear = year ?? dateProvider.year;

    final firstDayOfMonth = DateTime(dataYear, dataMonth, 1).millisecondsSinceEpoch;
    final lastDayOfMonth = DateTime(dataYear, dataMonth + 1, 0, 23, 59).millisecondsSinceEpoch;

    _reports = await _database!.query(
      'reports',
      where: "dateTime BETWEEN ? AND ?",
      whereArgs: [firstDayOfMonth, lastDayOfMonth],
      orderBy: "dateTime DESC",
    ) as List;

    notifyListeners();
  }

  Future<void> initializeDatabase() async {
    final databasePath = p.join(await getDatabasesPath(), 'monthly_report.db');
    final file = File(databasePath);
    if (await file.exists()) {
      await file.delete(); // Delete the old database
    }

    _database = await openDatabase(
      databasePath,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE reports(id INTEGER PRIMARY KEY, amount INTEGER, description TEXT, dateTime INTEGER, type TEXT)',
        );
        db.execute(
          'CREATE TABLE categories(id INTEGER PRIMARY KEY, name TEXT UNIQUE)',
        );
      },
      version: 1,
    );
  }

  void _updateReportBasedOnDate() {
    updateReport(month: dateProvider.month, year: dateProvider.year);
  }

  @override
  void dispose() {
    dateProvider.removeListener(_updateReportBasedOnDate);
    super.dispose();
  }
}
