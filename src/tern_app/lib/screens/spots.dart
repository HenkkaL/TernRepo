import 'package:flutter/material.dart';
import '../data/shared_prefs.dart';
import './spot_detail.dart';
import '../data/moor_db.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SpotsScreen extends StatefulWidget {
  @override
  _SpotsScreenState createState() => _SpotsScreenState();
}

class _SpotsScreenState extends State<SpotsScreen> {
  int settingColor = 0xff1976d2;
  double fontSize = 16;
  SPSettings settings;
  List<Spot> spots;
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
    TernDb spotDb = Provider.of<TernDb>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Havainnot'),
        backgroundColor: Color(settingColor),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Color(settingColor),
          onPressed: () {
            Spot spot = Spot(id: 0, date: null, description: '');
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SpotDetailScreen(spot, true)));
          }),
      body: FutureBuilder(
        future: spotDb.getSpots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            spots = snapshot.data;
          } else {
            spots = List.empty();
          }

          return ListView.builder(
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
                  title: Text('linnun nimi'),
                  subtitle: Text(spotDate),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SpotDetailScreen(spots[index], false)));
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
