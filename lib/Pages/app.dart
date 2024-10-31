import "package:flutter/material.dart";
import "package:montly_report_flutter/Pages/HomeScreen/HomeScreen.dart";
import "package:montly_report_flutter/Pages/ListReportScreen/ListReportScreen.dart";
import "package:montly_report_flutter/Provider/database-provider.dart";
import "package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart";
import "package:provider/provider.dart";

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final PersistentTabController _controller = PersistentTabController();

  @override
  void initState() {
    super.initState();
    Provider.of<DatabaseProvider>(context, listen: false).initializeDatabase();
    Provider.of<DatabaseProvider>(context, listen: false).updateReport();
  }

  List<PersistentTabConfig> _tabs() => [
    PersistentTabConfig(
      screen: const HomeScreen(),
      item: ItemConfig(
        icon: const Icon(Icons.home),
        title: "Home",
        activeForegroundColor: Colors.white,
        inactiveForegroundColor: Colors.grey,
      ),
    ),
    PersistentTabConfig(
      screen: ListReportScreen(),
      item: ItemConfig(
        icon: const Icon(Icons.list),
        title: "List",
        activeForegroundColor: Colors.white,
        inactiveForegroundColor: Colors.grey,
      ),
    ),
    PersistentTabConfig(
      screen: const HomeScreen(),
      item: ItemConfig(
        icon: const Icon(Icons.category),
        title: "Category",
        activeForegroundColor: Colors.white,
        inactiveForegroundColor: Colors.grey,
      ),
    ),
    PersistentTabConfig(
      screen: const HomeScreen(),
      item: ItemConfig(
        icon: const Icon(Icons.settings),
        title: "Settings",
        activeForegroundColor: Colors.white,
        inactiveForegroundColor: Colors.grey,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) => PersistentTabView(
    controller: _controller,
    tabs: _tabs(),
    navBarBuilder: (navBarConfig) => Style11BottomNavBar(
      navBarConfig: navBarConfig,
      navBarDecoration: const NavBarDecoration(
        color: Colors.black,
        // borderRadius: BorderRadius.circular(25),
      ),
      itemAnimationProperties: const ItemAnimation(),
    ),
    backgroundColor: Colors.green,
    margin: EdgeInsets.zero,
    avoidBottomPadding: true,
    handleAndroidBackButtonPress: true,
    resizeToAvoidBottomInset: true,
    stateManagement: false,
    hideNavigationBar: false,
    popAllScreensOnTapOfSelectedTab: true,

    // Floating button top on the navbar bottom
    /*floatingActionButton: FloatingActionButton(
      onPressed: () => showDialog(
        context: context,
        builder: (context) => Dialog(
          child: SettingsView(
            settings: settings,
            onChanged: (newSettings) => setState(() {
              settings = newSettings;
            }),
          ),
        ),
      ),
      child: const Icon(Icons.settings),
    ),*/

    // the widget that will appear when handleAndroidBackButtonPress = false and user tap the back button in their phone
    /*onWillPop: (context) async {
      await showDialog(
        context: context,
        builder: (context) => Dialog(
          child: Center(
            child: ElevatedButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      );
      return false;
    },*/

  );
}