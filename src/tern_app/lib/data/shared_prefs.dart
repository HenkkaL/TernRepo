import 'package:event/event.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class SPSettings {
  static SPSettings _instance;
  final String fontSizeKey = 'font_size';
  final String colorKey = 'color';

  final settingsChanged = Event<SettingsChanged>();
  static SharedPreferences _sp;

  factory SPSettings() {
    if (_instance == null) {
      _instance = SPSettings._internal();
    }
    return _instance;
  }
  SPSettings._internal();
  Future init() async {
    _sp = await SharedPreferences.getInstance();
  }

  Future setColor(int color) {
    var success = _sp.setInt(colorKey, color);
    settingsChanged.broadcast(SettingsChanged());
    return success;
  }

  int getColor() {
    int color = _sp.getInt(colorKey);
    if (color == null) {
      return 0xff1976D2; //blue
    } else {
      return color;
    }
  }

  Future setFontSize(double size) {
    var success = _sp.setDouble(fontSizeKey, size);
    settingsChanged.broadcast(SettingsChanged());
    return success;
  }

  double getFontSize() {
    double fontSize = _sp.getDouble(fontSizeKey);
    if (fontSize == null) {
      fontSize = 14;
    }
    return fontSize;
  }
}

class SettingsChanged extends EventArgs {}
