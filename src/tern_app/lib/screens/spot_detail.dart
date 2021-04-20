import 'package:flutter/material.dart';
import './spots.dart';
import '../data/shared_prefs.dart';
import '../data/moor_db.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SpotDetailScreen extends StatefulWidget {
  final Spot spot;
  final isNew;

  SpotDetailScreen(this.spot, this.isNew);

  @override
  _SpotDetailScreenState createState() => _SpotDetailScreenState();
}

class _SpotDetailScreenState extends State<SpotDetailScreen> {
  int settingColor = 0xff1976d2;
  double fontSize = 16;
  SPSettings settings;

  TextEditingController txtDate = TextEditingController();
  TextEditingController txtDescription = TextEditingController();
  DateFormat formatter;
  @override
  void initState() {
    settings = SPSettings();
    settings.init().then((value) {
      setState(() {
        settingColor = settings.getColor();
        fontSize = settings.getFontSize();
      });
    });
    formatter = DateFormat('dd/MM/yyyy');
    String spotDate =
        (widget.spot.date != null) ? formatter.format(widget.spot.date) : '';
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
              date: (txtDate.text != '') ? formatter.parse(txtDate.text) : null,
              description: txtDescription.text,
            );
            if (widget.isNew) {
              ternDb.insertSpot(updated);
            } else {
              ternDb.updateSpot(updated);
            }
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => SpotsScreen()));
          }),
    );
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
