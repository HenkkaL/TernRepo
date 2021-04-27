import 'package:flutter/material.dart';
import 'package:tern_app/models/bird_library.dart';
import 'package:tern_app/services/bird_service.dart';
import '../data/shared_prefs.dart';
import 'spot_detail_screen.dart';
import '../data/moor_db.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SpotsTab extends StatefulWidget {
  @override
  _SpotsTabState createState() => _SpotsTabState();
}

class _SpotsTabState extends State<SpotsTab> {
  BirdService _birdService = BirdService();
  List<Bird> birds;
  int settingColor = 0xff1976d2;
  double fontSize = 16;
  SPSettings settings;
  List<Spot> spots;
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
      future: spotDb.getSpots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          spots = snapshot.data;
        } else {
          spots = List.empty();
        }

        return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 15.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: spots.length,
              itemBuilder: (context, index) {
                DateFormat formatter = DateFormat('dd/MM/yyyy');
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
                            .firstWhere(
                                (bird) => bird.id == spots[index].birdId)
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
                                  SpotDetailScreen(spots[index], false, 1)));
                    },
                  ),
                );
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
