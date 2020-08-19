import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:t_virus/core/model/survivor.dart';
import 'package:t_virus/ui/shared/app_colors.dart';
import 'package:t_virus/ui/views/main_screen/inventory_screen.dart';
import 'package:t_virus/ui/views/register_survivor/steps/step_survivor_supplies.dart';

import 'traker_screen.dart';

// ignore: must_be_immutable
class MainNavigatorBottomController extends StatefulWidget {
  @override
  _MainNavigatorBottomControllerState createState() =>
      _MainNavigatorBottomControllerState();
  static int pos = 0;
  int positionSelector;

  MainNavigatorBottomController({this.positionSelector});
}

class _MainNavigatorBottomControllerState
    extends State<MainNavigatorBottomController> {
  List<TabItem> tabItems = List.of([
    new TabItem(Icons.map, "Track", accentColor,
        labelStyle: TextStyle(
            color: accentColor,
            fontWeight: FontWeight.w300,
            fontFamily: 'ZOMBIETEXT')),
    new TabItem(Icons.format_indent_increase, "Inventory", accentColor,
        labelStyle: TextStyle(
            color: accentColor,
            fontWeight: FontWeight.w300,
            fontFamily: 'ZOMBIETEXT')),
  ]);

  CircularBottomNavigationController _navigationController =
      CircularBottomNavigationController(MainNavigatorBottomController.pos);

  Widget page;

  @override
  void initState() {
    super.initState();
    if (widget.positionSelector != null) {
      setState(() {
        MainNavigatorBottomController.pos = widget.positionSelector;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    page ??= TrackerScreen();
    return Scaffold(
      backgroundColor: primaryColor,
      body: page,
      bottomNavigationBar: CircularBottomNavigation(
        tabItems,
        controller: _navigationController,
        selectedCallback: (int selectedPos) {
          callPage(selectedPos);
        },
        barBackgroundColor: primaryColor,
      ),
    );
  }

  void callPage(int selectedPos) {
    setState(() {
      MainNavigatorBottomController.pos = selectedPos;
      switch (MainNavigatorBottomController.pos) {
        case 0:
          page = TrackerScreen();
          break;
        case 1:
          page = InventoryScreen();
          break;
      }
    });
  }
}
