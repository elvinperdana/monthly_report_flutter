import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:montly_report_flutter/Pages/HomeScreen/HomeScreen.dart';
import 'package:montly_report_flutter/Pages/ListReportScreen/ListReportScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  Widget? _page;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  void initState() {
    _page = ListReportScreen();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: Scaffold(
        body: _page,
        bottomNavigationBar: SizedBox(
          height: 20,
          child: CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: 0,
            items: const <Widget>[
              Icon(Icons.home, size: 30, color: Colors.white),
              Icon(Icons.list, size: 30, color: Colors.white),
              // Icon(Icons.category, size: 30, color: Colors.white),
              // Icon(Icons.perm_identity, size: 30, color: Colors.white),
            ],
            color: const Color(0xff252525),
            buttonBackgroundColor: const Color(0xff252525),
            backgroundColor: Colors.transparent,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 350),
            onTap: (index) {
              setState(() {
                _changeNavigation(index);
              });
            },
            letIndexChange: (index) => true,
          ),
        ),
      ),
    );
  }

  void _changeNavigation(int index) {
    setState(() {
      switch (index) {
        case 0:
          _page = const HomeScreen();
          break;
        case 1:
          _page = ListReportScreen();
          break;
      }

      /*_page = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: Duration(milliseconds: 500),
        child: _page,
      );*/

    });
  }
}
