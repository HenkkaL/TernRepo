import 'package:flutter/material.dart';
import 'package:tern_app/data/shared_prefs.dart';
import 'package:tern_app/screens/Home.dart';
import 'package:tern_app/screens/spots.dart';

import '../../tern_util.dart';

class AppBottomNavigationBar extends StatefulWidget {
  final String currentScreen;

  AppBottomNavigationBar({this.currentScreen});

  @override
  _AppBottomNavigationBarState createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  int settingColor = 0xff1976d2;
  double fontSize = 16;
  SPSettings settings;
  @override
  void initState() {
    settings = SPSettings();
    settings.init().then((value) {
      setState(() {
        settingColor = settings.getColor();
        fontSize = settings.getFontSize();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BottomNavigationBar bottomNavigationBar = BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color(settingColor),
      currentIndex: widget.currentScreen == TernUtil.HOME ? 0 : 1,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: TernUtil.HOME,
          //backgroundColor: Color(settingColor)
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: TernUtil.SETTINGS,
          //
        )
      ],
      onTap: (value) {
        if (value == 0) {
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        } else {
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SpotsScreen()));
        }
      },
    );
    return bottomNavigationBar;
  }
}
