import 'package:flutter/material.dart';

class AddObservationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var button = Container(
        margin: EdgeInsets.only(top: 50),
        child: ElevatedButton(
            child: Text(
              "Uusi lintuhavainto!",
              textDirection: TextDirection.ltr,
              style: TextStyle(
                  fontSize: 30.0,
                  decoration: TextDecoration.none,
                  fontFamily: 'UbuntuMono',
                  fontWeight: FontWeight.normal),
            ),
            style: ElevatedButton.styleFrom(primary: Colors.lightGreen),
            onPressed: () {
              addObservation(context);
            }));
    return button;
  }

  void addObservation(BuildContext context) {
    var alert = AlertDialog(
      title: Text("Lisätään uusi havainto!"),
      content: Text("Onneksi olkoon!"),
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }
}
