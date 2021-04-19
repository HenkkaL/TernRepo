import 'package:flutter/material.dart';

class ObservationForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ObservationForm();
}

class _ObservationForm extends State<ObservationForm> {
  final double _formDistance = 5.0;
  String note = '';
  String _birdName = '';
  TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline6;
    return Material(
      child: Container(
          padding: EdgeInsets.all(_formDistance),
          color: Colors.grey,
          child: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(
                      top: _formDistance, bottom: _formDistance),
                  child: DropdownButton<String>(
                    value: _birdName,
                    items: <String>['', 'Lokki', 'Naakka', 'Tiira']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      _setBirdName(newValue);
                    },
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      top: _formDistance, bottom: _formDistance),
                  child: TextField(
                      controller: noteController,
                      maxLines: 3,
                      decoration: InputDecoration(
                          labelText: 'Muistiinpanot',
                          hintText: 'Lisää muistiinpano...',
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))))),
              Padding(
                  padding: EdgeInsets.only(
                      top: _formDistance, bottom: _formDistance),
                  child: ElevatedButton(
                      child: Text(
                        "Tallenna",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            fontSize: 30.0,
                            decoration: TextDecoration.none,
                            fontFamily: 'UbuntuMono',
                            fontWeight: FontWeight.normal),
                      ),
                      style:
                          ElevatedButton.styleFrom(primary: Colors.lightGreen),
                      onPressed: () {
                        setState(() {
                          note = noteController.text;
                        });
                      })),
            ],
          )),
    );
  }

  void _setBirdName(String value) {
    setState(() {
      this._birdName = value;
    });
  }
}
