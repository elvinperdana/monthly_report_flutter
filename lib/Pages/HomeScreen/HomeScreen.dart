import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:go_router/go_router.dart";
import 'package:montly_report_flutter/Utils/utils.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.useRouter = false});

  final bool useRouter;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _totalIncome = 0;
  int _totalExpense = 0;
  int _remaining = 0;

  void initState() {
    super.initState();
    // _initializeDatabase();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            top: true,
            child: Column(
              children: [
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: [
                    Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        decoration: const BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(8.0),
                              right: Radius.circular(8.0)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Income (+)',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            Text('Rp ${thousandFormatter(_totalIncome)}',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ],
                        )),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        decoration: const BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(8.0),
                              right: Radius.circular(8.0)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Expense (-)',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            Text('Rp ${thousandFormatter(_totalExpense)}',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ))
                  ],
                )
              ],
            )
            /*Column(
          children: [
            Container(
              margin:
              const EdgeInsets.only(top: 5.0, left: 15.0, right: 15.0),
              child: Column(
                children: [
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: [
                      Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          decoration: const BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(8.0),
                                right: Radius.circular(8.0)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Income (+)',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              Text('Rp ${thousandFormatter(_totalIncome)}',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ],
                          )),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          decoration: const BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(8.0),
                                right: Radius.circular(8.0)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Expense (-)',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              Text('Rp ${thousandFormatter(_totalExpense)}',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ))
                    ],
                  ),
                  const SizedBox(height: 5),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(8.0),
                            right: Radius.circular(8.0)),
                      ),
                      child: Text('(Σ) : Rp ${thousandFormatter(_remaining)}',
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold))),
                ],
              ),
            ),*/
            ),
      );
}
