import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:tern_app/models/bird_library.dart';

class BirdService {
  static final BirdService _instance = BirdService._internal();

  // passes the instantiation to the _instance object
  factory BirdService() => _instance;

  List<Bird> _birds;
  bool _isInitialized;

  BirdService._internal() {
    _isInitialized = false;
  }

  bool get isInitialized => _isInitialized;

  List<Bird> birds(bool commonOnly) {
    if (commonOnly)
      return _birds.where((bird) => bird.isCommon == "TRUE").toList();
    return _birds;
  }

  set setBirds(List<Bird> birds) => _birds = birds;

  Future<void> initializeService() async {
    var byteData = await rootBundle.load('assets/BirdData.json');
    var jsonString = utf8.decode(byteData.buffer.asUint8List());
    Map<String, dynamic> birdListMap = jsonDecode(jsonString);
    var birdLibrary = BirdLibrary.fromJson(birdListMap);

    _birds = birdLibrary.birds;
    _birds.sort((a, b) {
      return a.nameFin.toLowerCase().compareTo(b.nameFin.toLowerCase());
    });
    _isInitialized = true;
  }
}
