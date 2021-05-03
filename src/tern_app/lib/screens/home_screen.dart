import 'package:flutter/material.dart';
import 'package:tern_app/data/moor_db.dart';
import 'package:tern_app/models/bird_library.dart';
import 'package:tern_app/screens/home_tab.dart';
import 'package:tern_app/screens/spot_detail_screen.dart';
import 'package:tern_app/screens/spots_tab.dart';
import 'package:tern_app/services/bird_service.dart';
import '../data/shared_prefs.dart';
import 'settings_screen.dart';
import '../tern_util.dart';

class HomeScreen extends StatefulWidget {
  final int initIndex;

  const HomeScreen({Key key, this.initIndex}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BirdService _birdService = BirdService();
  List<Bird> birds;
  List<Spot> spots;
  int settingColor = 0xff1976d2;
  double fontSize = 16;
  SPSettings settings;

  int _currentIndex = 0;
  final tabs = [HomeTab(), SpotsTab()];

  @override
  void initState() {
    if (widget.initIndex == null)
      _currentIndex = 0;
    else
      _currentIndex = widget.initIndex;
    getBirds();
    settings = SPSettings();
    settings.init().then((value) {
      setState(() {
        settingColor = settings.getColor();
        fontSize = settings.getFontSize();
      });
    });
    settings.settingsChanged.subscribe((args) => settingsChanged());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(settingColor),
              title: Text('TiiraaTiiraa'),
              actions: <Widget>[
                PopupMenuButton(
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                          child: Text(TernUtil.SETTINGS),
                          value: TernUtil.SETTINGS)
                    ];
                  },
                  onSelected: (value) => changeScreen(context, value),
                )
              ],
            ),
            body: tabs[_currentIndex],
            floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                backgroundColor: Color(settingColor),
                onPressed: () {
                  Spot spot =
                      Spot(id: 0, birdId: 0, date: null, description: '');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SpotDetailScreen(spot, true, _currentIndex)));
                }),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Color(settingColor),
              selectedFontSize: fontSize * 1.5,
              unselectedFontSize: fontSize * 1.3,
              currentIndex: _currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: TernUtil.HOME,
                  //backgroundColor: Color(settingColor)
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard),
                  label: TernUtil.SPOTS,
                  //
                )
              ],
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ));
      },
    );
  }

  Future getBirds() async {
    if (!_birdService.isInitialized) await _birdService.initializeService();
    setState(() {
      birds = _birdService.birds(true);
    });
  }

  changeScreen(BuildContext context, value) {
    if (value == TernUtil.SETTINGS) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SettingsScreen()));
    }
  }

  void settingsChanged() {
    setState(() {
      settingColor = settings.getColor();
        fontSize = settings.getFontSize();
    });
  }
}
