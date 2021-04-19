import 'package:flutter/material.dart';
import './TernImage.dart';
import './ObservationForm.dart';
import './AddObservationButton.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        color: Colors.deepOrangeAccent,
        margin: EdgeInsets.only(top: 30.0),
        padding: EdgeInsets.only(top: 15.0),
        child: Column(
          children: <Widget>[
            TernImageWidget(),
            AddObservationButton(),
            ObservationForm(),
          ],
        ));
  }
}
