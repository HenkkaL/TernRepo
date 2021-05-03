import 'package:flutter/material.dart';

class TernImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //image from https://openclipart.org/detail/315800/tern
    AssetImage ternAsset = AssetImage('images/tern.png');
    Image image = Image(
      image: ternAsset,
      width: 200.0,
    );
    return Container(child: image);
  }
}
