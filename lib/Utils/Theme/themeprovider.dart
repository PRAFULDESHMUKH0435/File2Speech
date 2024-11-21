import 'package:flutter/material.dart';
import 'package:texttospeech/Utils/Theme/theme.dart';

class ThemeProvider with ChangeNotifier{

  ThemeData _themeData = lighttheme;
  
  ThemeData get themeData =>_themeData;

  set themeData(ThemeData themeData){
    _themeData=themeData;
    notifyListeners();
  }


  toggleTheme(){
    if(_themeData==lighttheme){
      themeData=darktheme;
    }else{
      themeData=lighttheme;
    }
    notifyListeners();
  }

  
}