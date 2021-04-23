import 'package:flutter/material.dart';
import 'package:tern_app/models/bird_library.dart';
import 'package:tern_app/screens/spots.dart';
import 'package:tern_app/services/bird_service.dart';
import '../data/shared_prefs.dart';
import '../screens/settings.dart';
import 'TernImage.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BirdService _birdService = BirdService();
  List<Bird> birds;
  int settingColor = 0xff1976d2;
  double fontSize = 16;
  SPSettings settings;
  @override
  void initState() {
    getBirds();
    settings = SPSettings();
    getSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getSettings(),
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
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SpotsScreen()));
                    },
                  ),
                ],
              ),
            ),
            body: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 15.0),
                child: Column(
                  children: <Widget>[TernImageWidget()],
                )));
      },
    );
  }

  Future getSettings() async {
    settings = SPSettings();
    settings.init().then((value) {
      setState(() {
        settingColor = settings.getColor();
        fontSize = settings.getFontSize();
      });
    });
  }

  Future getBirds() async {
    if (!_birdService.isInitialized) await _birdService.initializeService();
    setState(() {
      birds = _birdService.birds(true);
    });
  }
}
