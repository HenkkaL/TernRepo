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
    if (widget.initIndex > 0) _currentIndex = widget.initIndex;
    getBirds();
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
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(settingColor),
              title: Text('TiiraaTiiraa'),
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Text('Valikko',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                        )),
                    decoration: BoxDecoration(
                      color: Color(settingColor),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Asetukset',
                      style: TextStyle(
                        fontSize: fontSize,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsScreen()));
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Havainnot',
                      style: TextStyle(
                        fontSize: fontSize,
                      ),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
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
}
