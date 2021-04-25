import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tern_app/data/moor_db.dart';
import 'package:tern_app/models/bird_library.dart';
import 'package:tern_app/screens/spot_detail.dart';
import 'package:tern_app/screens/spots.dart';
import 'package:tern_app/services/bird_service.dart';
import 'package:tern_app/widgets/shared/app_bottom_navigation_bar.dart';
import '../data/shared_prefs.dart';
import '../screens/settings.dart';
import '../tern_util.dart';
import 'TernImage.dart';

class HomeScreen extends StatefulWidget {
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
  @override
  void initState() {
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
    TernDb spotDb = Provider.of<TernDb>(context);
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
                  children: <Widget>[
                    TernImageWidget(),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 20.0),
                        child: FutureBuilder(
                          future: spotDb.getSpots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              spots = snapshot.data;
                            } else {
                              spots = List.empty();
                            }

                            return Container(
                              color: Colors.grey,
                              height: 300.0, // Change as per your requirement
                              width: 300.0, // Change as per your requirement
                              child: ListView.builder(
                                itemCount: spots.length,
                                itemBuilder: (context, index) {
                                  DateFormat formatter =
                                      DateFormat('dd/MM/yyyy');
                                  String spotDate = (spots[index].date != null)
                                      ? formatter.format(spots[index].date)
                                      : '';
                                  return Dismissible(
                                    key: Key(spots[index].id.toString()),
                                    onDismissed: (direction) {
                                      spotDb.deleteSpot(spots[index]);
                                    },
                                    child: ListTile(
                                      title: Text(
                                          birds
                                              .firstWhere((bird) =>
                                                  bird.id ==
                                                  spots[index].birdId)
                                              .nameFin,
                                          style: TextStyle(
                                            fontSize: fontSize,
                                          )),
                                      subtitle: Text(spotDate,
                                          style: TextStyle(
                                            fontSize: fontSize * 0.6,
                                          )),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SpotDetailScreen(
                                                        spots[index], false)));
                                      },
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                )),
            floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                backgroundColor: Color(settingColor),
                onPressed: () {
                  Spot spot =
                      Spot(id: 0, birdId: 0, date: null, description: '');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SpotDetailScreen(spot, true)));
                }),
            bottomNavigationBar:
                AppBottomNavigationBar(currentScreen: TernUtil.HOME));
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
