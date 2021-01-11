import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

  //CLARO
  ThemeData light = ThemeData(

    brightness: Brightness.light,
    primaryColor: Color(0xFFF9F9FF),//0xFFE1E1E4
    accentColor: Color(0xFF0272AF), //0xFF259045 VRD
    scaffoldBackgroundColor: Color(0xFFF9F9FF),

    cardTheme: CardTheme(
      color: Color(0xFFF6F6FC), //0xFFFAFAFC
    ),

    dialogTheme: DialogTheme(
      backgroundColor: Color(0xFFF9F9FF),
    ),

    inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: Colors.black),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF0272AF))
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF282828)))
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFFF9F9FF),
      selectedLabelStyle: TextStyle(color: Colors.black),
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey[400],
      showUnselectedLabels: true,
    ),

    bottomAppBarColor:Color(0xFFE7E7EF),//Color(0xFFE0E0E4)
    bottomSheetTheme: BottomSheetThemeData(modalBackgroundColor: Color(0xFFF8F8FC))//0xFFF6F6FA
  );



  //ESCURO
  ThemeData dark = ThemeData(

    brightness: Brightness.dark,
    primaryColor: Color(0xFF202124),//0xFF35363A
    accentColor: Color(0xFF0272AF),//Colors.teal
    scaffoldBackgroundColor: Color(0xFF202124),

    cardTheme: CardTheme(
        color: Color(0xFF29292C)//Color(0xFF2A2A2D)
    ),

    dialogTheme: DialogTheme(
        backgroundColor: Color(0xFF202020)
    ),

    inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: Colors.white),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF0272AF))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF282828)))
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF202124),
      selectedLabelStyle: TextStyle(color: Colors.white),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey[800],
      showUnselectedLabels: true,
    ),

    bottomAppBarColor:Color(0xFF303134),

    bottomSheetTheme: BottomSheetThemeData(modalBackgroundColor: Color(0xFF2A2A2D))

  );


class ThemeNotifier extends ChangeNotifier{

  final String key = 'valorTema';
  SharedPreferences prefs;
  bool _darkTheme;

  bool get darkTheme => _darkTheme;

  ThemeNotifier(){
    _darkTheme = true;
    _loadFromPrefs();
  }

  toggleTheme(){
    _darkTheme = !_darkTheme;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async{
    if(prefs == null){
      prefs = await SharedPreferences.getInstance();
    }
  }

  _loadFromPrefs() async{
    await _initPrefs();
    _darkTheme = prefs.getBool(key) ?? true;
    notifyListeners();
  }

  _saveToPrefs() async{
    await _initPrefs();
    prefs.setBool(key, _darkTheme);
  }
}


