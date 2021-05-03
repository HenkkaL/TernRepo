import 'package:flutter/material.dart';
import 'package:tern_app/models/bird_library.dart';
import 'package:tern_app/screens/home_screen.dart';
import 'package:tern_app/services/bird_service.dart';
import '../data/shared_prefs.dart';
import '../data/moor_db.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SpotDetailScreen extends StatefulWidget {
  final Spot spot;
  final isNew;
  final homeScreenTabIndex;

  SpotDetailScreen(this.spot, this.isNew, this.homeScreenTabIndex);

  @override
  _SpotDetailScreenState createState() => _SpotDetailScreenState();
}

class _SpotDetailScreenState extends State<SpotDetailScreen> {
  BirdService _birdService = BirdService();
  List<Bird> birds;
  Bird bird = new Bird(id: 0, nameFin: 'Valitse lintu');
  int settingColor = 0xff1976d2;
  double fontSize = 16;
  SPSettings settings;

  TextEditingController txtDate = TextEditingController();
  TextEditingController txtDescription = TextEditingController();
  DateFormat formatter;
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
    formatter = DateFormat('dd/MM/yyyy');
    String spotDate = (widget.spot.date != null)
        ? formatter.format(widget.spot.date)
        : formatter.format(DateTime.now());
    txtDate.text = spotDate;
    txtDescription.text = widget.spot.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TernDb ternDb = Provider.of<TernDb>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Havainto'),
        backgroundColor: Color(settingColor),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.only(top: 3.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(bird.nameFin, textAlign: TextAlign.center),
                    ),
                    Expanded(
                      child: Ink(
                        decoration: const ShapeDecoration(
                          color: Colors.lightBlueAccent,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.search_rounded),
                          tooltip: 'Valitse lintu',
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Valitse lintu',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      color: Colors.blueAccent,
                                    ),
                                    content:
                                        setupAlertDialoadContainer(context),
                                  );
                                });
                          },
                        ),
                      ),
                    ),
                  ],
                )),
            SpotText('Pvm', txtDate, fontSize, 1),
            SpotText('Muistiinpano', txtDescription, fontSize, 5),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
          backgroundColor: Color(settingColor),
          onPressed: () {
            Spot updated = Spot(
              id: (widget.isNew) ? null : widget.spot.id,
              birdId: (bird.id == 0 ? null : bird.id),
              date: (txtDate.text != '') ? formatter.parse(txtDate.text) : null,
              description: txtDescription.text,
            );
            if (widget.isNew) {
              ternDb.insertSpot(updated);
            } else {
              ternDb.updateSpot(updated);
            }
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen(
                          initIndex: widget.homeScreenTabIndex,
                        )));
          }),
    );
  }

  Widget setupAlertDialoadContainer(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: Colors.grey,
          height: 300.0, // Change as per your requirement
          width: 300.0, // Change as per your requirement
          child: ListView.builder(
            itemCount: birds.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Card(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(birds[index].nameFin),
                )),
                onTap: () {
                  setState(() {
                    bird = birds[index];
                    Navigator.pop(context);
                  });
                },
              );
            },
          ),
        ),
        // Align(
        //   alignment: Alignment.bottomRight,
        //   child: FlatButton(
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //     child: Text("Peruuta"),
        //   ),
        // )
      ],
    );
  }

  Future getBirds() async {
    if (!_birdService.isInitialized) await _birdService.initializeService();
    setState(() {
      birds = _birdService.birds(true);
      if (widget.spot.id != null && widget.spot.birdId > 0)
        bird = birds.firstWhere((bird) => bird.id == widget.spot.birdId);
    });
  }
}

class SpotText extends StatelessWidget {
  final String description;
  final TextEditingController controller;
  final double textSize;
  final int numLines;

  SpotText(this.description, this.controller, this.textSize, this.numLines);

  @override
  Widget build(BuildContext context) {
    TextInputType textInputType;
    if (numLines > 1) {
      textInputType = TextInputType.multiline;
    } else if (this.description == 'Pvm') {
      textInputType = TextInputType.datetime;
    } else {
      textInputType = TextInputType.text;
    }

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: TextField(
        controller: controller,
        keyboardType: textInputType,
        maxLines: numLines,
        style: TextStyle(
          fontSize: textSize,
        ),
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            hintText: description),
      ),
    );
  }
}
