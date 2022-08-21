import 'package:absensi_project/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:absensi_project/constans.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Absensi',
        theme: ThemeData(
          primaryColor: primaryColor,
          scaffoldBackgroundColor: Colors.white
        ),
        home: HomePage() ,
    );
  }
}
