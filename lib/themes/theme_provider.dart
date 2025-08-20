import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dark_mode.dart';
import 'light_mode.dart';

class ThemeProvider extends ChangeNotifier{
  // initially theme is light
  ThemeData _themeData = lightMode;

  //get theme
  ThemeData get theme => _themeData;

  //dark mode
  bool get isDarkMode => _themeData == darkMode;

  //set theme
  set themeData(ThemeData themeData){
    _themeData = themeData;

    //update UI
    notifyListeners();
  }

  //switch the theme
  void swithTheme(){
    if(_themeData == lightMode){
      themeData = darkMode;
    }else{
      themeData = lightMode;
    }
  }
}